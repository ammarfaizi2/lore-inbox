Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267900AbTAIU0S>; Thu, 9 Jan 2003 15:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267950AbTAIU0S>; Thu, 9 Jan 2003 15:26:18 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:15620 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267900AbTAIU0R>; Thu, 9 Jan 2003 15:26:17 -0500
Date: Thu, 9 Jan 2003 20:34:55 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Geert Uytterhoeven <geert@sonycom.com>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: 2.5 fbdev & driver initial mode
In-Reply-To: <1042108748.567.20.camel@zion.wanadoo.fr>
Message-ID: <Pine.LNX.4.44.0301092025120.5660-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Note: on some platforms graphics chips with VGA cores are _not_ initialized to
> > VGA mode by the firmware. So great care should be taken when not explicitly
> > switching to graphics mode on those platforms.
> 
> Yup. This is typically the case of PowerMacs where the VGA memory isn't
> even reachable on the PCI/AGP bus. 

Here are the case we will have.

1) Embedded devices. People here have a tendency to want to use serial 
   console and just want fbdev without fbcon. Fbcon set the graphics state  
   in fbcon_startup. Now the developers want to know if the hardware 
   actually worked. So they can call fb_set_var and fb_show_logo 
   themselves in there drivers. They want to fully bring up the hardware.
  
2) Now say the above want to use fbcon. Then they don't need to set the 
   graphics state in there driver. Fbcon will do it for them. 

3) The graphics card has some kind of default text mode state. For the 
   case  where we want to use /dev/fb without fbcon and the text mode then
   we don't want to change the graphics state in the intialization code. 
   It is done in the first open and the last close.

