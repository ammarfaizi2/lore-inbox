Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266476AbUGPFkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266476AbUGPFkY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 01:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266477AbUGPFkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 01:40:24 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:50360 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266476AbUGPFkU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 01:40:20 -0400
Date: Thu, 15 Jul 2004 22:40:05 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>, Nick Piggin <nickpiggin@yahoo.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>, John Hawkes <hawkes@sgi.com>
Subject: Re: [PATCH] reduce inter-node balancing frequency
Message-ID: <2700000.1089956404@[10.10.2.4]>
In-Reply-To: <200407152158.17605.jbarnes@engr.sgi.com>
References: <200407151829.20069.jbarnes@engr.sgi.com> <200407152038.32755.jbarnes@engr.sgi.com> <40F733D2.2000309@yahoo.com.au> <200407152158.17605.jbarnes@engr.sgi.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Jesse Barnes <jbarnes@engr.sgi.com> wrote (on Thursday, July 15, 2004 21:58:17 -0400):

> On Thursday, July 15, 2004 9:48 pm, Nick Piggin wrote:
>> Yeah, these numbers actually used to be a lot higher, but someone
>> at Intel (I forget who it was right now) found them to be too high
>> on even a 32 way SMT system. They could probably be raised a *little*
>> bit in the generic code.
> 
> Ok, but I wouldn't want to hurt the performance of small machines at all.  If 
> possible, I'd rather just add another level to the hierarchy if MAX_NUMNODES 
>> some value.

Arch code. Arch code. Arch code ;-) Or at least base it of nr_cpus or 
numnodes. Seriously ... a 2x or 4x opteron obviously needs different
parameters from a 16x x440 or a 512x SGI box ... why we have a flexible
infrastructure that can stand on its head and do backflips, and then
we don't use it at all is a mystery to me ;-)

I'd even go so far as to suggest there should be NO default settings for
NUMA, only in arch code - that'd make people actually think about it.
If there are, they should be based off the topo infrastructure, not static
values.
 
>> > We may have enough information to do that already... I'll look.
>> 
>> The plan is to allow arch overridable SD_CPU/NODE_INIT macros for
>> those architectures that just look like a regular SMT+SMP+NUMA, and
>> have the generic code set them up.
> 
> Would simply creating a 'supernode' scheduling domain work with the existing 
> scheduler?  My thought was that in the ia64 code we'd create them for every N 
> regular nodes; its children would be the regular nodes with the existing 
> defaults.

Nick would know better than I, but I think so ... it seems to cope with
arbitrary levels, groupings, ... gravitational dimensions, etc ;-)

M.

