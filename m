Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262320AbVC2GSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbVC2GSU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 01:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbVC2GST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 01:18:19 -0500
Received: from main.gmane.org ([80.91.229.2]:23014 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262320AbVC2GSD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 01:18:03 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kevin Puetz <puetzk@puetzk.org>
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
Date: Tue, 29 Mar 2005 00:17:35 -0600
Message-ID: <d2arsf$2ij$1@sea.gmane.org>
References: <20050326182828.GA8540@kroah.com> <Pine.LNX.4.10.10503281632100.18224-100000@mtfhpc.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 12-219-33-63.client.mchsi.com
User-Agent: KNode/0.8.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Fortescue wrote:

> Hi Greg,
> 
> If you read the Linux Kernel header file "linux/module.h", there is a
> section about Licenses. If "Proprietary" licences are not leagal, then why
> are they supported ?

Because it does want to let module authors tell the truth, however bleak.
The GPL is quite unambiguous on the subject - the answer is "not allowed".
But the GPL is a copyright license, not an EULA-style contract. If you feel
confident that you can defend a case claiming that your driver was a
derived work, it may not be necessary to agree to the terms at all. Only if
the additional rights granted by GPL (such as the right to distribute
derived works) are required, are you forced to accept it's terms in
exchange for such rights. 

There are at least some who grudgingly accept that it may be possible to
write drivers which are not derived works, at least if they stick to a
interfaces which are widespread and in not specific to Linux. This is
arguably a weakness of the GPL-as-copyright-license, but given the ideals
it represents, arguing to strengthen the laws would be most
counterproductive :-)

> The implication of providing support for them in the header file is that
> it is leagal to create and supply them.

This is certainly something that could be argued from, but I don't know how
successful you it would be. Only a court case could tell.

> I am porting a driver to Linux for a third party. I do not know if they
> whish to release the Linux driver under GPL so I have assumed (because of
> the nature of the hardware) that they do not whish to. I will discus this
> matter with them when I have finnished the driver.

I would suggest you discuss it now; they take a while to get legal advice
and make their decision.

> The use of header files to build a propriatory object files/binaries or
> the use of GCC to compile such a file does not breach GPL as if it did,
> GCC and GLIBC would not be available for non GPL platforms and it would
> not be posible to provide propriatory code for use in a Linux/GNU
> environment.

glibc and libgcc are not under a vanilla GPL. gcc itself is GPL, but it's
fairly well accepted that the output of a tool is not a derived work and
does not fall under that tool's copyright. Otherwise microsoft would be
pocketing a slice of the royalties on everything written using Word. Even
they haven't been that bold yet :-) In any case, these licenses carry
specific exemptions allowing proprietary use. This is a deliberate choice
on the part of their maintainers.

> The Linux Kernel internal APIs are not mensioned in the Kernel GPL so it
> can be argued quite reasonably that the APIs are not coverd by the GPL.

I fail to see how this is even relevent. The kernel COPYING file
specifically states the widely held (I won't claim universal - there's
bound to be someone who would otherwise disagree) belief that the syscall
interface is sufficiently generic; namely, that proprietary use at that
level does not carry any implication that the proprietary component is a
derived work. But this is only a clarification; it does this as the GPL's
interpretation is quite broad. Nothing specific is said about internal
kernel API, so it's covered by the GPL.

> With regard to derived work - mensioned in a number of responses, a new
> driver ported from MS Windows is derived from the Windows Driver not the
> Linux Kernel. If it can be shown that there are sections of code in the

This is the sort of claim that nVidia and ATI make - that the proprietary
portions are not derived works. The fact that they are portable across
multiple OSes, make use of only basic OS services, and predate the linux
port, are reasonably good arguments to that effect. Assuming they aren't
just crazy (which seems a good assumption) they apparently think they can
win if anyone ever challenges them. Seemingly, so do most of the people
complaining, since no court case has yet appeared about it.

> new driver that have been coppied from other Linux drivers, then there is
> a good argument with regard to derived code but it would still be very
> difficult to prove that this code had not been written totally
> independantly from the Linux drivers containing the same or similar code.
> In addition the driver is being built as a module, out side of the kernel
> source tree and as a result can be considered to be separate enterty to

Built inside or outside is not a particularly compelling argument, though it
certainly would be worth a mention if trying to put a case together.

> the kernel. If it was required to be built into the kernel as apposed to
> being a Kernel Module then it would be totally different and the driver
> would need to be GPL.

It wouldn't be all that different. Just another point of evidence in the
decision of whether or not the addition was a derived work.

> The hardware that this driver is being written for is low volume, very
> specialised (with regard to its application). The driver will only be of

And this has no bearing whatsoever on the legality, though if nobody cares
the odds of being sued are much reduced. The only case where it might
matter is if the volume is 1; if the driver will thus never be distributed
at all (just used by its creator), copyright doesn't come into play at all,
and one can do whatever one wants.

> interest to thoes who have or can aford to purchase this hardware and are
> in an appropriate buisiness sector. Given this, I see little point in
> making the driver GPL as the code will be of little interest to anyone who

Other than access to handy, but linux-only things like sysfs, removal of the
need to maintain huge numbers of different binaries (SMP, 32/64, Preempt,
kernel versions, etc), and receipt of a lot less whining :-)

> will not already have access to it through the supplier of the hardware it
> is written for. For thoes writing Linux drivers, there are a number of
> Books that can be read on this subject.
> 
> The Linux Kernel used with the driver will be probably purchesed
> independently as part of a standard Linux distribution. As I am not
> changing any of that code, I am not in breach of the GPL associated with

Distributing a derived work without permission of the copyright holder is
every bit as illegal as distributing a modified work, or a simple knockoff
copy. Such permission is granted, but *only* to GPLed modules, and anything
else is a claim that the work is independent and didn't need any specific
permission.

> that code. A device driver may or may not be derived from other drivers in
> the Linux Kernel. In this case it is not so it is not covered by the
> Kernel GPL. If the customer requires a linux kernel then I will be quite
> happy to provide one configured to meet their requirements with all the
> source code (as available from the various ftp mirrors) and any private
> patches I may have applied, as per the terms and conditions in the
> "COPYING" file in the kernel source tree.
> 
> I wait with interest for your comments.
> 
> Regards
> Mark Fortescue.

