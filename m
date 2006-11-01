Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752438AbWKAVQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752438AbWKAVQK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 16:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752440AbWKAVQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 16:16:09 -0500
Received: from ns2.suse.de ([195.135.220.15]:64412 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752433AbWKAVQG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 16:16:06 -0500
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.19-rc <-> ThinkPads
Date: Wed, 1 Nov 2006 22:15:51 +0100
User-Agent: KMail/1.9.5
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, Ernst Herzberg <earny@net4u.de>,
       Len Brown <lenb@kernel.org>, Adrian Bunk <bunk@stusta.de>,
       Hugh Dickins <hugh@veritas.com>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org, linux-pm@osdl.org,
       Martin Lorenz <martin@lorenz.eu.org>
References: <Pine.LNX.4.64.0610312123320.25218@g5.osdl.org> <200611012034.06128.ak@suse.de> <Pine.LNX.4.64.0611011148130.25218@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611011148130.25218@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611012215.51459.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 November 2006 20:52, Linus Torvalds wrote:
> 
> On Wed, 1 Nov 2006, Andi Kleen wrote:
> > 
> > Fix race in IO-APIC routing entry setup.
> > 
> > Interrupt could happen between setting the IO-APIC entry
> > and setting its interrupt data.
> 
> This doesn't fix anything at all.
> 
> The interrupt can come in on another CPU, 

Only BP should be active at this point. At least not until
we implement IO-APIC hotplug, but so far that isn't there.

Ok in theory the BIOS could have put the other CPUs into
weird states where they are still doing something and causing
interrupts, but that would be a BIOS bug.

I suppose it could happen with kexec, but that has still
other problems anyways.

The common case of no kexec shouldn't be affected at least.

-Andi
