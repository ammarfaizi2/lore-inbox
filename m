Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbWBBNbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbWBBNbn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 08:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbWBBNbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 08:31:43 -0500
Received: from ns.suse.de ([195.135.220.2]:10934 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751053AbWBBNbm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 08:31:42 -0500
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: [PATCH] AMD64: fix mce_cpu_quirks typos
Date: Thu, 2 Feb 2006 14:17:00 +0100
User-Agent: KMail/1.8.2
Cc: Florian Weimer <fw@deneb.enyo.de>, linux-kernel@vger.kernel.org
References: <87fyn2yjpr.fsf@mid.deneb.enyo.de.suse.lists.linux.kernel> <200602012143.19867.ak@suse.de> <87d5i5or1i.fsf@mid.deneb.enyo.de>
In-Reply-To: <87d5i5or1i.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602021417.00477.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 February 2006 13:59, Florian Weimer wrote:

> 
> > The 64bit kernel uses the AGP aperture as IOMMU, the 32bit kernel
> > doesn't.  It's a known documented hardware bug that this causes
> > spurious GART errors.
> 
> Someone from AMD told Marc that fixes in pci-gart.c (probably related
> to iommu_fullflush, see the comment there) are supposed to suppress
> the error in the first place.  That's why we are a bit confused
> whether the errors are really harmless (our machines do run stable,
> though).

Long ago there was a real bug in this area which caused these GART 
errors legitimately, but even what that one was fixed they still 
occurred occasionally.

I was told back then that there was a bug in the Northbridge
that causes them occasionally - that is why BIOS turn them off.
The kernel did that eventually too.

Of course there is some probability that you have a driver
that accesses the buffers after unmapping. The GART is currently
not flushed on unmapping because that would be 

Normally such drivers are caught though because some other IOMMU
implementations on other architectures have stronger checking in this area.


-Andi
