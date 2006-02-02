Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbWBBM7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbWBBM7K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 07:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbWBBM7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 07:59:10 -0500
Received: from mail.enyo.de ([212.9.189.167]:1167 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S1751023AbWBBM7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 07:59:08 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [PATCH] AMD64: fix mce_cpu_quirks typos
References: <87fyn2yjpr.fsf@mid.deneb.enyo.de.suse.lists.linux.kernel>
	<p731wymn94l.fsf@verdi.suse.de> <87ek2mx22i.fsf@mid.deneb.enyo.de>
	<200602012143.19867.ak@suse.de>
Date: Thu, 02 Feb 2006 13:59:05 +0100
In-Reply-To: <200602012143.19867.ak@suse.de> (Andi Kleen's message of "Wed, 1
	Feb 2006 21:43:19 +0100")
Message-ID: <87d5i5or1i.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen:

> On Wednesday 01 February 2006 21:21, Florian Weimer wrote:
>
>> > but it's still logged and the regular polling picks them up
>> > anyways. I have not found a nice way to handle this (other than
>> > adding a ugly CPU specific special case in the middle of the nice
>> > cpu independent machine check handler, which I couldn't bring myself
>> > to do so far...)
>> 
>> Someone tried to track these messages down together with someone else
>> from AMD, but they never got it finished.
>
> They could have saved themselves a lot of work by just asking
> at the right mailing lists (which is not l-k BTW)

Marc Michelsen brought this up last year on <discuss@x86-64.org>
(which I suppose is the right list), but he didn't receive many
comments (not publicly, at least).

> The 64bit kernel uses the AGP aperture as IOMMU, the 32bit kernel
> doesn't.  It's a known documented hardware bug that this causes
> spurious GART errors.

Someone from AMD told Marc that fixes in pci-gart.c (probably related
to iommu_fullflush, see the comment there) are supposed to suppress
the error in the first place.  That's why we are a bit confused
whether the errors are really harmless (our machines do run stable,
though).

It also seems that the bug is not as well-documented as it deserves to
be.  (The search engines will pick up this thread, though.)  Our
vendor told us to have the RAM tested, for instance. 8->

> That is why the BIOS and Linux disable them. Unfortunately the Linux
> MCE handler is too thorough and picks them up anyways as corrected
> events.

If the errors are really harmless, it probably makes sense to add a
warning to the mcelog output that this MCE is expected, preferably
with an AMD errata reference.

Filtering in the kernel seems to be overkill because the rate of those
spurious MCEs is fairly low, and they won't lead to loss of other,
more important MCEs.
