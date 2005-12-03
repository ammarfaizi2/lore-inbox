Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbVLCDPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbVLCDPu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 22:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbVLCDPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 22:15:50 -0500
Received: from ns.suse.de ([195.135.220.2]:29864 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751148AbVLCDPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 22:15:49 -0500
Date: Sat, 3 Dec 2005 04:15:33 +0100
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de, ak@suse.de
Subject: Re: [PATCH 0/3] x86 PCI domain support
Message-ID: <20051203031533.GB14247@wotan.suse.de>
References: <20051203013904.GA2560@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051203013904.GA2560@havoc.gtf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2005 at 08:39:04PM -0500, Jeff Garzik wrote:
> 
> ACPI PCI support stopped short of supporting multiple PCI domains,
> which is something I need in order to support a current machine
> configuration, and something many will soon need, to support upcoming
> systems.
> 
> This is a minimal, untested implementation.  But it should work,
> provided your PCI op hooks (direct, BIOS, mmconfig) support PCI domains
> (mmconfig).

It looks like a good start.  Thanks for doing this.

It actually needs some more fixes - e.g. falling back to 
type1 if the bus is not covered in MCFG (needed for the 
K8 internal busses) and a workaround for buggy Asus BIOS with wrong MCFG.
I have that in the works.

But your changes are needed too - or at least they are correct
according to the spec. I don't know of a system that actually
has different mmconfig apertures for different busses yet.
The only case that's interesting right now is that some busses
don't support it at all, but these don't need a seg number,
just a non listing in MCFG.

Greg are you queueing this up? 

-Andi
