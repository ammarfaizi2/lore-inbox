Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVFYNrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVFYNrT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 09:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbVFYNrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 09:47:19 -0400
Received: from mail.linicks.net ([217.204.244.146]:42767 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S261170AbVFYNrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 09:47:11 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE probing IDE_MAX_HWIFS
Date: Sat, 25 Jun 2005 14:47:09 +0100
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506251447.09633.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Now my question :-)  Is there a specific reason why this isn't included in
> other architectures?  I am asking as I guess one hell of a lot of people
> running on i386 have only two IDE interfaces anyway, and it could do with
> defining it as 2...

I have a patch here, works very well.  But I need to see if I am a bit 'Mickey 
Mouse' and need to ask all you proper coders if this would be an acceptable 
patch.

In drivers/ide/Kconfig

if IDE

config IDE_HWIFS_NUM
        bool "Specify the number of IDE Interfaces"
        depends on (ALPHA || SUPERH || X86)
        default n
        help

          ALPHA and SUPERH say 'y' here.

          X86 say 'y' to this if you wish to specify the number of IDE
          interfaces on your system.  If unsure, say 'n' to use
          the kernel default options (6 or 10).

config IDE_MAX_HWIFS
        int "Max IDE interfaces"
        depends on IDE_HWIFS_NUM
        default 4
        help
          This is the maximum number of IDE hardware interfaces that will
          be supported by the driver. Make sure it is at least as high as
          the number of IDE interfaces in your system.

          On X86 architecture default is (10 or 6) IDE interfaces if this
          is not used (IDE_HWIFS_NUM = n)



and in include/asm-i386/ide.h

#ifndef MAX_HWIFS
#ifndef CONFIG_IDE_HWIFS_NUM
# ifdef CONFIG_BLK_DEV_IDEPCI
#define MAX_HWIFS       10
# else
#define MAX_HWIFS       6
# endif
#else
#define MAX_HWIFS       CONFIG_IDE_MAX_HWIFS
#endif
#endif


I have just built and it works great - boot time seems to increase a lot (but 
I haven't measured as such).  It also eliminates me needing all the 
idex=noprobe also.

Nick
-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
