Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261561AbRFRV5e>; Mon, 18 Jun 2001 17:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261628AbRFRV5Y>; Mon, 18 Jun 2001 17:57:24 -0400
Received: from www.transvirtual.com ([206.14.214.140]:2066 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S261561AbRFRV5K>; Mon, 18 Jun 2001 17:57:10 -0400
Date: Mon, 18 Jun 2001 14:56:47 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Modular Forms Boy <eger@cc.gatech.edu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        FrameBuffer List <linux-fbdev@vuser.vu.union.edu>
Subject: Re: New Linux Drivers - Configure question
In-Reply-To: <Pine.SOL.4.21.0106180852480.16027-100000@oscar.cc.gatech.edu>
Message-ID: <Pine.LNX.4.10.10106181451060.3113-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I am working on a new framebuffer driver for an LCD controller that's
> custom to the PowerPC embedded world.  As such, it's architecture
> dependent.  Where should I place the driver in the tree, and how should I
> set up the proper Configure options?  Where do I put checks for #ifdef
> CONFIGURE_blah_blah_blah?

Hi!

   You would place it in drivers/video. If you look at the Config.in
file in the linux/drivers/video directory you will see 

if [ "$CONFIG_PPC" = "y" ]; then
 bool '  Open Firmware frame buffer device support' CONFIG_FB_OF
 ...
fi

Just add you driver in that section. Also you have to alter fbmem.c. You
need to add something like 

extern int xxxmydriverfb_init(void);
extern int xxxmydriverfb_setup(char*);

and further down in the file. 

#ifdef CONFIG_FB_MYDRIVER
        { "myfbdriver", xxxmydriverfb_init, xxxmydriverfb_setup },
#endif

When you look at this file you will see what I mean. If you have any
further questions just go to http://www.linux-fbdev.org. In this email you
will see the address for our mailing list. On our web site it gives you
info about joining the mailing list.


