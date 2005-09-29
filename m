Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbVI2SK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbVI2SK2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 14:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbVI2SK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 14:10:28 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:51404 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932303AbVI2SK1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 14:10:27 -0400
To: Luben Tuikov <luben_tuikov@adaptec.com>
cc: Jeff Garzik <jgarzik@pobox.com>, Bernd Petrovitsch <bernd@firmix.at>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>,
       Patrick Mansfield <patmans@us.ibm.com>,
       Luben Tuikov <ltuikov@yahoo.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into the kernel 
In-reply-to: Your message of Thu, 29 Sep 2005 12:58:16 EDT.
             <433C1D28.6080900@adaptec.com> 
Date: Thu, 29 Sep 2005 11:09:50 -0700
Message-Id: <E1EL2qs-0008Tr-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 29 Sep 2005 12:58:16 EDT, Luben Tuikov wrote:
> On 09/29/05 12:56, Jeff Garzik wrote:
> > Luben Tuikov wrote:
> > 
> >>On 09/29/05 11:17, Bernd Petrovitsch wrote:
> >>
> >>
> >>>Then submit your driver as a (separate) block device in parallel to the
> >>>existing SCSI subsystem. People will use it for/with other parts if it
> >>
> >>
> >>SAS is ultimately SCSI.  I'll just have to write my own SCSI core.
> >>_We_ together can do this in parallel to the old SCSI Core.
> > 
> > 
> > You should have stated this plainly, from the start.
> > 
> > If you want to do your own SCSI layer, you need to do it at the block 
> > layer rather than poking around drivers/scsi/
> 
> So now you are saying that I should _not_ poke at drivers/scsi?
> (as I haven't done)
> 
> Are you going to make up your mind?

Luben, I think you are missing the distinction being made here and that
distinction is very important.

It is *critical* to hardware vendors, to the linux community, and even
at this point to some of your competitors in the HBA space that we find
the best solutions that work well for *everyone*.  The more often we
wind up with independent, unique stacks and unrelated methods and
mechanisms in the kernel, the more work we all have to do to support
Linux.  If every HBA out there that thought there were following a new
and interesting technology and were going to code to the perfect ISO
or T10 or IETF layering model, the linux kernel would be one huge,
inconsistent, bloated stinking mess for the rest of us to support.

Worse, all of our customers would see different behaviors in semantics,
functionality, and support matrices for every HBA, hardware component,
or combination of platform/HBA/storage subsystem.

I believe that for you personally to find success in the Linux development
community (much as you probably do in the standards or HBA community)
is that you have to talk off your personal hat, you have to take off
your employer's hat, and you must put on the Linux community hat for
a while and see through their eyes.

In this case, Jeff and others are providing two options with a common
goal.  The common goal is to increase the overall amount of commonality
and common code in Linux in this case.

You can do that two ways:  Start with a new SCSI core library and show
with code how it works for multiple HBA vendors (this includes working
with your competitors!) OR help to evolve the current code to better
address your needs while not breaking the needs of other consumers.

Either approach is valid.  You can start sending patches to update the
SCSI core code to simplify your driver and fit with the current
community model, OR you can put forward not just a model but the
libraries and proof-of-concepts (possibly while working with other
HBA vendors) in the form of Linux kernel code to demonstrate the
viability of a new stack which satisfies the wider community goals of
ease of maintainence and ease of understanding over time.

In general, if you think you see a contraction coming from the community,
I'd encourage you to look more closely - there are some strong guiding
principles for the community.

I suggest reading through a few of these resources which might help:

http://lists.osdl.org/pipermail/os_drivers/attachments/20050426/261c7d9d/DeviceDriverDevelopmentPlan-v.02-0001.pdf

http://www.madrone.org/mentor/linux-mentoring.pdf

I'm sure others have simmilar materials floating around.  You are not
the first person to suffer from culture shock here but the sooner you
understand the goals of the community and show how to help meet those
goals (hopefully with code to substantiate your goals, and the ability
to incorporate feedback and give feedback) the sooner we'll have a working
driver in mainline.

gerrit
