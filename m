Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265349AbSIRF6g>; Wed, 18 Sep 2002 01:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265353AbSIRF6g>; Wed, 18 Sep 2002 01:58:36 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:25605
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S265349AbSIRF6d>; Wed, 18 Sep 2002 01:58:33 -0400
Date: Tue, 17 Sep 2002 23:00:41 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] Experimental IDE oops dumper v0.1 
In-Reply-To: <20020918044012.C77212C075@lists.samba.org>
Message-ID: <Pine.LNX.4.10.10209172239490.11597-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2002, Rusty Russell wrote:

> In message <Pine.LNX.4.10.10209170028370.11597-100000@master.linux-ide.org> you
>  write:
> > > 	if (!(hdid.capability & (1 << 1))) {
> > > 		fprintf(stderr, "Drive does not support LBA\n");
> > > 		exit(1);
> > > 	}
> > 
> > Wrong answer, you do CHS.
> 
> I can't test that, so safe answer is to refuse to arm the oopser.
> Since LBA is most common, that's my first priority.

You may pull this off on /dev/hda or /dev/hdb, but Linux has set a policy
to default to CHS regardless if LBA should be used.  What really needs to
be fixed is to default to LBA and not CHS.  The problem is everybody will
scream bloody murder.

This is why 48-bit devices killed CHS, it is too brain dead to survive but
for the life of me it continues.

> 
> Me too 8(.  The oopser is allowed to (a) refuse to arm at arming time,
> or (b) refuse to dump at dumping time, but it'd be nice if it worked
> on the widest range of stuff possible (ie. CHS and LBA48 at least).
> Of course, it can't use any external routines, and must be small too.

Heads up!

If the device is 48-bit capable, but the swap area to dump to is inside
the 28-bit addressable region, you can call it with 28-bit commands.

> The IDE layer does a great job (on my hardware) from recovering after
> we rudely steal the device from it, but no doubt the oopser could be
> nicer about it.

OIC, that is nice to know you are not able to tank the driver even when
abusing it.


> Thanks for reading,
> Rusty.
> --
>   Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
> 

Andre Hedrick
LAD Storage Consulting Group

