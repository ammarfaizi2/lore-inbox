Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbTLCXbh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 18:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbTLCXbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 18:31:37 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:42507 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262603AbTLCXbe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 18:31:34 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: partially encrypted filesystem
Date: 3 Dec 2003 23:20:24 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bqlr3o$khe$1@gatekeeper.tmr.com>
References: <1070485676.4855.16.camel@nucleon> <Pine.LNX.4.53.0312031627440.3725@chaos>
X-Trace: gatekeeper.tmr.com 1070493624 21038 192.168.12.62 (3 Dec 2003 23:20:24 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.53.0312031627440.3725@chaos>,
Richard B. Johnson <root@chaos.analogic.com> wrote:
| On Wed, 3 Dec 2003, Kallol Biswas wrote:
| 
| >
| > Hello,
| >       We have a requirement that a filesystem has to support
| > encryption based on some policy. The filesystem also should be able
| > to store data in non-encrypted form. A search on web shows a few
| > encrypted filesystems like "Crypto" from Suse Linux, but we need a
| > system  where encryption will be a choice per file. We have a hardware
| > controller to apply encryption algorithm. If a filesystem provides hooks
| > to use a hardware controller to do the encryption work then the cpu can
| > be freed from doing the extra work.
| >
| > Any comment on this?
| >
| > Kallol
| > NucleoDyne Systems.
| > nucleon@nucleodyne.com
| > 408-718-8164
| 
| I think you just need your application to encrypt data where needed.
| Or to read/write to an encrypted file-system which always encrypts.
| You really don't want policy inside the kernel.
| 
| Let's say you decided to ignore me and do it anyway. The file-systems
| are a bunch of inodes. Every time you want to read or write one, something
| has to decide if it's encrypted and, if it is, how to encrypt or
| decrypt it. Even the length of the required read or write becomes
| dependent upon the type of encryption being used. Surely you don't
| want to use an algorithm where a N-byte string gets encoded into a
| N-byte string because to do so gives away the length, from which
| one can derive other aspects, resulting in discovering the true content.
| So, you need variable-length inodes --- what a mess. The result
| would be one of the slowest file-systems you could devise.
| 
| Encrypted file-systems, where you encrypt everything that goes
| on the media work. Making something that could be either/or,
| while possible, is not likely going to be very satisfying.

Well said. This isn't the way to do it as you say, although you could
add an O_CRYPTO flag to creat() if you really wanted to.


Crypto in the program is definitely the better solution.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
