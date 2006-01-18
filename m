Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbWARRvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWARRvP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 12:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWARRvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 12:51:15 -0500
Received: from cantor2.suse.de ([195.135.220.15]:30625 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932393AbWARRvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 12:51:14 -0500
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: Why is wmb() a no-op on x86_64?
Date: Wed, 18 Jan 2006 18:31:01 +0100
User-Agent: KMail/1.8.2
Cc: Jes Sorensen <jes@sgi.com>, "Bryan O'Sullivan" <bos@pathscale.com>,
       linux-kernel@vger.kernel.org
References: <1137601417.4757.38.camel@serpentine.pathscale.com> <1137603169.4757.50.camel@serpentine.pathscale.com> <yq04q41qxcw.fsf@jaguar.mkp.net>
In-Reply-To: <yq04q41qxcw.fsf@jaguar.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601181831.01688.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 January 2006 18:06, Jes Sorensen wrote:
> >>>>> "Bryan" == Bryan O'Sullivan <bos@pathscale.com> writes:
> 
> Bryan> On Wed, 2006-01-18 at 17:29 +0100, Andi Kleen wrote:
> >> Why do you need the barrier?
> 
> Bryan> On x86_64, we fiddle with the MTRRs to enable write combining,
> Bryan> which makes a huge difference to performance.  It's not clear
> Bryan> to me what we should even do on other architectures, since the
> Bryan> only generic entry point that even exposes write combining is
> Bryan> pci_mmap_page_range, which is for PCI mmap through userspace,
> Bryan> and half the arches I've looked at ignore its write_combine
> Bryan> parameter.
> 
> A job for mmiowb() perhaps?

No, normal IO mappings are also not write combining on x86, so
it's not needed there.

I guess it's best to just define a wmb_wc() for i386/x86-64 right now
and use that in ipath. I suspect it won't compile anywhere else
anyways.

-Andi
