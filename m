Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267451AbSLEVt1>; Thu, 5 Dec 2002 16:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267454AbSLEVt1>; Thu, 5 Dec 2002 16:49:27 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:33298 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S267451AbSLEVt0>; Thu, 5 Dec 2002 16:49:26 -0500
Subject: Re: [Linux-fbdev-devel] [PATCH 1/3: FBDEV: VGA State Save/Restore
	module
From: Antonino Daplas <adaplas@pol.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0212051729230.31967-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0212051729230.31967-100000@phoenix.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1039135574.1032.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Dec 2002 05:47:06 +0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-05 at 22:31, James Simmons wrote:
> 
> > Limitations:
> > 1.  Restoring the VGA state from high-resolution graphics mode may
> > result in a corrupt display which can be corrected by switching
> > consoles.  May need a screen redraw at this point.  Restoring from VGA
> > graphics mode to text mode and vice versa is okay.
> > 
> > 2. Assumes some things about the hardware which is not universally
> > correct:  VGA memory base is at 0xA0000, memory size is 64KB, the
> > hardware palette is readable, etc. 
> > 
> > Any comments welcome.
> 
> One thing I like to suggest. I like to move the vga code in fb.h to vga.h. 
> Alot of fbdev devices don't have a VGA core. 
> 
> 

Only the structure definition of fb_vgastate is in fb.h.  For drivers
without a vga core, they'll just won't link to it and it won't be
compiled.  Plus, vga.h is not a common header (not located in
include/asm or include/linux) and it contains a lot of declarations and
definitions which are irrelevant to most drivers or are already
duplicated.  This will be messier, I think.  

Maybe we can just enclose it in a macro, something like:

#ifdef FBDEV_HAS_VGACORE
...
#endif

Tony

