Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbVF2COR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbVF2COR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 22:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbVF2CMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 22:12:13 -0400
Received: from gate.crashing.org ([63.228.1.57]:49056 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262390AbVF2CFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 22:05:32 -0400
Subject: Re: [PATCH 8/13]: PCI Err: Event delivery utility
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org, long <tlnguyen@snoqualmie.dp.intel.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Greg KH <greg@kroah.com>, ak@muc.de, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@us.ibm.com
In-Reply-To: <20050628235932.GA6429@austin.ibm.com>
References: <20050628235932.GA6429@austin.ibm.com>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 11:59:47 +1000
Message-Id: <1120010387.5133.235.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-28 at 18:59 -0500, Linas Vepstas wrote:
> pci-err-8-pci-err-event.patch
> 
> [RFC]
> 
> PCI Error distribution utility routine.  This patch defines 
> a utility routine that hasn't yet been discussed much on 
> the mailing list; I've made this architecture independent
> with the idea that various architectures may find it handy, 
> but its not directly required, or relevant, to the overall 
> EEH error recovery mechanism. (It could be buried in 
> arch-dependent code or implemented differently.)
> 
> The current design has the arch dependent code detect
> a PCI bus error.  That code uses this utility to generate 
> a detection event.  This event is then caught by PCI
> hotplug code, which drives the slot recovery. If the 
> affected device drivers have recovery callbacks, these 
> are used; all other devices are hotplugged.
> 
> There are certainly other (simpler) ways to attach the 
> arch-specific error detection code to the hot-plug mediated 
> recovery code; this routine is rather left-over from 
> earlier email discussions.  Should this stay, or not?

Certainly needs to be in a separate .h at least ... Also, you have some
lifetime issues. You probably want to do a get() on pci_dev when you put
it in your struct and put() it after the notifier... Oh wait, you are
doing pci_dev_put() ... but no pci_dev_get() ... The later must be
missing from peh_send_failure_event().

I'd keep that in arch code for now.

Ben.


