Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311884AbSDKSrS>; Thu, 11 Apr 2002 14:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312720AbSDKSrR>; Thu, 11 Apr 2002 14:47:17 -0400
Received: from www.transvirtual.com ([206.14.214.140]:31247 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S311884AbSDKSrR>; Thu, 11 Apr 2002 14:47:17 -0400
Date: Thu, 11 Apr 2002 11:46:54 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Rene Rebe <rene.rebe@gmx.net>
cc: john@antefacto.com, linux-kernel@vger.kernel.org
Subject: Re: linux as a minicomputer ?
In-Reply-To: <20020411.195921.730560311.rene.rebe@gmx.net>
Message-ID: <Pine.LNX.4.10.10204111108090.25060-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > No, it's for running one Xserver on multiple displays at once only.
> > > Sad, ain't it?
> > 
> >  Very sad. Nice to know it's not really the kernel's fault. 
> 
> It IS the kernel's fault, becauslle only one VT can be active. The
> kernel VT stuff needs to be redesigned to hadle multiple VT at the
> same time ...

    Correct. The current VT system assumes only one active VT at a time. 
Also the VT system has lots and lots of global variables which make it 
non re-entry. Go examples of dumbness are when running mdacon and vgacon
when you blanks both displays blank. This is bad. Also you can VC switch
from a vga VC to a mda VC but it doesn't quite work. 

   I already have reworked the console system to fix the many bugs and I
have already placed some of it into the dave jones tree. I haven't removed
the global fg_console since it would break a few drivers. This is why I
have been pushing people to port over there keyboard drivers to the input
api. I'm also pushing the new fbdev api for the same reason. This way I
can change the console system without break lots of drivers. 
   
   For example is the fg_console variable. At present the following
drivers use it and it should be removed. 

atyfb_base.c 
aty128fb.c
radeonfb.c

By porting to the new fbdev api the fg_console can be removed.

The following keyboard drivers use fg_console.

sunkbd.c
streamable.c
mac_keyb.c

We already have a Mac input driver so mac_keyb.c could go away. We
also have a sunkbd input driver as well. It this case it is a matter 
of writing a proper serio layer driver for the input layer. Streamable
needs to ported to the input api layer. Several over files use fg_console
but they are not low level drivers so they easly can be fixed.

All of these changes are in the dave jones tree but I hope to start
pushing these changes to Linus. 

