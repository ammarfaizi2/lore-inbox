Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317278AbSHYLZi>; Sun, 25 Aug 2002 07:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317269AbSHYLZi>; Sun, 25 Aug 2002 07:25:38 -0400
Received: from keen.esi.ac.at ([193.170.117.2]:4612 "EHLO keen.esi.ac.at")
	by vger.kernel.org with ESMTP id <S317258AbSHYLZg>;
	Sun, 25 Aug 2002 07:25:36 -0400
Date: Sun, 25 Aug 2002 13:29:50 +0200 (CEST)
From: Gerald Teschl <gerald@esi.ac.at>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: linux-kernel@vger.kernel.org, <linux-sound@vger.kernel.org>
Subject: Re: [PATCH] ad1848 infinite loop fix
In-Reply-To: <Pine.LNX.4.44.0208251255230.28574-100000@linux-box.realnet.co.sz>
Message-ID: <Pine.LNX.4.44.0208251324430.1454-100000@bounder.esi.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Aug 2002, Zwane Mwaikambo wrote:

> 
> > --- linux-2.4.19/drivers/sound/ad1848.c.orig    Sat Aug 24 23:19:54 2002
> > +++ linux-2.4.19/drivers/sound/ad1848.c Sat Aug 24 23:20:58 2002
> > @@ -3058,7 +3058,7 @@
> >         else
> >                 printk(KERN_INFO "ad1848: Failed to initialize %s\n", 
> > devname);
> > 
> > -       return 0;
> > +       return -ENODEV;
> >  }
> > 
> >  static int __init ad1848_isapnp_probe(struct address_info *hw_config)
> 
> This will break the isapnp probe in ad1848, the problem could possibly be 
> elsewhere. You have to be a bit careful when changing the return values of 
> functions in some of the older OSS code.
> 
I just looked into some of the other drivers and they also use "return 0"
in case of failure. So you are right, this is not the proper
way to fix this! But this means that there are some generic problems
with the loading of kernel modules!?

If I use "return -ENODEV" the module will do the init stuff, fail, and
thats it. With the original "return 0" the module will do the init
stuff in an infinite loop. I do not think this is a problem inside
the module since it looks like the main init function gets
called over and over again (blocking the kernel and hence freezing
the system).

Gerald

