Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265403AbUBFKk6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 05:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265398AbUBFKk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 05:40:57 -0500
Received: from disk.smurf.noris.de ([192.109.102.53]:17133 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S265403AbUBFKkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 05:40:55 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: VFS locking: f_pos thread-safe ?
Date: Fri, 06 Feb 2004 11:19:58 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.02.06.10.19.57.885433@smurf.noris.de>
References: <402359E1.6000007@ntlworld.com> <20040206011630.42ed5de1.akpm@osdl.org> <40235DCC.2060606@ntlworld.com> <20040206013523.394d89f1.akpm@osdl.org>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: server.smurf.noris.de 1076062798 22772 192.109.102.35 (6 Feb 2004 10:19:58 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Fri, 6 Feb 2004 10:19:58 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew Morton wrote:
>>  touché :) but still we should do what we can.. want me to make a patch?
> 
> Not unless we can think of a way in which it actually matters, thanks.
> 
I've written one of those... a migration program from an old
fixed-record-size database to SQL. Somebody had the brilliant idea to let
two threads read the file concurrently, postprocess the thing (which took
a variable amount of time depending on what was in the record) and then
feed it to the database (ditto).

When that idea didn't work, I used a separate reader thread and
coordinated buffer usage with semaphores or whatever, making the thing a
whole lot more complicated in the process. :-/

So count me as one of those people who think that it does matter -- if N
threads read a file of M bytes, they should collectively get M bytes from
it (possibly out of order, of course, but that's a different problem).
Anything else would be inconsistent.

Same thing goes for writing (in append mode as well as otherwise).

-- 
Matthias Urlichs
