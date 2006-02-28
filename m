Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbWB1Td6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbWB1Td6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 14:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWB1Td6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 14:33:58 -0500
Received: from ns2.suse.de ([195.135.220.15]:22200 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932467AbWB1Td5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 14:33:57 -0500
From: Andi Kleen <ak@suse.de>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
Date: Tue, 28 Feb 2006 20:33:47 +0100
User-Agent: KMail/1.9.1
Cc: Benjamin LaHaise <bcrl@kvack.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <1140841250.2587.33.camel@localhost.localdomain> <20060228190354.GE24306@kvack.org> <1141154424.20227.11.camel@serpentine.pathscale.com>
In-Reply-To: <1141154424.20227.11.camel@serpentine.pathscale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602282033.48570.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 February 2006 20:20, Bryan O'Sullivan wrote:

> We added the memory barrier to *improve* performance, in addition to
> helping correctness and portability.  Without it, the CPU or north
> bridge is free to hold onto the pending writes for a while; the exact
> details of how long it will wait depend on the CPU and NB
> implementation, but on AMD64 CPUs the delay is up to 16 cycles.

Are you sure you used the right instruction? Normally CLFLUSH is used
for such things, not a write barrier which really only changes ordering.
The documentation is not fully clear, but it sounds like it could
apply to the store buffers too.

Anyways if MFENCE improved performance you're probably relying
on some very specific artifact of the microarchitecture of your 
CPU or Northbridge. I don't think it's a architecurally guaranteed
feature.
 
-Andi
