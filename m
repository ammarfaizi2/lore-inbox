Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265463AbUFSK2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265463AbUFSK2S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 06:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265474AbUFSK2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 06:28:18 -0400
Received: from disk.smurf.noris.de ([192.109.102.53]:42928 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S265463AbUFSK2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 06:28:17 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: [PATCH] Stop printk printing non-printable chars
Date: Sat, 19 Jun 2004 12:27:54 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.06.19.10.27.54.8305@smurf.noris.de>
References: <20040618205355.GA5286@newtoncomputing.co.uk> <Pine.LNX.4.58.0406181407330.6178@ppc970.osdl.org> <Pine.LNX.4.56.0406190032290.17899@jjulnx.backbone.dif.dk> <20040618235223.GB5286@newtoncomputing.co.uk> <20040619041844.GG29808@alpha.home.local>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: server.smurf.noris.de 1087640874 24275 192.109.102.35 (19 Jun 2004 10:27:54 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Sat, 19 Jun 2004 10:27:54 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Willy Tarreau wrote:

> Another way to do it would be to display "<XX>" like less, but '<' and '>'
> are sensible because they're used to indicate the log level.

Umm, they're not sensible. (You're mixing up word meanings.)
Log levels are not a big problem, because the log level is always printed
first. Usually.

IMHO, the stuff should make sense to a human reader, and it should be
possible to figure out quickly and unambiguously what the random bit
pattern that inadvertently got printed actually *is*.

That means: Escape anything <\x31 except \n. Escape \\. Escape anything
with the 8th bit set. Use hex escapes \x## -- let's face it, they're as
long as octal and easier to read these days.

-- 
Matthias Urlichs
