Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129939AbRAXOes>; Wed, 24 Jan 2001 09:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130382AbRAXOei>; Wed, 24 Jan 2001 09:34:38 -0500
Received: from hermes.mixx.net ([212.84.196.2]:30991 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129939AbRAXOec>;
	Wed, 24 Jan 2001 09:34:32 -0500
Message-ID: <3A6EE767.9BD35AC9@innominate.de>
Date: Wed, 24 Jan 2001 15:32:07 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Gregory Maxwell <greg@linuxpower.cx>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at slab.c:1542!(2.4.1-pre9)
In-Reply-To: <3A6C5058.C5AA7681@zaralinux.com> <3A6CB620.469A15A9@Home.net> <3A6ED16E.E8343678@innominate.de> <20010124082929.A1970@xi.linuxpower.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Maxwell wrote:
> 
> On Wed, Jan 24, 2001 at 01:58:22PM +0100, Daniel Phillips wrote:
> > > This is not a kernel bug, This is a bug in the XFree86 TrueType rendering
> > > extention. This has been discussed on the Xpert XFree86 mailing list. There
> > > is a fix in the works (depends on the TrueType fonts your using).
> >
> > A BUG is a BUG:
> >
> > > > kernel BUG at slab.c:1542!
> >
> > The kernel should never oops, no matter what user space does to it.
> 
> The kernel appears to run fine with this bug() removed.

I don't know much about the history of this bug but it's quite clear
it's deliberately inserted:

	void * kmalloc (size_t size, int flags)
		<if allocation succeeds, exit>
	        BUG(); // too big size
	        return NULL;

It says "kernel allocation will *never* fail, and if you try to kmalloc
something too large, that's a bug too" - not a reason to try again.  I'd
check with Linus before solving the problem that way ;-)

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
