Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbUB2HYP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 02:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbUB2HYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 02:24:15 -0500
Received: from fep01-mail.bloor.is.net.cable.rogers.com ([66.185.86.71]:28332
	"EHLO fep01-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S261999AbUB2HYL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 02:24:11 -0500
Message-ID: <4041504A.60604@rogers.com>
Date: Sun, 29 Feb 2004 02:36:58 +0000
From: Stephen Pearce <s-pearce@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040117
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: PS/2 Mouse Craziness with 2.6.x
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep01-mail.bloor.is.net.cable.rogers.com from [24.114.66.128] using ID <s-pearce@rogers.com> at Sun, 29 Feb 2004 02:24:03 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have had no end of problems with psmouse and my Logitech M-BJ58 PS/2 
3-button optical wheel mouse under 2.6.  Most recently with 2.6.2 it 
just wouldn't work at all, despite being detected.  With 2.6.3 the mouse 
will go all crazy after the first boot (both in console with GPM and 
under X), but work fine on the 2nd or later boot.  I get this common 
complaint when it's not working right:
"kernel: psmouse.c: Mouse at isa0060/serio1/input0 lost synchronization, 
throwing 2 bytes away."

Here's some information on my setup:

dmesg:
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1

/proc/bus/input/devices:
I: Bus=0011 Vendor=0002 Product=0006 Version=0000
N: Name="ImExPS/2 Generic Explorer Mouse"
P: Phys=isa0060/serio1/input0
H: Handlers=mouse0
B: EV=7
B: KEY=1f0000 0 0 0 0 0 0 0 0
B: REL=103

/etc/X11/XF86Config-4:
Section "InputDevice"
Identifier  "Mouse0"
Driver      "mouse"
Option      "Protocol" "imps/2"
Option      "Device" "/dev/mouse"
Option      "ZAxisMapping" "4 5"
Option      "Buttons" "3"
EndSection

kernel config:
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768

GPM:
/usr/sbin/gpm -m /dev/mouse -t imps2
(/dev/mouse points to /dev/psaux)

My system is a 1 GHz PIII (Coppermine) on an Asus TUSLC-2 (i815) board 
running Slackware 9.1 with ACPI enabled.  I've tried passing 
"psmouse.proto=imps" to the kernel and the behaviour is the same.  I've 
never had any problems with this mouse under any 2.4 kernel, so I 
believe this to be an issue with the new PS/2 mouse support in 2.6 and 
not a hardware problem.


-Stephen Pearce

