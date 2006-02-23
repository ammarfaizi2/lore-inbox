Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751755AbWBWRXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbWBWRXP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 12:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbWBWRXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 12:23:15 -0500
Received: from terminus.zytor.com ([192.83.249.54]:50660 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751755AbWBWRXO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 12:23:14 -0500
Message-ID: <43FDEF72.5050200@zytor.com>
Date: Thu, 23 Feb 2006 09:22:58 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: starvik@axis.com, geert@linux-m68k.org, zippel@linux-m68k.org
CC: dev-etrax@axis.com, linux-m68k@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ralf Baechle <ralf@linux-mips.org>
Subject: The sys_mmap2 syscall on m68k, cris, and mips
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, sorry for the wide distribution;

I am trying to track down the story on the sys_mmap2 system call. 
Currently, to the best of my knowledge, glibc, µClibc, and klibc 
(haven't looked at newlib recently) all assume that sys_mmap2() is the 
way to map large files on 32-bit architectures, and that the offset 
argument is always shifted over by 12.

As indicated by this post, this is the case on most architectures:

http://marc.theaimsgroup.com/?l=linux-kernel&m=114066586932670&w=2

The odd ones out are m68k, cris, and MIPS.  Ralf Baechle has indicated 
that non-4K-pages are currently experimental on MIPS, and that he would 
be open to changing MIPS to fit the rest of the pattern.  That leaves 
m68k and cris.

Thus, I would like to hear your opinion.  One opinion is to define that 
the shift is fixed, but architecture-specific, and introduce an 
MMAP2_PAGE_SHIFT #define that libraries can pick up.  (That would 
require m68k to change at least on the Sun3 platform, though.  I don't 
think there is a huge installed base there, though.)

	-hpa
