Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbWB1TUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbWB1TUa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 14:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWB1TUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 14:20:30 -0500
Received: from mx.pathscale.com ([64.160.42.68]:5852 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932452AbWB1TU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 14:20:28 -0500
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060228190354.GE24306@kvack.org>
References: <1140841250.2587.33.camel@localhost.localdomain>
	 <20060225142814.GB17844@kvack.org>
	 <1140887517.9852.4.camel@localhost.localdomain>
	 <20060225174134.GA18291@kvack.org>
	 <1141149009.24103.8.camel@camp4.serpentine.com>
	 <20060228175838.GD24306@kvack.org>
	 <1141150814.24103.37.camel@camp4.serpentine.com>
	 <20060228190354.GE24306@kvack.org>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Tue, 28 Feb 2006 11:20:24 -0800
Message-Id: <1141154424.20227.11.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-28 at 14:03 -0500, Benjamin LaHaise wrote:

> Memory barriers are not cheap.  At least for the example you provided, 
> it looks like things are overdone and performance is going to suck, so 
> it needs to be avoided if at all possible.

There's more to it than that :-)

We added the memory barrier to *improve* performance, in addition to
helping correctness and portability.  Without it, the CPU or north
bridge is free to hold onto the pending writes for a while; the exact
details of how long it will wait depend on the CPU and NB
implementation, but on AMD64 CPUs the delay is up to 16 cycles.

So if we just use wmb(), we incur a 16-cycle penalty on every packet we
send.  This has a deleterious and measurable effect on performance.

	<b

