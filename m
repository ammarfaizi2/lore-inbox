Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316588AbSG3V1R>; Tue, 30 Jul 2002 17:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316589AbSG3V1R>; Tue, 30 Jul 2002 17:27:17 -0400
Received: from mta03ps.bigpond.com ([144.135.25.135]:5345 "EHLO
	mta03ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S316588AbSG3V1Q>; Tue, 30 Jul 2002 17:27:16 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Greg KH <greg@kroah.com>, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [patch] Input cleanups for 2.5.29 [2/2]
Date: Wed, 31 Jul 2002 07:26:05 +1000
User-Agent: KMail/1.4.5
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linuxconsole-dev@lists.sourceforge.net
References: <20020730122638.A11153@ucw.cz> <20020730152342.B20071@ucw.cz> <20020730210938.GA16657@kroah.com>
In-Reply-To: <20020730210938.GA16657@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200207310726.05436.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2002 07:09, Greg KH wrote:
> On Tue, Jul 30, 2002 at 03:23:42PM +0200, Vojtech Pavlik wrote:
> > -#include <asm/types.h>
> > +#include <stdint.h>
>
> Why?  I thought we were not including any glibc (or any other libc)
> header files when building the kernel?
Should be <linux/types.h>

> > -	__u16 bustype;
> > -	__u16 vendor;
> > -	__u16 product;
> > -	__u16 version;
> > +	uint16_t bustype;
> > +	uint16_t vendor;
> > +	uint16_t product;
> > +	uint16_t version;
>
> {sigh}  __u16 is _so_ much nicer, and tells the programmer, "Yes I know
> this variable needs to be the same size in userspace and in
> kernelspace."
I'll harp some more.
1. __u16 isn't really any nicer - its just what you (as a kernel programmer) are used to.
2. uint16_t is a *standard* type. Userspace programmer know it, even if they don't know Linux. 

We shouldn't arbitrarily invent new types that could be trivially done with 
standard types. Maybe we could retain existing usage for ABIs that are
unchanged from 2.0 days, but we certainly shouldn't be making the ABI
any worse.


-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
