Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbVI0WvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbVI0WvO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 18:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbVI0WvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 18:51:14 -0400
Received: from magic.adaptec.com ([216.52.22.17]:4809 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1751124AbVI0WvN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 18:51:13 -0400
Message-ID: <4339CCD6.5010409@adaptec.com>
Date: Tue, 27 Sep 2005 18:51:02 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <43384E28.8030207@adaptec.com> <4339BFE9.1060604@pobox.com>
In-Reply-To: <4339BFE9.1060604@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Sep 2005 22:51:11.0661 (UTC) FILETIME=[F4FC75D0:01C5C3B5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/27/05 17:55, Jeff Garzik wrote:
> * Avoids existing SAS code, rather than working with it.

No, it's the _other_ way around.  There is NO existing
SAS code.

My SAS code has been around _long_ before Christophs
code.

Christoph's code is
 * MPT based only,
 * doesn't follow a spec to save its life,
 * far inferior in SAS capabilities and SAS representation
   again, due to the fact that it is MPT based.

Since the whole point of MPT is to _hide_ the transport.

> * Avoids existing SATA code, rather than working with it.

FUD!  Why?  It does _not_ use SATA code at all.

Why?  SATA devices are discovered on the domain, but
there is _no_ SATL in the kernel to represent them.

And libata is _not_ SATL.  The reasons are that
libata is closely coupled to the hardware, i.e.
ata_port.

While in SAS open transport architecures, you'd have
execute ATA/SAS/SMP task just as you have in aic-94xx.
Why? Because all the chip is, is an interface to the
interconect.

But I'm sure you know all this having looked at the
specs of BCM8603.

> * Avoids (rather than fix) several SCSI core false dependencies on HCIL. 
>   Results in code duplication and/or avoidance of needed code.

No, not true.  It _integrates_ with SCSI Core.  The sad truth
is that SCSI Core knows only HCIL.

Jeff, please be more specific.

> * So far, it's an Adaptec-only solution.  Since it pointedly avoids the 
> existing SAS transport code, this results in two SAS solutions in Linux: 
> one for Adaptec, one for {everyone else}.

Hmm, again: _architecture_.  And you have to stop these
accusations: "pointedly avoids the existing SAS transport code".

I repeat again that I had this code _long_ before Christoph
ever dreamt up SAS.  And he got my code via James B sometime
before OLS this year.  I think he got it July 12, 2005.

The question is: why didn't _he_ use the solution already
available?

You have to understand the differences between MPT and open
transport architecture.

At some point I thought Christoph seemed to have understood it.
Now I'm not sure any more.

Now since the open transport solution completely encompasses
and _absolves_ MPT, it is not hard for an MPT driver to
generate a bunch of events and use that infrastructure.

> * Maintainer reminds me of my ATA mentor, Andre Hedrick:  knows his 
> shit, but has difficulties working with the community.  May need a 
> filter if we want long term maintenance to continue.

I take offence in your liking me to Andre -- I don't know
Andre personally, but is seems that you're expressing personal
opinion against him, against me and labeling me in some way.

I take offence in that, Jeff.

Why are you making this a _political_ and personal game?

All you're doing is trying to aliken me to someone and
brandish me as someone I'm not.

This is rude, offensive and done in desperation.

Shall we concentrate on the _technical_ part of
the argument?

I repeat again: _technical_ part of the argument.

> Easy path: make Adaptec's solution a block driver, which allows it to 
> sidestep all the "doesn't play well with others" issues.  Still an 

What _exactly_ does it mean "don't play well with others"?

Do you mean:
 - the solution is far superiour to anything available now
 - it presents the SAS Domain in sysfs as it looks in
   the physical world,
 - does domain discovery and expander configuration,
 - allows for complete control of the domain to user space,
 - it pokes at SCSI Core's 20 year old relics.
 - it's a thorn in the flesh to other people striving for
   similar functionality.

Or do you mean:
 - it does not change a single line of code in the kernel,
 - does not break anything existing,
 - etc, etc.

> Adaptec-only solution, but at least its in a separate playpen.

I'm sure James Bottomley will move from SCSI Core to the block
layer as he did for IDR. hehehe :-)

And no, it is not Adaptec's only solution.  Your BCM8603 SAS
LLDD when you write it could use it without any problems.

> Hard path: Update the SCSI core and libata to work with SATA+SAS 
> hardware such as Adaptec's.

Cannot do for libata -- ever.  Why?  You know best: because
libata uses direct access to the hardware!  There is no
layered architecture.

What you need to do is to write a SATL layer, just as you can
see in SAT-r6, page 2, Figure 3.  I'm on top of this already.

But in order to do this you need a unified architecture
for accessing ATA devices.

Now libata, uses ata_port to do this, which is _hardware_
access.

The SAS Transport layer uses Execute SCSI RPC (defined
in SAM, provided by aic94xx) to do this.

So in effect, what SATL would end up to be is a
data transformation function.   But I digress...

> The hard path takes time, and won't be solved simply by shoving it in.

No, you can do it now.  It will not affect anyone or anything.
(Other than hurting a couple of people's pride.)

The code doesn't alter Linux SCSI or anyone else's behaviour.
It only _provides_ SAS support to the kernel.

Including it in as is would does not hurt anyone as you can
see here:
http://linux.adaptec.com/sas/git/

Concentrate on the _technical_ merit, let's be more specific.

	Luben

