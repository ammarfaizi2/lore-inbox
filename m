Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262649AbVF2VRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbVF2VRl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 17:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbVF2VR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 17:17:29 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:14770 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262649AbVF2VOi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 17:14:38 -0400
Date: Wed, 29 Jun 2005 16:14:35 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, long <tlnguyen@snoqualmie.dp.intel.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Greg KH <greg@kroah.com>, ak@muc.de, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@us.ibm.com
Subject: Re: [PATCH 8/13]: PCI Err: Event delivery utility
Message-ID: <20050629211435.GN28499@austin.ibm.com>
References: <20050628235932.GA6429@austin.ibm.com> <1120010387.5133.235.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120010387.5133.235.camel@gaston>
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 11:59:47AM +1000, Benjamin Herrenschmidt was heard to remark:
> On Tue, 2005-06-28 at 18:59 -0500, Linas Vepstas wrote:
> > pci-err-8-pci-err-event.patch
> > 
> > [RFC]
> > 
> > PCI Error distribution utility routine.  This patch defines 
> > a utility routine that hasn't yet been discussed much on 
> 
> Certainly needs to be in a separate .h at least ... Also, you have some
> lifetime issues. You probably want to do a get() on pci_dev when you put
> it in your struct and put() it after the notifier... Oh wait, you are
> doing pci_dev_put() ... but no pci_dev_get() ... The later must be
> missing from peh_send_failure_event().

I'm pretty sure this was balanced, there is a get very early on when the
error is detected.  But I'll review.

> I'd keep that in arch code for now.

OK, I'm moving it there. It did seem both confusing and semi-pointless
after the last round of changes.

--linas

