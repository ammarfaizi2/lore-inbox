Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266539AbUG0SU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266539AbUG0SU2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 14:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266541AbUG0SU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 14:20:28 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:13539 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S266539AbUG0SUU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 14:20:20 -0400
Subject: Re: [RFC][PATCH] Change pcibus_to_cpumask() to pcibus_to_node()
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Andi Kleen <ak@suse.de>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Jesse Barnes <jbarnes@sgi.com>,
       LKML <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       LSE Tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <20040727175713.10a95ad6.ak@suse.de>
References: <1090887007.16676.18.camel@arrakis>
	 <20040727161628.56a03aec.ak@suse.de>
	 <200407270815.39165.jbarnes@engr.sgi.com>
	 <20040727175713.10a95ad6.ak@suse.de>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1090952283.18747.3.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 27 Jul 2004 11:18:04 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-27 at 08:57, Andi Kleen wrote:
> On Tue, 27 Jul 2004 08:15:39 -0700
> Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> 
> > On Tuesday, July 27, 2004 7:16 am, Andi Kleen wrote:
> > > On Mon, 26 Jul 2004 17:10:08 -0700
> > >
> > > Matthew Dobson <colpatch@us.ibm.com> wrote:
> > > > So in discussions with Jesse at OLS, we decided that pcibus_to_node() is
> > > > a more generally useful function than pcibus_to_cpumask().  If anyone
> > > > disagrees with that, now would be a good time to let us know.
> > >
> > > Not sure that is a good idea. Sometimes this information is not available.
> > > With pcibus_to_cpumask() the fallback is obvious, but it isn't with
> > > pcibus_to_node(). Returning a random node is wrong.
> > 
> > Hmm... so there's no way for you to get a node or nodemask at all?
> 
> When the BIOS has _PXM methods there will be probably.
> Just I cannot guarantee it has that, so there should be some clean fallback path.
> 
> If cpumask is too complicated for you a pcibus_to_nodemask would be fine
> for me too, just please no single node number.
> 
> 
> -Andi

I guess I'm OK with a nodemask instead of a node.  That will make this
patch dependent on my nodemask_t patch, which I'll also be sending out
again later today, though...  A nodemask instead of a node also allows
us to return a mask of nearby memory-only nodes as well as CPU-only
nodes, if the arch supports that, for allocating buffers/doing DMA
from...

-Matt

