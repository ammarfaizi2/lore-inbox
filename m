Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267724AbTGVQcN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 12:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270923AbTGVQcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 12:32:12 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:46857 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267724AbTGVQcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 12:32:11 -0400
Date: Tue, 22 Jul 2003 17:47:04 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Samuel Flory <sflory@rackable.com>, Charles Lepple <clepple@ghz.cc>,
       michaelm <admin@www0.org>, <linux-kernel@vger.kernel.org>,
       <vojtech@suse.cz>
Subject: Re: Make menuconfig broken
In-Reply-To: <Pine.LNX.4.44.0307221146120.714-100000@serv>
Message-ID: <Pine.LNX.4.44.0307221735160.5483-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >   Try this in 2.6.0-test1:
> > rm .config
> > make mrproper
> > make menuconfig
> > 
> >   There is no option for CONFIG_VT, and CONFIG_VT_CONSOLE under 
> > character devices in "make menuconfig.
> 
> Try enabling CONFIG_INPUT.
> 
> Vojtech, how about the patch below? This way CONFIG_VT isn't hidden behind 
> CONFIG_INPUT, but CONFIG_INPUT is selected if needed.
> 
> Index: drivers/char/Kconfig
> ===================================================================
> RCS file: /home/other/cvs/linux/linux-2.6/drivers/char/Kconfig,v
> retrieving revision 1.1.1.1
> diff -u -p -r1.1.1.1 Kconfig
> --- drivers/char/Kconfig	14 Jul 2003 09:22:00 -0000	1.1.1.1
> +++ drivers/char/Kconfig	22 Jul 2003 08:08:26 -0000
> @@ -6,7 +6,7 @@ menu "Character devices"
>  
>  config VT
>  	bool "Virtual terminal"
> -	requires INPUT=y
> +	select INPUT
>  	---help---
>  	  If you say Y here, you will get support for terminal devices with
>  	  display and keyboard devices. These are called "virtual" because you

What about the keyboard being built in. People will still not set that. 

The proper solution would be to alter the build system on a default build 
to scan the .config file for CONFIG_PC_KEYB, CONFIG_MOUSE, CONFIG_BUSMOUSE,
CONFIG_PSMOUSE etc. Then convert them to what is needed for 2.6.X. The same 
for framebuffer console stuff. We can scan for CONFIG_FB and if 
CONFIG_FRAMEBUFFER_CONSOLE is not present set it. We only would need to do 
this for a default build. 



