Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262599AbSI0Vwo>; Fri, 27 Sep 2002 17:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262606AbSI0Vwo>; Fri, 27 Sep 2002 17:52:44 -0400
Received: from web20309.mail.yahoo.com ([216.136.226.90]:21651 "HELO
	web20309.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262599AbSI0Vwm>; Fri, 27 Sep 2002 17:52:42 -0400
Message-ID: <20020927215802.19246.qmail@web20309.mail.yahoo.com>
Date: Fri, 27 Sep 2002 14:58:02 -0700 (PDT)
From: DragonK <dragon_krome@yahoo.com>
Subject: Linux 2.4.x Kernel Bug - Problem NOT found, but found workaround
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

    I followed your suggestion and tried to find where
exactly did the kernel
hang, by using an infinite loop and blinking floppy
LED (sorry, the kbd leds
didn't work, except in DOS).
    I ended up in protected mode, in
[arch/i386/kernel/head.S] where I managed
to find a SOLUTION for the problem (HAVEN'T FOUND THE
PROBLEM (I THINK)).

Here is the modification I've made (sorry for not
sending a diff, I've lost the
original file :P )

This is from KERNEL 2.4.18

-------------(
arch/i386/kernel/head.S)------------------------------------
        orl %eax,%eax                   # do we have
processor info as well?
        je is486

#       movl $1,%eax            # Use the CPUID
instruction to get CPU type
#       cpuid                   # <- This CPUID thing
hangs the machine
                                # With it, there's a
lock, without it, a reboot :(
# I've noticed that this code is the same in 2.2.20
kernel, which works perfectly!!!
#       movb %al,%cl            # save reg for future
use
#       andb $0x0f,%ah          # mask processor
family
#       movb %ah,X86
#       andb $0xf0,%al          # mask model
#       shrb $4,%al
#       movb %al,X86_MODEL
#       andb $0x0f,%cl          # mask mask revision
#       movb %cl,X86_MASK
#       movl %edx,X86_CAPABILITY

        movb    $4, %al         #
        movb    %al, X86_MODEL  #
        movb    $5, %al         # Hardcoded the CPUID
results (except edx...)
        movb    %al, X86        # and... the kernel
works fine!
        movb    $2, %al         #
        movb    %al, X86_MASK   #
is486:
-----------------------------------------------------------------------------

Why is this happening?

Thanks for your support.

__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com
