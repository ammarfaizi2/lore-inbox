Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbTIMNRF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 09:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbTIMNRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 09:17:05 -0400
Received: from fed1mtao02.cox.net ([68.6.19.243]:11759 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S262145AbTIMNRD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 09:17:03 -0400
Message-ID: <3F6318CF.9030805@cox.net>
Date: Sat, 13 Sep 2003 06:17:03 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: Andreas Schwab <schwab@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new ioctl type checking causes gcc warning
References: <3F621AC4.4070507@cox.net> <200309130222.43612.arnd@arndb.de> <3F626544.40000@cox.net> <200309131305.12161.arnd@arndb.de>
In-Reply-To: <200309131305.12161.arnd@arndb.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> Inside the kernel, the first definition has to be changed to
> something like:
> 
> #define BLKGETSIZE64    _IOR(0x12,114,size_t) /* broken: actually __u64 */
> or
> #define BLKGETSIZE64    _IOR_BAD(0x12,114,sizeof(__uint64_t)) /* broken */
> 
> in order to get a definition that will pass the check and
> generate the well-known number.

That's strange. I did some testing with a small application (blockdev) 
that uses this ioctl yesterday, and strace did not show any difference 
between the correct and incorrect definitions. I could change the 
definition back and forth and the application continued to work 
correctly. I'll have to go back and figure out what I was doing wrong :-)

