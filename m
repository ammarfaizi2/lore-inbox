Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316667AbSG3VgI>; Tue, 30 Jul 2002 17:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316672AbSG3VgI>; Tue, 30 Jul 2002 17:36:08 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:4053 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S316667AbSG3VgF>;
	Tue, 30 Jul 2002 17:36:05 -0400
Date: Tue, 30 Jul 2002 23:39:07 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Brad Hards <bhards@bigpond.net.au>
Cc: Greg KH <greg@kroah.com>, Vojtech Pavlik <vojtech@suse.cz>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linuxconsole-dev@lists.sourceforge.net
Subject: Re: [patch] Input cleanups for 2.5.29 [2/2]
Message-ID: <20020730233907.B23181@ucw.cz>
References: <20020730122638.A11153@ucw.cz> <20020730152342.B20071@ucw.cz> <20020730210938.GA16657@kroah.com> <200207310726.05436.bhards@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200207310726.05436.bhards@bigpond.net.au>; from bhards@bigpond.net.au on Wed, Jul 31, 2002 at 07:26:05AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2002 at 07:26:05AM +1000, Brad Hards wrote:
> On Wed, 31 Jul 2002 07:09, Greg KH wrote:
> > On Tue, Jul 30, 2002 at 03:23:42PM +0200, Vojtech Pavlik wrote:
> > > -#include <asm/types.h>
> > > +#include <stdint.h>
> >
> > Why?  I thought we were not including any glibc (or any other libc)
> > header files when building the kernel?
> Should be <linux/types.h>

It's #ifndef __KERNEL__ and if we #include <linux/types.h> and the user
#includes <stdint.h> elsewhere, we're going to get collisions.

I guess __u16 is really the safe way here.

> > > -	__u16 bustype;
> > > -	__u16 vendor;
> > > -	__u16 product;
> > > -	__u16 version;
> > > +	uint16_t bustype;
> > > +	uint16_t vendor;
> > > +	uint16_t product;
> > > +	uint16_t version;
> >
> > {sigh}  __u16 is _so_ much nicer, and tells the programmer, "Yes I know
> > this variable needs to be the same size in userspace and in
> > kernelspace."
> I'll harp some more.
> 1. __u16 isn't really any nicer - its just what you (as a kernel programmer) are used to.
> 2. uint16_t is a *standard* type. Userspace programmer know it, even if they don't know Linux. 
> 
> We shouldn't arbitrarily invent new types that could be trivially done with 
> standard types. Maybe we could retain existing usage for ABIs that are
> unchanged from 2.0 days, but we certainly shouldn't be making the ABI
> any worse.

-- 
Vojtech Pavlik
SuSE Labs
