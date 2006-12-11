Return-Path: <linux-kernel-owner+w=401wt.eu-S1762555AbWLKF43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762555AbWLKF43 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 00:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762556AbWLKF43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 00:56:29 -0500
Received: from colo.lackof.org ([198.49.126.79]:59052 "EHLO colo.lackof.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762552AbWLKF42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 00:56:28 -0500
Date: Sun, 10 Dec 2006 22:56:26 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Stephen Hemminger <shemminger@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] MTHCA driver (infiniband) use new pci interfaces
Message-ID: <20061211055626.GA527@colo.lackof.org>
References: <20061208182241.786324000@osdl.org> <20061208182500.611327000@osdl.org> <1165809339.7260.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165809339.7260.19.camel@localhost.localdomain>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2006 at 02:55:39PM +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2006-12-08 at 10:22 -0800, Stephen Hemminger wrote:
> > plain text document attachment (mthca-rbc.patch)
> > Use new pci interfaces to set read request tuning values
> > Untested because of lack of hardware.

Sorry...I missed that. I have mthca HW on publicly available IA64 machines.
I'll contact Steve off list to check if he is interested/time.

> I'm worried by this... At no point do you check the host bridge
> capabilities, and thus will happily set the max read req size to some
> value larger than the max the host bridge can cope...
> 
> I've been having exactly that problem on a number of setups, for
> example, the sky2 cards tend to start with a value of 512 while the G5's
> host bridge can't cope with more than 256 (iirc). The firmware fixes
> that up properly on the G5 at least (but not on all machines), but if
> you allow drivers to go tweak the value without a way to go check what
> are the host bridge capabilities, you are toast.
> 
> Of course, on PCI-X, this is moot, there is no clear definition on how
> to get to a host bridge config space (if any)
...
> So for PCI-X, if we want tat, we need a pcibios hook for the platform
> to validate the size requested.

Yes, agreed. 

grant
