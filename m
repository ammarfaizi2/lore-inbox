Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264363AbTLPW5d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 17:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264367AbTLPW5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 17:57:33 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:35595 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264363AbTLPW5Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 17:57:25 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: crypto-loop + highmen -> random crashes in -test11
Date: 16 Dec 2003 22:45:55 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bro1v3$21d$1@gatekeeper.tmr.com>
References: <20031215223438.196295a8.akpm@osdl.org> <1071570648.3528.50.camel@localhost>
X-Trace: gatekeeper.tmr.com 1071614755 2093 192.168.12.62 (16 Dec 2003 22:45:55 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1071570648.3528.50.camel@localhost>,
Soeren Sonnenburg  <kernel@nn7.de> wrote:

| I get random crashes/corruption/ init kills when I use cryptoloop on
| this highmem enabled ppc machine.
| 
| Applying the loop-* patches at
| http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test10/2.6.0-test10-mm1/broken-out
| 
| seem to fix this problem (at least I did not get any crash due to
| cryptoloop in the last 2 days)

Thank you for identifying this. I have been having perfect results iwth
the systems I have running cryptoloop, but they are both small. Now I
not only know why I don't have problems, I have a way to prevent
problems.

Hopefully this will get into 2.6.0-final, since it fixes a hard fail case.
| 
| Steps to reproduce:
| 
| dd if=/dev/zero of=/file bs=1M count=100
| losetup -e blowfish /dev/loop0 /file
| Password:
| mkfs -t ext3 /dev/loop0
| mount /dev/loop0 /mnt
| cd /mnt  
| dd if=/dev/zero of=bla
| 
| gives you nice unpredictable crashes.
| 
| 
| Soeren
| 
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
| 


-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
