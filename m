Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265394AbUABH1Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 02:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265395AbUABH1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 02:27:24 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:23272
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S265394AbUABH1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 02:27:22 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: kaih@khms.westfalen.de (Kai Henningsen), linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
Date: Fri, 2 Jan 2004 01:26:44 -0600
User-Agent: KMail/1.5.4
References: <18Cz7-7Ep-7@gated-at.bofh.it> <200401010634.28559.rob@landley.net> <900eUExXw-B@khms.westfalen.de>
In-Reply-To: <900eUExXw-B@khms.westfalen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401020126.44234.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 January 2004 13:43, Kai Henningsen wrote:
> rob@landley.net (Rob Landley)  wrote on 01.01.04 in 
<200401010634.28559.rob@landley.net>:
> > On Wednesday 31 December 2003 18:31, Rob Love wrote:
> > > On Wed, 2003-12-31 at 19:15, Andries Brouwer wrote:
> > > > My plan has been to essentially use a hashed disk serial number
> > > > for this "any old unique value". The problem is that "any old"
> > > > is easy enough, but "unique" is more difficult.
> > > > Naming devices is very difficult, but in some important cases,
> > > > like SCSI or IDE disks, that would work and give a stable name.
> > >
> > > Yup.
> > >
> > > > The kernel must not invent consecutive numbers - that does not
> > > > lead to stable names. Setting this up correctly is nontrivial.
> > >
> > > This is definitely an interesting problem space.
> > >
> > > I agree wrt just inventing consecutive numbers.  If there was a nice
> > > way to trivially generate a random and unique number from some
> > > device-inherent information, that would be nice.
> > >
> > > 	Rob Love
> >
> > Fundamental problem: "Unique" depends on the other devices in the system.
> > You can't guarantee unique by looking at one device, more or less by
> > definition.
>
> This is actually not fundamental at all.
>
> The best-known exception is probably the MAC address. But it is not the
> only example of devices having true unique information.

I thought of mentioning this, but deleted it as a digression.  But since you 
brought it up:

A) There are ethernet cards that have the same mac address.  (Over the years, 
the cheap manufacturers have managed to screw this up.  Ask Alan Cox.)  They 
show up randomly and cause real headaches for network administrators if you 
don't think to look for it.

B) You can override the mac address thing thing comes with.  This is done all 
the time.  (Hot failover comes to mind, but it's not the only one.  I 
remember how the cable modem company that serviced my mother's house snagged 
the mac address of the cable modem as part of the inital setup, and refused 
to work with a different mac address.  (I asked their support guys: They 
wanted to make sure you were still using the machine they'd installed their 
special software on, which was a windows machine and I was installing a linux 
firewall.  And predicting THIS digression: yes I power cycled and hit the 
reset button on the cable modem, it didn't help.  The problem was at the 
other end, their gateway dropped packets from the wrong mac address.)

So I changed the mac address of the other machine as part of its init scripts, 
and it worked again...

> It is certainly true, though, that there are devices without this kind of
> info.
>
> And remember that you can sometimes use secondary information. With any
> kind of read-write storage device, it might be possible to create such a
> piece of information and store it onto that device.

I.E. a udev config entry?

> Moral: keep the identifier creation framework flexible enough so that you
> can chose device-specific means to produce useful identifiers. (And, use
> long identifiers, as they're less likely to be duplicated in general.)

Seems to be what udev is for.  When we do go to random major and minor 
numbers, maybe it would be useful to let udev request specific ones?  (Just a 
thought...)

> MfG Kai

Rob

