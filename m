Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbUANQS1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 11:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbUANQS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 11:18:26 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:48341 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261825AbUANQSI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 11:18:08 -0500
From: Kevin Corry <kevcorry@us.ibm.com>
To: Wakko Warner <wakko@animx.eu.org>
Subject: Re: Proposed enhancements to MD
Date: Wed, 14 Jan 2004 10:16:09 -0600
User-Agent: KMail/1.5
Cc: Scott Long <scott_long@adaptec.com>, linux-kernel@vger.kernel.org
References: <40033D02.8000207@adaptec.com> <40047AA6.4020200@domdv.de> <20040113183806.A16839@animx.eu.org>
In-Reply-To: <20040113183806.A16839@animx.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401141016.09361.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 January 2004 17:38, Wakko Warner wrote:
> > > As I've understood it, the configuration for DM is userspace and the
> > > kernel can't do any auto detection.  This would be a "put off" for me
> > > to use as a root filesystem.  Configurations like this (and lvm too
> > > last I looked at it) require an initrd or some other way of setting up
> > > the device.  Unfortunately this means that there's configs in 2
> > > locations (one not easily available,  if using initrd.  easily !=
> > > mounting via loop!)
> >
> > You can always do the following: use a mini root fs on the partition
> > where the kernel is located that does nothing but vgscan and friends and
> > then calls pivot_root. '/sbin/init' of the mini root fs looks like:
>
> What is the advantage of not putting the autodetector/setup in the kernel?

Because it can be incredibly complicated, bloated, and difficult to coordinate 
with the corresponding user-space tools.

> Not everyone is going to use this software (or am I wrong on that?) so that
> can be left as an option to compile in (or as a module if possible and if
> autodetection is not required).  How much work is it to maintain something
> like this in the kernel?

Enough to have had the idea shot down a year-and-a-half ago. EVMS did 
in-kernel volume discovery at one point, but the driver was enormous. Let's 
just say we finally "saw the light" and redesigned to do user-space 
discovery. Trust me, it works much better that way.

> I like the fact that MD can autodetect raids on boot when compiled in, I
> didn't like the fact it can't be partitioned.  That's the only thing that
> put me off with MD.  LVM put me off because it couldn't be auto detected at
> boot.  I was going to play with DM, but I haven't yet.

I guess I simply don't understand the desire to partition MD devices when 
putting LVM on top of MD provides *WAY* more flexibility. You can resize any 
volume in your group, as well as add new disks or raid devices in the future 
and expand existing volumes across those new devices. All of this is quite a 
pain with just partitions.

And setting up an init-ramdisk to run the tools isn't that hard. EVMS even 
provides pre-built init-ramdisks with the EVMS tools which has worked for 
virtually all of our users who want their root filesystem on an EVMS volume. 
It really is fairly simple, and I run three of my own computers this way. If 
you'd like to give it a try, I'd be more than happy to help you out.

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/

