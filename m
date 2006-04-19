Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWDSIiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWDSIiY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 04:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWDSIiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 04:38:24 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:32983 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750802AbWDSIiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 04:38:23 -0400
Date: Wed, 19 Apr 2006 10:38:02 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Joe Barr <joe@pjprimer.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: A puzzle: CAPZLOQ TEKNIQ 1.0
In-Reply-To: <Pine.LNX.4.61.0604191028120.12755@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0604191033200.12755@yvahk01.tjqt.qr>
References: <1145128394.19148.9.camel@wartslair.lan>
 <Pine.LNX.4.61.0604191028120.12755@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>The cross-platform viral proof-of-concept in the news last week does
>>indeed infect both Windows and Linux ELF binaries.  At least it does on
>>some kernels.  Some tests show it doesn't work on the latest versions.
>>
>>Hans-Werner Hilse is trying to puzzle out why.  If anyone else wants to
>>play with it and see if they can figure out why it is sometimes viral on
>>Linux and sometimes not, drop me a note offlist.
>

>From LWN/Newsforge:

--->2.6.15.4
[0804744d] open("E", O_RDWR) = 4
...
[0804747e] old_mmap(NULL, 28672, PROT_READ|PROT_WRITE, MAP_SHARED, 4, 0) = 
0xb7fca000
--->2.6.16.2:
[0804744d] open("E", O_RDWR) = 4
...
[0804747e] old_mmap(NULL, 32768, PROT_READ|PROT_WRITE, MAP_SHARED, 1, 0) = 
-1 ENODEV (No such device)


Simple as that. open() returns fd 4, but old_mmap is called with fd 1, 
which is usually stdout. Looks to me like a userspace problem.


Jan Engelhardt
-- 
| Software Engineer and Linux/Unix Network Administrator
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
