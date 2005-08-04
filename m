Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262670AbVHDU44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262670AbVHDU44 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 16:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbVHDU4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 16:56:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6025 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262679AbVHDUym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 16:54:42 -0400
Date: Thu, 4 Aug 2005 13:56:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Neil Darlow <neil@darlow.co.uk>
Cc: vojtech@suze.cz.thehub.net.au, linux-kernel@vger.kernel.org,
       linux-joystick@atrey.karlin.mff.cuni.cz
Subject: Re: ns558 mis-detects gameport
Message-Id: <20050804135622.03736da7.akpm@osdl.org>
In-Reply-To: <200507082136.47475.neil@darlow.co.uk>
References: <200507082136.47475.neil@darlow.co.uk>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Darlow <neil@darlow.co.uk> wrote:
>
> Hi All,
> 
> I am passing on this information at the request of Daniel Drake (Gentoo kernel 
> ebuild maintainer).
> 
> My hardware is an ASRock K7S41GX motherboard with Athlon XP2200+ CPU
> running 2.6.12 on Gentoo GNU/Linux 2005.0. My gamepad is an Heroic HC 3100 
> 2-axis, 4-button digital model with Turbo features.
> 
> The CVS version string of ns558.c is:
> $Id: ns558.c,v 1.43 2002/01/24 19:23:21 vojtech Exp $
> 
> My motherboard features a generic PC/ISA gameport at BIOS-selectable
> addresses of 0x200 or 0x208. I have built my kernel (using Gentoo's genkernel) 
> to include the Joystick Interface, Generic PC/ISA Gameport and Analog 
> Joystick support as modules which are loaded at boot by coldplug/hotplug 
> logic.
> 
> If I manually modprobe ns558 (which loads gameport), analog and joydev after 
> boot my gameport is detected. If I let coldplug/hotplug load the modules at 
> boot then ns558 fails to detect my gameport.
> 
> If I unload, and then reload, ns558 using coldplug/hotplug at boot then ns558 
> detects my gameport correctly. My module loading setup and dmesg output for a 
> ns558 insert-remove-insert cycle are as follows:
> 
>   options analog map=gamepad
>   above analog joydev
>   pre-install analog modprobe -r ns558; modprobe ns558
> 
>   gameport: NS558 ISA Gameport is isa0200/gameport0, io 0x201, speed 806kHz
>   pnp: Device 00:0a disabled.
>   ns558: probe of 00:0a failed with error -16
>   gameport: kgameportd exiting
>   pnp: Device 00:0a activated.
>   gameport: NS558 PnP Gameport is pnp00:0a/gameport0, io 0x200, speed 806kHz
>   input: Analog 2-axis 4-button gamepad at pnp00:0a/gameport0 [TSC timer, 1786
>     MHz clock, 1299 ns res]
> 
> At https://www.redhat.com/archives/fedora-list/2005-January/msg04967.html the 
> same problem is reported for 2.6.10 on Fedora.
> 
> Is a fix or workaround, other than what I'm doing already, available for this 
> problem?
> 

I assume this is some sort of ordering/dependency problem.  I don't think
we're going to get onto fixing it for 2.6.13, I'm afraid.

It would really help if you could raise a bug report at bugzilla.kernel.org
so that it doesn't get forgotten.  In that report, please identify the most
recent kernel version whcih worked correctly, if any.

Thanks.
