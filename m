Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265756AbUBFTLm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 14:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265775AbUBFTLC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 14:11:02 -0500
Received: from disk.smurf.noris.de ([192.109.102.53]:55980 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S265756AbUBFTK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 14:10:57 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: VFS locking: f_pos thread-safe ?
Date: Fri, 06 Feb 2004 20:05:48 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.02.06.19.05.47.617416@smurf.noris.de>
References: <20040206041223.A18820@almesberger.net> <20040206183746.GR4902@ca-server1.us.oracle.com>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: server.smurf.noris.de 1076094348 1318 192.109.102.35 (6 Feb 2004 19:05:48 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Fri, 6 Feb 2004 19:05:48 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Joel Becker wrote:

> This reads:  "all of the specified effects of the other call,
> or none of them."  If I read that correctly, if f_pos is at N, and
> threads A and B concurrently read M bytes, then each thread's read()
> must either start at f_pos = N or f_pos = N+M, but never at N < f_pos <
> N+M.  So as long as our code doesn't partially update f_pos, it is
> valid.

Umm, strictly speaking there are three possible valid cases:

thread A reads M @N   thread B reads M @N     file pointer ends up as N+M
thread A reads M @N   thread B reads M @M+N   file pointer ends up as N+2M
thread A reads M @M+N thread B reads M @N     file pointer ends up as N+2M

With your description,
thread A reads M @M+N thread B reads M @M+N   file pointer ends up as N+2M

would be equally valid, which I'd declare buggy ^W non-conforming.

-- 
Matthias Urlichs
