Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318256AbSGQJxX>; Wed, 17 Jul 2002 05:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318257AbSGQJxW>; Wed, 17 Jul 2002 05:53:22 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:61088 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S318256AbSGQJxV>; Wed, 17 Jul 2002 05:53:21 -0400
Date: Wed, 17 Jul 2002 11:56:18 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: input subsystem config ?
Message-ID: <20020717095618.GD14581@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Vojtech Pavlik <vojtech@suse.cz>
References: <20020716143415.GO7955@tahoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020716143415.GO7955@tahoe.alcove-fr>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2002 at 04:34:15PM +0200, Stelian Pop wrote:

> I have problems with the input subsystem in the latest BK tree,
> on a Sony Vaio laptop (regular keyboard, integrated PS/2 trackball):
                                                           ^^^^^^^^^
pointing stick in fact

> the keyboard works but the mouse is never initialized (nothing in 
> the logs, AUX irq not reserved etc).
> 
> Before I submit a proper bug report, could someone confirm that
> the input susbystem is supposed to be working now and what
> config should I use (I tried several config options, all input
> items 'Y', or some items compiled as modules etc).

Ok, here comes a more detalied bug report, based upon 2.5.26:

Relevant boot messages:
	ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
	 hda: 23579136 sectors w/512KiB Cache, CHS=23392/16/63, UDMA(33)
	 hda: [PTBL] [1467/255/63] hda1 hda2 hda3 < hda5 hda6 >
	mice: PS/2 mouse device common for all mice
	input.c: calling /sbin/hotplug input [HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=add PRODUCT=11/1/2/ab02 NAME=AT Set 2 keyboard]
	input.c: hotplug returned -2
	input: AT Set 2 keyboard on isa0060/serio0
	serio: i8042 KBD port at 0x60,0x64 irq 1
	serio: i8042 AUX port at 0x60,0x64 irq 12
	NET4: Linux TCP/IP 1.0 for NET4.0

However, irq 12 is not used after boot:

           CPU0       
	     0:     443973          XT-PIC  timer
	     1:         18          XT-PIC  i8042
	     2:          0          XT-PIC  cascade
	     3:       2470          XT-PIC  pcnet_cs
	     8:          1          XT-PIC  rtc
	     9:        122          XT-PIC  acpi, uhci-hcd, Ricoh Co Ltd RL5c475
 	    14:       9259          XT-PIC  ide0
	   NMI:          0 
	   ERR:          1

My .config:

	$ egrep "INPUT|MOUSE|KEYB|SERIO|8042" .config | grep -v ^#
	CONFIG_INPUT=y
	CONFIG_INPUT_KEYBDEV=y
	CONFIG_INPUT_MOUSEDEV=y
	CONFIG_INPUT_MOUSEDEV_PSAUX=y
	CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
	CONFIG_INPUT_MOUSEDEV_SCREEN_Y=480
	CONFIG_SERIO=y
	CONFIG_SERIO_I8042=y
	CONFIG_I8042_REG_BASE=60
	CONFIG_I8042_KBD_IRQ=1
	CONFIG_I8042_AUX_IRQ=12
	CONFIG_INPUT_KEYBOARD=y
	CONFIG_KEYBOARD_ATKBD=y
	CONFIG_INPUT_MOUSE=y
	CONFIG_MOUSE_PS2=y
	CONFIG_USB_HIDINPUT=y

Should I enable some extra debug somewhere ?

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
