Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVHAQ5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVHAQ5Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 12:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbVHAQ5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 12:57:22 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:31402 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S261303AbVHAQ5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 12:57:17 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: long delays (possibly infinite) in time_interpolator_get_counter
Date: Mon, 1 Aug 2005 10:57:05 -0600
User-Agent: KMail/1.8.1
Cc: Alex Williamson <alex.williamson@hp.com>, tony.luck@intel.com,
       linux-kernel@vger.kernel.org
References: <200507292206.j6TM6w4k004594@agluck-lia64.sc.intel.com> <1122742054.28719.58.camel@localhost.localdomain> <Pine.LNX.4.62.0507301105120.25104@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0507301105120.25104@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508011057.05802.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 July 2005 12:10 pm, Christoph Lameter wrote:
> On Sat, 30 Jul 2005, Alex Williamson wrote:
> 
> > On Fri, 2005-07-29 at 16:31 -0700, Christoph Lameter wrote:
> > > What you are dealing with is a machine that is using ITC as a time bases. 
> > > That is a special case.
> > 
> >    The default time source for ia64 systems is a "special case"?  4
> > socket and smaller boxes typically do not have any other time source.
> 
> It is a special case because we typically use other time sources.

Maybe you==SGI typically use other time sources, but most other
ia64 boxes have synchronized ITCs.  There's no reason such machines
should have to use the slower and lower precision HPET.

> If it is really synchronized then you can run with "nojitter" without any 
> issue. Then you wont have to deal with the cmpxchg and everything is fine. 
> But I suspect that the ITC are NOT truly synchronized (it has an 
> "offset" that may be nonzero right?) otherwise you would have used nojitter.

And why should everyday users have to be concerned with "nojitter"?

> Extra timer hardware is necessary to fix the ITC deficiency. You are at 
> the source of the problem. Fix the damn hardware to provide a standardized 
> synchronized clock or provide a truly synchronized ITC.

The "ITC deficiency" is a platform design issue.  Most small SMP platforms
*do* synchronize the clocks of all processors.  Obviously that's difficult
on large boxes, and then you may need extra timers in the platform.
