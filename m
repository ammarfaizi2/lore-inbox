Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267490AbUIAXD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267490AbUIAXD4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 19:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268065AbUIAXB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 19:01:28 -0400
Received: from fire.osdl.org ([65.172.181.4]:63901 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S267599AbUIAVCV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 17:02:21 -0400
Subject: Re: [Linux-cluster] New virtual synchrony API for the kernel: was
	Re: [Openais] New API in openais
From: John Cherry <cherry@osdl.org>
To: Daniel Phillips <phillips@redhat.com>
Cc: linux-cluster@redhat.com, Steven Dake <sdake@mvista.com>,
       openais@lists.osdl.org,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       linux-ha-dev@new.community.tummy.com
In-Reply-To: <200409011115.45780.phillips@redhat.com>
References: <1093941076.3613.14.camel@persist.az.mvista.com>
	 <1093973757.5933.56.camel@cherrybomb.pdx.osdl.net>
	 <1093981842.3613.42.camel@persist.az.mvista.com>
	 <200409011115.45780.phillips@redhat.com>
Content-Type: text/plain
Message-Id: <1094072235.10369.102.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 01 Sep 2004 13:57:15 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel, 

Steve is out having a baby (or at least his wife)...so I'll take a crack
at some of your questions.


On Wed, 2004-09-01 at 08:15, Daniel Phillips wrote:
> Hi Steven,
> 
> (here's the rest of that message)
> 
> On Tuesday 31 August 2004 15:50, Steven Dake wrote:
> > It would be useful for linux cluster developers for a common low
> > level group communication API to be agreed upon by relevant clusters
> > projects.  Without this approach, we may end up with several systems
> > all using different cluster communication & membership mechanisms
> > that are incompatible.
> 

Agreed.  The low level cluster communication mechanisms mentioned at the
cluster summit included the communication layer used by CMAN, TIPC, and
SSI/CI internode communication.  The openais project has a GMI which is
a virtual synchrony based communication mechanism.  Because of it's
potential usefulness for applications, Steve is proposing an EVS-style
API which would support agreed/safe ordering.

What we should avoid is 4 different cluster communication mechanisms!


> To be honest, this does look interesting, however could you help me on a 
> few points:
> 
>   - Is there any evil IP we have to worry about with this?

I will let Steve answer definitively on the evil IP question, but the
answer is that there are no IP issues with the OpenAIS project or the
EVS API proposal.  OpenAIS is being developed with a BSD-style license.

> 
>   - Can I get a formal interface spec from AIS for this, without
>     signing a license?

The EVS proposal is not an SAForum AIS interface.  The SAForum may want
to adopt it at some point, but SAF-AIS focuses on a group messaging
service which could be built on top of a low level cluster communication
mechanism.

BTW, anyone can download a copy of the SA Forum specifications.  No
formal license signing is required.

> 
>   - Have you got benchmarks available for control and normal messaging?

There are some test programs, but I'll let Steve answer this one.

> 
>   - Have you looked at the barrier subsystem in sources.redhat.com/dlm?
>     Could this be used as a primitive in implementing Virtual Synchrony?

I'll let Steve answer this one as well.  

> 
>   - Why would we need to worry about the AIS spec, in-kernel?  What
>     would stop you from providing an interface that presented some
>     kernel functionality to userspace, with the interface of your
>     choice, presumably AIS?

Again, the EVS proposal is not an AIS interface.

However, there is a membership API and a lock manager API specified in
the SA Forum AIS.  In order to present a consistent API to user space
and to allow for a modular AIS service design, it would be good for the
kernel services (membership and DLM) to present standard interfaces
(such as SAF-AIS).  This could be done as a "layer" to the existing
kernel services.

> 
>   - Why isn't Virtual Synchrony overkill, since we don't attempt to
>     deal with netsplits by allowing subclusters to continue to operate?

Virtual synchrony is the communication layer.  The membership service
(in your case, CMAN) determines active partitions and deals with
netsplits, etc.  In openais however, membership and virtual synchrony
communication is pretty intertwined.  <Steve?>

> 
>   - In what way would GFS benefit from using Virtual Synchrony in place
>     of its current messaging algorithms?

What messaging algorithms are being used for GFS?  I assumed that the
DLM would be used for lock traffic and the barrier subsystem would be
used for recovery.

Regards,
John


