Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbWB1SUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbWB1SUV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 13:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbWB1SUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 13:20:21 -0500
Received: from mx.pathscale.com ([64.160.42.68]:42454 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932412AbWB1SUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 13:20:19 -0500
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060228175838.GD24306@kvack.org>
References: <1140841250.2587.33.camel@localhost.localdomain>
	 <20060225142814.GB17844@kvack.org>
	 <1140887517.9852.4.camel@localhost.localdomain>
	 <20060225174134.GA18291@kvack.org>
	 <1141149009.24103.8.camel@camp4.serpentine.com>
	 <20060228175838.GD24306@kvack.org>
Content-Type: text/plain
Date: Tue, 28 Feb 2006 10:20:14 -0800
Message-Id: <1141150814.24103.37.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-28 at 12:58 -0500, Benjamin LaHaise wrote:
> On Tue, Feb 28, 2006 at 09:50:08AM -0800, Bryan O'Sullivan wrote:
> > The last 32-bit write triggers the chip to put the packet on the wire.
> > We make sure it happens after the earlier bulk write using a barrier.
> 
> The barrier you're looking for is wmb() in asm/system.h, which is defined 
> on both SMP and UP.

No.  We're writing to a region that we've marked as write combining, so
the processor or north bridge will not write in program order.  It's
free to write out the write combining store buffers in whatever order it
feels like, unless forced to do otherwise.

	<b

