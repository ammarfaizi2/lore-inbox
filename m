Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263781AbUC3R4D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 12:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263785AbUC3Rzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 12:55:50 -0500
Received: from mail.scsiguy.com ([63.229.232.106]:41744 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP id S263781AbUC3Rz0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 12:55:26 -0500
Date: Tue, 30 Mar 2004 10:54:46 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Lincoln Dale <ltd@cisco.com>
cc: Jeff Garzik <jgarzik@pobox.com>, Kevin Corry <kevcorry@us.ibm.com>,
       linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       linux-raid@vger.kernel.org
Subject: Re: "Enhanced" MD code avaible for review
Message-ID: <862110000.1080669286@aslan.btc.adaptec.com>
In-Reply-To: <5.1.0.14.2.20040328094233.0546fec8@mira-sjcm-3.cisco.com>
References: <406375B0.5040406@pobox.com> <760890000.1079727553@aslan.btc.adaptec.com> <16480.61927.863086.637055@notabene.cse.unsw.edu.au> <40624235.30108@pobox.com> <200403251200.35199.kevcorry@us.ibm.com> <40632804.1020101@pobox.com> <1030470000.1080257746@aslan.btc.adaptec.com> <406375B0.5040406@pobox.com> <5.1.0.14.2.20040328094233.0546fec8@mira-sjcm-3.cisco.com>
X-Mailer: Mulberry/3.1.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At 03:43 AM 27/03/2004, Justin T. Gibbs wrote:
>> I posted a rather detailed, technical, analysis of what I believe would
>> be required to make this work correctly using a userland approach.  The
>> only response I've received is from Neil Brown.  Please, point out, in
>> a technical fashion, how you would address the feature set being proposed:
> 
> i'll have a go.
> 
> your position is one of "put it all in the kernel".
> Jeff, Neil, Kevin et al is one of "it can live in userspace".

Please don't misrepresent or over simplify my statements.  What
I have said is that meta-data reading and writing should occur in
only one place.  Since, as has already been acknowledged by many,
meta-data updates are required in the kernel, that means this support
should be handled in the kernel.  Any other solution adds complexity
and size to the solution.

> to that end, i agree with the userspace approach.
> the way i personally believe that it SHOULD happen is that you tie
> your metadata format (and RAID format, if its different to others) into DM.

Saying how you think something should happen without any technical
argument for it, doesn't help me to understand the benefits of your
approach.

...

> perhaps that means that you guys could provide enhancements to grub/lilo
> if they are insufficient for things like finding a secondary copy of
> initrd/vmlinuz. (if such issues exist, wouldn't it be better to do things
> the "open source way" and help improve the overall tools, if the end goal
> ends up being the same: enabling YOUR system to work better?)

I don't understand your argument.  We have improved an already existing
opensource driver to provide this functionality.  This is not the
OpenSource way?

> then answering your other points:

Again, you have presented strategies that may or may not work, but
no technical arguments for their superiority over placing meta-data
in the kernel.

> there may be less lines of code involved in "entirely in kernel" for YOUR
> hardware -- but what about when 4 other storage vendors come out with such
> a card?

There will be less lines of code total for any vendor that decides to
add a new meta-data type.  All the vendor has to do is provide a meta-data
module.  There are no changes to the userland utilities (they know nothing
about specific meta-data formats), to the RAID transform modules, or to
the core of EMD.  If this were not the case, there would be little point
to the EMD work.

> what if someone wants to use your card in conjunction with the storage
> being multipathed or replicated automatically?
> what about when someone wants to create snapshots for backups?
> 
> all that functionality has to then go into your EMD driver.

No.  DM already works on any block device exported to the kernel.
EMD exports its devices as block devices.  Thus, all of the DM
functionality you are talking about is also available for EMD.

--
Justin

