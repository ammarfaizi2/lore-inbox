Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264898AbUAVSLd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 13:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266271AbUAVSLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 13:11:33 -0500
Received: from med-xtal.bu.edu ([155.41.132.110]:823 "EHLO med-xtal.bu.edu")
	by vger.kernel.org with ESMTP id S264898AbUAVSLb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 13:11:31 -0500
Date: Thu, 22 Jan 2004 13:11:29 -0500 (EST)
Message-Id: <200401221811.NAA274801@med-xtal.bu.edu>
From: ezra peisach <epeisach@med-xtal.bu.edu>
To: David Ford <david+challenge-response@blue-labs.org>
cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ACPI] PROBLEM: LCD display dead after ACPI suspend to RAM (S3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Try hitting the hardware function key that swaps the CRT/LCD and/or the 
>function key that changes the font.

>Works on my laptop.  Really annoying two-fold issue.  First, the screen 
>is blank, second, I have to blindly run setfont to change the garbage 
>font to a readable font.

>I'm not running an fb, just an nvidia card in text mode on a Dell 
>Inspiron 8200.
I have been probing this issue on an Inspiron 8200 - but with a radeon
card.

The essential problem in S3 is four fold:
a) When entering S3 - power is turned off to the video card. When 
power is restored, the vga interface is confused as to register settings, etc.
b) vgacon does have any power management handling capabilities.
c) radeonfb does not handle power management either - except for the case
   of powerbooks. 
d) On power restore, I have observed that the backlight of the display 
is turned off. If I use radeontools to turn back on the display, I can then
see what is there.

I am working on a set of patches to store the state of the VGA card
(drivers/video/vgacon.c) before power shutdown and after restore. (I have the
basics - but it needs to be cleaned up). 

What is then missing is the interface to poke at the radeon and I
suspect nvidia card to turn on the backlight. When X is running
switching away from VC 7 and back resets the flag - a better solution
is eventually needed. Perhaps radeonfb will be the way to go - but it needs
to have power handling code implemented on all platforms.

Ezra


