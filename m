Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319332AbSH2UUE>; Thu, 29 Aug 2002 16:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319334AbSH2UUC>; Thu, 29 Aug 2002 16:20:02 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:16271 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S319332AbSH2UUB>; Thu, 29 Aug 2002 16:20:01 -0400
Message-ID: <3D6E82DF.2090100@us.ibm.com>
Date: Thu, 29 Aug 2002 13:23:59 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020822
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Obster <michael.obster@bingo-ev.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Compiling 2.5.32
References: <3D6E7F7F.2080804@bingo-ev.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Obster wrote:
> can anybody give me hint. I don't think it is a bug, but i don't know 
> what this error means for me. It is in "make bzImage" and the config is 
> attached. Symlink asm is on asm-i386 and i added "ln -s 
> /usr/src/linux/include/asm-generic /usr/include/asm-generic". Build 
> environment is Athlon, Kernel 2.4.18, gcc 2.95.3
> <snip>
> drivers/built-in.o(.data+0x2fab4): undefined reference to `local symbols 

 From what I understand this happens when these conditions are met:
1. You use a recent version of binutils (Debian has one)
2. CONFIG_HOTPLUG is not set
3. You compile a driver that doesn't properly use __devexit_p macro

I fixed this in the IPS driver:
http://linus.bkbits.net:8080/linux-2.5/user=haveblue/cset@1.485.7.2

So, find and fix the driver, use hotplug, or get an older binutils.
-- 
Dave Hansen
haveblue@us.ibm.com

