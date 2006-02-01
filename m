Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423000AbWBAWzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423000AbWBAWzq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 17:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423001AbWBAWzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 17:55:45 -0500
Received: from ns2.suse.de ([195.135.220.15]:46251 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1423000AbWBAWzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 17:55:45 -0500
From: Andi Kleen <ak@suse.de>
To: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: [PATCH] AMD64: fix mce_cpu_quirks typos
Date: Wed, 1 Feb 2006 21:43:19 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <87fyn2yjpr.fsf@mid.deneb.enyo.de.suse.lists.linux.kernel> <p731wymn94l.fsf@verdi.suse.de> <87ek2mx22i.fsf@mid.deneb.enyo.de>
In-Reply-To: <87ek2mx22i.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602012143.19867.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 February 2006 21:21, Florian Weimer wrote:

> > but it's still logged and the regular polling picks them up
> > anyways. I have not found a nice way to handle this (other than
> > adding a ugly CPU specific special case in the middle of the nice
> > cpu independent machine check handler, which I couldn't bring myself
> > to do so far...)
> 
> Someone tried to track these messages down together with someone else
> from AMD, but they never got it finished.

They could have saved themselves a lot of work by just asking
at the right mailing lists (which is not l-k BTW)
 
> For reference, here's the lspci -n output for the system.  It's a
> two-way Opteron box (248, 2.2 GHz, stepping 10) with 8 GB of RAM.
> (BIOS and chipset details are not available to me at the moment.)
> The MCEs only appeared after a switch to a 64-bit kernel (2.6.15.2),
> adding the second CPU, along with 4 GB of RAM.  Previously, the box
> ran 2.6.13 in 32-bit mode, and no MCEs appeared regularly.

The 64bit kernel uses the AGP aperture as IOMMU, the 32bit kernel doesn't.
It's a known documented hardware bug that this causes spurious GART errors.
That is why the BIOS and Linux disable them. Unfortunately the Linux
MCE handler is too thorough and picks them up anyways as corrected events.

-Andi
