Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314811AbSFDQYQ>; Tue, 4 Jun 2002 12:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314829AbSFDQYP>; Tue, 4 Jun 2002 12:24:15 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:63716 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S314811AbSFDQYP>; Tue, 4 Jun 2002 12:24:15 -0400
Date: Tue, 4 Jun 2002 17:55:48 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Gerald Teschl <gerald.teschl@univie.ac.at>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, <zwane@commfireservices.com>
Subject: Re: [PATCH] opl3sa2 isapnp activation fix
In-Reply-To: <Pine.LNX.4.44.0206041737410.26634-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.44.0206041754050.26634-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jun 2002, Zwane Mwaikambo wrote:

> >          if(dev->activate(dev) < 0) {
> > -            printk(KERN_WARNING PFX "ISA PnP activate failed\n");
> > -            opl3sa2_state[card].activated = 0;
> > -            return -ENODEV;
> > +            /*
> > +             * isapnp.c disallows dma=0 but some opl3sa2 cards need it.
> > +             * So we set dma by hand and try again
> > +             */
> > +            if (dma < 0 || dma > 7)
> > +                dma= 0;
> > +            if (dma2 < 0 || dma2 >7)
> > +                dma2= 1;
> 
> Oops, that won't work on isapnp since dma = dma2 = -1 at this stage, how 
> about;
> 
> if ((dma != -1) && (dma2 != -1)) frob();
> 
> you shouldn't hard set 0,1

You can move the check earlier on so that you do the first activate with 
the supplied dma settings, therefore avoiding the double take. That way 
you'd also not add any additional frobbing for the normal case.

-- 
http://function.linuxpower.ca
		

