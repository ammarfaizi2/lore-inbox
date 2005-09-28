Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965254AbVI1CCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965254AbVI1CCZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 22:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965250AbVI1CCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 22:02:24 -0400
Received: from mail.dvmed.net ([216.237.124.58]:20702 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965248AbVI1CCY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 22:02:24 -0400
Message-ID: <4339F9A8.2030709@pobox.com>
Date: Tue, 27 Sep 2005 22:02:16 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luben Tuikov <luben_tuikov@adaptec.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <43384E28.8030207@adaptec.com> <4339BFE9.1060604@pobox.com> <4339CCD6.5010409@adaptec.com>
In-Reply-To: <4339CCD6.5010409@adaptec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luben Tuikov wrote:
> On 09/27/05 17:55, Jeff Garzik wrote:
> 
>>* Avoids existing SAS code, rather than working with it.

> No, it's the _other_ way around.  There is NO existing
> SAS code.

Incorrect, just look in the latest upstream kernel.


>>* Avoids existing SATA code, rather than working with it.
> 
> 
> FUD!  Why?  It does _not_ use SATA code at all.

That's the problem.


> Why?  SATA devices are discovered on the domain, but
> there is _no_ SATL in the kernel to represent them.
> 
> And libata is _not_ SATL.  The reasons are that

libata-scsi.c is the SAT translation layer.


>>* Avoids (rather than fix) several SCSI core false dependencies on HCIL. 
>>  Results in code duplication and/or avoidance of needed code.
> 
> 
> No, not true.  It _integrates_ with SCSI Core.  The sad truth
> is that SCSI Core knows only HCIL.

That's something that needs fixing, for SAS.


> I repeat again that I had this code _long_ before Christoph
> ever dreamt up SAS.  And he got my code via James B sometime
> before OLS this year.  I think he got it July 12, 2005.
> 
> The question is: why didn't _he_ use the solution already
> available?

Because it has the problems listed time and again.


> You have to understand the differences between MPT and open
> transport architecture.
> 
> At some point I thought Christoph seemed to have understood it.
> Now I'm not sure any more.
> 
> Now since the open transport solution completely encompasses
> and _absolves_ MPT, it is not hard for an MPT driver to
> generate a bunch of events and use that infrastructure.

The SAS transport class is designed to support both firmware-based 
devices like MPT, and non-firmware devices such as Adaptec.

Sure it might need patches -- send patches, work with people, rather 
than ignoring existing work.


>>* Maintainer reminds me of my ATA mentor, Andre Hedrick:  knows his 
>>shit, but has difficulties working with the community.  May need a 
>>filter if we want long term maintenance to continue.
> 
> 
> I take offence in your liking me to Andre -- I don't know
> Andre personally, but is seems that you're expressing personal
> opinion against him, against me and labeling me in some way.
> 
> I take offence in that, Jeff.
> 
> Why are you making this a _political_ and personal game?
> 
> All you're doing is trying to aliken me to someone and
> brandish me as someone I'm not.
> 
> This is rude, offensive and done in desperation.
> 
> Shall we concentrate on the _technical_ part of
> the argument?
> 
> I repeat again: _technical_ part of the argument.

We've been over the technical stuff time and again.  That's the 
maintainer problem.  We need someone who will listen to the community.


>>Easy path: make Adaptec's solution a block driver, which allows it to 
>>sidestep all the "doesn't play well with others" issues.  Still an 
> 
> 
> What _exactly_ does it mean "don't play well with others"?

It means not taking feedback, and working around rather than with the 
SCSI core.


>>Adaptec-only solution, but at least its in a separate playpen.
> 
> 
> I'm sure James Bottomley will move from SCSI Core to the block
> layer as he did for IDR. hehehe :-)
> 
> And no, it is not Adaptec's only solution.  Your BCM8603 SAS
> LLDD when you write it could use it without any problems.
> 
> 
>>Hard path: Update the SCSI core and libata to work with SATA+SAS 
>>hardware such as Adaptec's.
> 
> 
> Cannot do for libata -- ever.  Why?  You know best: because
> libata uses direct access to the hardware!  There is no
> layered architecture.

Then you don't understand the ->qc_{prep,issue} hooks.  That should get 
you 90% of the way there, if not 99%.


> What you need to do is to write a SATL layer, just as you can
> see in SAT-r6, page 2, Figure 3.  I'm on top of this already.

Re-read libata-scsi.c, and submit any patches you feel are needed.


> The code doesn't alter Linux SCSI or anyone else's behaviour.
> It only _provides_ SAS support to the kernel.

That's one of the problems: It should update the SCSI core.

	Jeff


