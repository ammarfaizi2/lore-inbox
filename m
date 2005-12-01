Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbVLAOaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbVLAOaF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 09:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbVLAOaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 09:30:05 -0500
Received: from nproxy.gmail.com ([64.233.182.204]:31276 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932155AbVLAOaE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 09:30:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H8tuExuPSQRlM58O1ljoHH2csGmyphVOfLklL45RQl7mo5b484oWW55dvG4uaO+bwY2TGeajMm4G3sgkRuwCHzQRL8VK64ej916W0kEog8nkFfOfizQgjGx64MDjppyVDgRZOorv6sRlr+mRf31v51Z9w5Wj5c/zwQ3iSeMGInk=
Message-ID: <6278d2220512010630n32174125vbcaac736d169849@mail.gmail.com>
Date: Thu, 1 Dec 2005 14:30:01 +0000
From: Daniel J Blueman <daniel.blueman@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: PAT status?
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
In-Reply-To: <p73zmnlg5mr.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6278d2220511300404i27878f02mf5d8c948256d36e8@mail.gmail.com>
	 <p73zmnlg5mr.fsf@verdi.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Nov 2005 14:58:20 -0700, Andi Kleen <ak@suse.de> wrote:
> Daniel J Blueman <daniel.blueman@gmail.com> writes:
>
> > IIRC, the kernel (c. 2.6.14) still does nothing to setup the
> > processors' PAT registers to enable write combining in one of the
> > slots - the defaults the BIOS establishes do not cover this. Once this
> > is done, drivers would readily be able to set page flags for a
> > particular PAT slot, and MTRRs can (almost) be safely ignored.
>
> As usual when something hasn't been done yet it's not that easy...
>
> Problem is that they would very likely create very subtle problems
> by creating conflicting mappings with the different cache attributes,
> which leads to cache corruption and other nasty issues.
>
> That is why more infrastructure is needed in the kernel to do this
> properly.

The steps I see that are needed are:

1. on initialisation, the kernel would select one PAT slot to setup
with the (eg) write combining attribute (and other slots for other
attrs)

2. expose an interface to the drivers to set the appropriate bit in a
page (range), based on searching the PAT slots, or using a known one

Intel document [1, section 10] that the uncacheable setting from PAT
or MTRR mechanisms takes precedence over the other mechanism, so the
situation will always be 'safe' (ie w/o cache corruption), and that
write-combining takes precedence over write-through or write-back MTRR
regions.

There are implementations that setup the PAT registers in userland or
in-driver and use the appropriate page flags to refer to the correct
PAT slot.

Daniel

--- [1]

ftp://download.intel.com/design/Pentium4/manuals/25366817.pdf
___
Daniel J Blueman
