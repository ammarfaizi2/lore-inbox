Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932588AbWBYRUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588AbWBYRUV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 12:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbWBYRUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 12:20:21 -0500
Received: from mx.pathscale.com ([64.160.42.68]:17894 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932588AbWBYRUV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 12:20:21 -0500
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200602251428.01767.ak@suse.de>
References: <1140841250.2587.33.camel@localhost.localdomain>
	 <200602250543.22421.ak@suse.de>
	 <1140852894.2587.43.camel@localhost.localdomain>
	 <200602251428.01767.ak@suse.de>
Content-Type: text/plain
Date: Sat, 25 Feb 2006 09:20:34 -0800
Message-Id: <1140888034.9852.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 (2.5.90-2.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-02-25 at 14:28 +0100, Andi Kleen wrote:

> It's still totally unclear how you can write portable write combining code.
> 
> I think the basic idea is weird. You're basically writing something
> that doesn't follow the normal MMIO rules of Linux drivers and you're 
> trying to do this portable, which won't work anyways because 
> there is no portable way to do this.

This is definitely a problem.  We have an x86-specific hack in our
driver that diddles the MTRRs to make sure that our MMIO space has write
combining enabled.

On other platforms, it looks like write combining, if supported at all,
is implemented in the northbridge.  For those, I think we'd need to mark
the device's mapping as cacheable.

> Before we can add such a macro I suspect you would first 
> need to provide some spec how that "portable write combining"
> is supposed to work and get feedback from the other architectures.
> 
> Or keep it in architecture specific code, then the generic macro
> isn't needed.

OK, thanks for the feedback.

	<b

-- 
Bryan O'Sullivan <bos@pathscale.com>

