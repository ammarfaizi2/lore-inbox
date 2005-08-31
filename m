Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964976AbVHaVaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbVHaVaQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 17:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964979AbVHaVaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 17:30:16 -0400
Received: from terminus.zytor.com ([209.128.68.124]:40149 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964976AbVHaVaO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 17:30:14 -0400
Message-ID: <43162148.9040604@zytor.com>
Date: Wed, 31 Aug 2005 14:29:44 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alon Bar-Lev <alon.barlev@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, SYSLINUX@zytor.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit
References: <4315B668.6030603@gmail.com>
In-Reply-To: <4315B668.6030603@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alon Bar-Lev wrote:
> 
> Hello Peter,
> 
> I am sorry that I am contacting you directly... Please refer me to 
> correct contact if you are not the one.
> 
> Lately, I've found that 256 bytes long kernel parameters are not enough 
> for my configuration. 
> 
> I've found the place where the kernel defines the length, I've actually 
> found it in two places... I cannot understand why...
> 
> include/asm-i386/param.h: #define COMMAND_LINE_SIZE 256
> include/asm-i386/setup.h: #define COMMAND_LINE_SIZE 256
> 
> Now... I've added an entry in the kernel configuration menu so that I 
> can define these constants using menuconfig. 
> 
> I was quite happy...
> 
> But then I've got into a discussion with grub's development team...
> 
> From what I've read in the Documentation/i386/boot.txt I understood 
> that if I use boot protocol 2.02+ there should be no reason for 256 byte 
> limitation on the string pointed by the cmd_line_ptr, so I guessed they 
> will deliver the command-line twice once for the old protocol truncated, 
> and once for the new protocol not truncated.
> 
> Grub and Lilo approach is to point  the cmd_line_ptr to the old 
> protocol's command line, thus truncating it to 256.
> 
> I'm just wondering... Can the 256 limit be broken, without modifying the 
> boot protocol?
> 
> I think it can... But I need a formal answer so I can push it forward.
> 

Yes, it can.  Several people on the SYSLINUX mailing list have tried 
this, and it works just fine.  The current version of SYSLINUX has a 
limit of 511 characters (because of memory management reasons inside 
SYSLINUX) instead of 255 (plus null).

I think someone on the SYSLINUX mailing list already sent a patch to 
akpm to make 512 the default; making it configurable would be a better 
idea.  Feel free to send your patch through me.

	-hpa

