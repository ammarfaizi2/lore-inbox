Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWC0KAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWC0KAE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 05:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWC0KAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 05:00:04 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:24478 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750821AbWC0KAD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 05:00:03 -0500
Date: Mon, 27 Mar 2006 15:30:19 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       davem@davemloft.net, suparna@in.ibm.com, richardj_moore@uk.ibm.com,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       "Theodore Ts'o" <tytso@mit.edu>, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: RFC - Approaches to user-space probes
Message-ID: <20060327100019.GA30427@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20060327065447.GA25745@in.ibm.com> <1143445068.2886.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143445068.2886.20.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2006 at 09:37:48AM +0200, Arjan van de Ven wrote:
> On Mon, 2006-03-27 at 12:24 +0530, Prasanna S Panchamukhi wrote:
> 
> > - Low overhead and user can have thousands of active probes on the
> >   system and detect any instance when the probe was hit including
> >   probes on shared library etc.
> 
> I suspect this is the only reason for doing it inside the kernel;
> anything else still really shouts "do it in userspace via ptrace" to me.
> 

Other reasons would be:

- to view some privilaged data, such as system regs while you are
  debugging in user-space
- to view many arbitrary process address-space that use a common set
  of modules - user or kernel space

> 
> > ===========================================================
> > LOCAL PROBES(PER PROCESS) VS GLOBAL PROBES(EXECUTABLE FILE)
> > ===========================================================
> > 
> > - All processes take a trap since the same executable file
> >   gets mapped into different address_space.
> 
> is that true for breakpoints inserted after start?

Yes, insertion of the breakpoint happens at the physical
page level and it gets written back to the disc.

> The reason I ask because... what if half the processed took a COW on the
> page with the instruction you want to trap on. Are you going to edit all
> those COW'd pages?

The current prototype does not insert probes on COW pages, but yes eventually
we will provide probes insertions on COW'd pages feature too.

Thanks
Prasanna
-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-51776329
