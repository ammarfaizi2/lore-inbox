Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318128AbSGMJBX>; Sat, 13 Jul 2002 05:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318129AbSGMJBW>; Sat, 13 Jul 2002 05:01:22 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39180 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318128AbSGMJBV>; Sat, 13 Jul 2002 05:01:21 -0400
Date: Sat, 13 Jul 2002 10:04:07 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: A Guy Called Tyketto <tyketto@wizard.com>
Cc: Ed Sweetman <safemode@speakeasy.net>, linux-kernel@vger.kernel.org
Subject: Re: kbd not functioning in 2.5.25-dj2
Message-ID: <20020713100407.A24721@flint.arm.linux.org.uk>
References: <1026545050.1203.116.camel@psuedomode> <20020713073717.GA9203@wizard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020713073717.GA9203@wizard.com>; from tyketto@wizard.com on Sat, Jul 13, 2002 at 12:37:17AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 13, 2002 at 12:37:17AM -0700, A Guy Called Tyketto wrote:
>         Just a "me too" here.. I've had this problem since around 2.5.15-dj 
> and later, and have had input and keyboard support compiled into the kernel. 
> Luckily I was able to get into the box via ssh, and check things. both 
> keyboard and mouse are PS/2. If possible, see if you can do this, and check if 
> IRQ 1 is not listed in /proc/interrupts. That is what is happening with me, 
> while my mouse is working. For me to get my keyboard to work, I have to have 
> the following set:
> 
> CONFIG_INPUT=y
> CONFIG_INPUT_KEYBDEV=y
> CONFIG_INPUT_MOUSEDEV=y
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> CONFIG_INPUT_EVDEV=y
> CONFIG_INPUT_EVBUG=y
> CONFIG_SERIO=y
> CONFIG_SERIO_SERPORT=m

You're missing support for the actual PS/2 hardware itself; you've got
support for the PS/2 keyboard protocol and keyboard device, but nothing
to actually talk to the physical hardware.  You probably want to turn on:

dep_tristate '  i8042 PC Keyboard controller' CONFIG_SERIO_I8042 $CONFIG_SERIO $CONFIG_ISA

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

