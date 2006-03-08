Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWCHVVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWCHVVz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 16:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWCHVVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 16:21:55 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:16874 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S932114AbWCHVVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 16:21:54 -0500
Date: Thu, 9 Mar 2006 00:21:53 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: thockin@hockin.org
Cc: Greg KH <greg@kroah.com>, Tejun Heo <htejun@gmail.com>,
       Jeff Garzik <jeff@garzik.org>, Kumar Gala <galak@kernel.crashing.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: proper way to assign fixed PCI resources to a "hotplug" device
Message-ID: <20060309002153.A9651@jurassic.park.msu.ru>
References: <Pine.LNX.4.44.0603031638050.30957-100000@gate.crashing.org> <4408CEC8.7040507@garzik.org> <20060308020028.GB26028@kroah.com> <440E4203.7040303@gmail.com> <20060308052723.GD29867@kroah.com> <20060308143952.B4851@jurassic.park.msu.ru> <20060308164041.GA31828@hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060308164041.GA31828@hockin.org>; from thockin@hockin.org on Wed, Mar 08, 2006 at 08:40:42AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 08:40:42AM -0800, thockin@hockin.org wrote:
> Assigned from what pool?  BIOS most likely sizes the hole to be a pretty
> tight fit for all the resources it knows about.  If there is suddenly a
> new resource, you're in trouble.

This can only be true when device in question is behind a pci-to-pci
bridge (which is obviously not the case for ICH controllers you mentioned).
Otherwise we have plenty of MMIO space.

> We could teach linux about chipsets and let Linux re-do the whole
> PCI-allocation process.   But that's not an easy task, and is probably a
> contentious idea.

Linux knows how to do this for years. Actually, this is the way how alpha
and some other platforms work. Since 2.6.13, this pretty much applies to
x86 as well (we do respect BIOS PCI allocations, but we clean the things
up after BIOS quite aggressively - see pci_assign_unassigned_resources() call).

Ivan.
