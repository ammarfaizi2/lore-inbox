Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756383AbWK0TBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756383AbWK0TBE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 14:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757833AbWK0TBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 14:01:03 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:36764 "EHLO omx1.sgi.com")
	by vger.kernel.org with ESMTP id S1756383AbWK0TBB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 14:01:01 -0500
Date: Mon, 27 Nov 2006 11:00:24 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch] x86: unify/rewrite SMP TSC sync code
In-Reply-To: <200611241813.13205.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0611271055560.2503@schroedinger.engr.sgi.com>
References: <20061124170246.GA9956@elte.hu> <200611241813.13205.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2006, Andi Kleen wrote:

> The trouble is that people are using the RDTSC anyways even if the
> kernel doesn't. So some synchronization is probably a good idea.

It is better to simply leave TSC alone if unsynchronized. If TSCs appear 
to be in sync (through some sporadic "synchronization") then people will 
be tempted to use RDTSC because it seems to work/ However, RDTSC will 
sporadically yield incoherent values (i.e. time earlier than last TSC 
read) if we have no full synchronization.
