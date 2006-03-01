Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWCATnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWCATnN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 14:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWCATnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 14:43:13 -0500
Received: from mx.pathscale.com ([64.160.42.68]:16608 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932096AbWCATnN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 14:43:13 -0500
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Andi Kleen <ak@suse.de>
Cc: Benjamin LaHaise <bcrl@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200603012027.55494.ak@suse.de>
References: <1140841250.2587.33.camel@localhost.localdomain>
	 <200602282033.48570.ak@suse.de>
	 <1141240823.2899.84.camel@localhost.localdomain>
	 <200603012027.55494.ak@suse.de>
Content-Type: text/plain
Date: Wed, 01 Mar 2006 11:43:26 -0800
Message-Id: <1141242206.2899.109.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 (2.5.90-2.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-01 at 20:27 +0100, Andi Kleen wrote:

> I don't interpret it as being a full synchronous write.

Nor do I.  We don't expect or need the write to make it all the way to
the device.  We already do config space reads for the tiny handful of
non-performance-critical cases where we need to know that a write has in
fact made it to the device.

>  It's just a barrier
> preventing reordering.  So the writes before could be in theory stuck
> forever in some buffer - it just means they won't be later than the writes
> after the fence.

At worst, they'll be off the CPU (guaranteed per spec, as I already
quoted for you), and on the northbridge.  It might hold on to them for a
bit in turn, but there's nothing we can do about that except a config
space read, and we don't need to guarantee that the write has completely
gone to the device.  Real northbridges just don't buffer writes for very
long.

> Implementing the fences in the way your're suggesting would be very costly
> because it could make them potentially stall for thousands of cycles.

But it *doesn't*.  On existing CPUs and systems, today, the phantom
worse-case semantics you are conjuring up simply do not exist.  If
someone builds such an asinine system, the right approach is to handle
it once it exists.

	<b

-- 
Bryan O'Sullivan <bos@pathscale.com>

