Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265649AbTFSAnd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 20:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265655AbTFSAnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 20:43:33 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:39413 "EHLO
	mail.kroptech.com") by vger.kernel.org with ESMTP id S265649AbTFSAnb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 20:43:31 -0400
Date: Wed, 18 Jun 2003 20:36:53 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Dave Bentham <dave.bentham@ntlworld.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.21 crash
Message-ID: <20030618203653.A17687@mail.kroptech.com>
References: <200306162148.h5GLmXsN002578@telekon.davesnet> <20030618234020.18252c84.dave@telekon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030618234020.18252c84.dave@telekon>; from dave.bentham@ntlworld.com on Wed, Jun 18, 2003 at 11:40:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 11:40:20PM +0100, Dave Bentham wrote:
> However, I think I need some advice on setting up the serial console. I
> have attached another PC (WinXP with HyperTerminal) serially to my panic
> Linux PC. Following the Remote Terminal HOWTO I have achieved some
> success... but all I see on HyperTerminal is:
> 
>    LILO 22.3.2 boot:
>    Loading Linux_2.4.21................
>    BIOS data check successful

That output is from LILO...

>    Mandrake Linux release 9.0 (dolphin) for i586
>    Kernel 2.4.21 on an i686 / ttyS0
>    telekon.davesnet login:

...and that bit is from the getty launched in /etc/inittab.

> a few progress-dots: I'm missing the main kernel blurb (its all on the
> attached monitor), and also the panic stuff appears only on the attached
> monitor.

Yeah, the kernel's serial console isn't kicking in.

> Excerpt of butchered lilo.conf

<snip>

> image = /boot/vmlinuz-2.4.21
> 	root = /dev/hda3
> 	label = Linux_2.4.21
> 	read-only
> #	vga=788
> 	append = "devfs=mount hdd=ide-scsi console=tty0 console=ttyS0,9600n8"

That looks basically right. The kernel you're running may not be
compiled with serial console support. Also, you might want to swap the
order of the two console= options so that /dev/console refers to your
real virtual console, but that shouldn't keep the serial console from
working. You might try dropping the 'n8'...I don't use it here although
it is documented. I vaguely recall having problems that went away when 
I stopped (redundantly) specifying the character format --but that could
be hogwash. My bet is the kernel not being built with serial console
support.

--Adam

