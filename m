Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317517AbSINUzd>; Sat, 14 Sep 2002 16:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317521AbSINUzd>; Sat, 14 Sep 2002 16:55:33 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:12049
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317517AbSINUzc>; Sat, 14 Sep 2002 16:55:32 -0400
Date: Sat, 14 Sep 2002 13:57:58 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Alex Davis <alex14641@yahoo.com>, miquels@cistron.nl,
       linux-kernel@vger.kernel.org
Subject: Re: Possible bug and question about ide_notify_reboot in 2.4.19
In-Reply-To: <1032031927.13636.1.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10209141342090.6925-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alex,

We (T13 Standards) only recently required (shall) all non-packet device to
support flush cache.  No where does it state that a device supporting PM
for a standby (shall), the key word here is "shall", issue a flush-cache.

Does the early IBM laptop drive ring a bell?
IBM set an erratium about flush cache and spindown/power down, where it is
the "host driver" is responsible for the data.

So regardless of what you want, and what hardware you have, there is
hardware which doesn't do it properly.

So if yours gets it correct, great, dance for joy.

I will not break support for older hardware, on a whim.
You said you can make a patch, please do so and apply it to your tree.

One thing you will figure out is I am absolutely retentive to the SPEC,
and careful to not break older version of the standard, even retired
versions.

Now, if you want the option, submit the patch for review.  For two or
three days there has been no patch to test.

To be absolutely honest, I really do not like to give options in the
kernel-config build which can cause backwards compatablity problems.
The only what I would consider it is to perform a revision check on
major/minor against the devices present and should any device violate,
forcablely OOPS the kernel into a deadlock crash before filesystems can be
mounted. 

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On 14 Sep 2002, Alan Cox wrote:

> On Sat, 2002-09-14 at 19:28, Alex Davis wrote:
> > >Putting the drive in stand-by mode has the side effect of flushing
> > >the cache.
> > Maxtor's tech support says this is NOT true.
> 
> Hint 1. Other people make disks too
> Hint 2. The guys who did the code include a member of the standards
> committee.
> 
> 
> > Ok how about this: I'm current testing some patches against
> > ide.c and friends. Why don't I just add ( and document ) a
> > define called NO_STANDBY_ON_SHUTDOWN which would live in 
> > ide.c. By default it would not be defined. Then I just wrap
> > the standby code in an '#ifndef NO_STANDBY_ON_SHUTDOWN..#endif'
> > block.
> 
> Unless Andre agrees the change is required in the new IDE they won't be
> going in. 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

