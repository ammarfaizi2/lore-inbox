Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262723AbVF3AaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262723AbVF3AaK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 20:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbVF3AaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 20:30:09 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:25506 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262723AbVF3A3k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 20:29:40 -0400
Date: Wed, 29 Jun 2005 19:29:36 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, long <tlnguyen@snoqualmie.dp.intel.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Greg KH <greg@kroah.com>, ak@muc.de, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@us.ibm.com
Subject: Re: [PATCH 8/13]: PCI Err: Event delivery utility
Message-ID: <20050630002936.GS28499@austin.ibm.com>
References: <20050628235932.GA6429@austin.ibm.com> <1120010387.5133.235.camel@gaston> <20050629211435.GN28499@austin.ibm.com> <1120088522.31924.25.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120088522.31924.25.camel@gaston>
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 09:42:01AM +1000, Benjamin Herrenschmidt was heard to remark:
> On Wed, 2005-06-29 at 16:14 -0500, Linas Vepstas wrote:
> 
> > I'm pretty sure this was balanced, there is a get very early on when the
> > error is detected.  But I'll review.
> > 
> > > I'd keep that in arch code for now.
> > 
> > OK, I'm moving it there. It did seem both confusing and semi-pointless
> > after the last round of changes.
> 
> Well, it's logical for the get and put to be in the same "layer" don't
> you think ?

Yes, it could be made more symmetrical; I'll do that.

The get happened along with the malloc of the event structure, the put
happens right before the free of the same structure.  

The reason for the event was in order to get the recovery of the error
out of line from the detection of the error; detection may occur in an
interrupt context; recovery happens in a work queue.  Thus, get may
happen in that interrupt context, the put only after the work is
complete.

I'll make the code more symmetrical with regards to the event malloc/free
and that should make it more readable.

--linas

