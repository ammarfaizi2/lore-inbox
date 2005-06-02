Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVFBDDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVFBDDt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 23:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVFBDDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 23:03:48 -0400
Received: from mailhost.somanetworks.com ([216.126.67.42]:8867 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id S261279AbVFBDDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 23:03:45 -0400
Date: Wed, 1 Jun 2005 23:03:40 -0400 (EDT)
From: Scott Murray <scottm@somanetworks.com>
X-X-Sender: scottm@rancor.yyz.somanetworks.com
To: Prarit Bhargava <prarit@sgi.com>
cc: Greg K-H <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] PCI Hotplug: more CPCI updates
In-Reply-To: <429E7304.3060702@sgi.com>
Message-ID: <Pine.LNX.4.58.0506012257120.32742@rancor.yyz.somanetworks.com>
References: <11176025242587@kroah.com> <429E71CB.3010609@sgi.com>
 <429E7304.3060702@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2005, Prarit Bhargava wrote:

> Prarit Bhargava wrote:
> > Greg KH wrote:
> > 
> >> [PATCH] PCI Hotplug: more CPCI updates
> > 
> > 
> >> - Switch to pci_get_slot instead of deprecated pci_find_slot.
> >> - A bunch of CodingStyle fixes.
> > 
> > 
> >> -            }
> >> +        dev = pci_get_slot(slot->bus, PCI_DEVFN(slot->number, 0));
> >> +        if (dev) {
> >> +            if (update_adapter_status(slot->hotplug_slot, 1))
> >> +                warn("failure to update adapter file");
> >> +            if (update_latch_status(slot->hotplug_slot, 1))
> >> +                warn("failure to update latch file");
> >> +            slot->dev = dev;
> >>          }
> >>      }
> > 
> > 
> > I don't claim to know the code as well as Scott or Greg does, but I 
> > don't see a pci_put_dev for the slot->dev to clean up the usage count?
> 
> s/pci_put_dev/pci_dev_put/g

Sorry Prarit, when you suggested I switch over to pci_get_slot in your 
previous comments to me, I didn't look that closely and missed the 
reference counting.  Greg, I think the required fix is just a couple of 
lines in my hotplug slot release function, I'll code it up and test it 
ASAP tomorrow with an eye on getting a patch off by early afternoon EDT.

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com
