Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266780AbUBGEt4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 23:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266783AbUBGEt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 23:49:56 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:20661 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S266780AbUBGEty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 23:49:54 -0500
Date: Fri, 06 Feb 2004 20:49:40 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andi Kleen <ak@suse.de>, Nick Piggin <piggin@cyberone.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [Bugme-new] [Bug 2019] New: Bug from the mm subsystem involving X  (fwd)
Message-ID: <14230000.1076129379@[10.10.2.4]>
In-Reply-To: <p738yjflf38.fsf@verdi.suse.de>
References: <51080000.1075936626@flay.suse.lists.linux.kernel><Pine.LNX.4.58.0402041539470.2086@home.osdl.org.suse.lists.linux.kernel><60330000.1075939958@flay.suse.lists.linux.kernel><64260000.1075941399@flay.suse.lists.linux.kernel><Pine.LNX.4.58.0402041639420.2086@home.osdl.org.suse.lists.linux.kernel><20040204165620.3d608798.akpm@osdl.org.suse.lists.linux.kernel><Pine.LNX.4.58.0402041719300.2086@home.osdl.org.suse.lists.linux.kernel><1075946211.13163.18962.camel@dyn318004bld.beaverton.ibm.com.suse.lists.linux.kernel><Pine.LNX.4.58.0402041800320.2086@home.osdl.org.suse.lists.linux.kernel><98220000.1076051821@[10.10.2.4].suse.lists.linux.kernel><1076061476.27855.1144.camel@nighthawk.suse.lists.linux.kernel>
 <5450000.1076082574@[10.10.2.4].suse.lists.linux.kernel><1076088169.29478.2928.camel@nighthawk.suse.lists.linux.kernel><218650000.1076097590@flay.suse.lists.linux.kernel><Pine.LNX.4.58.0402061215030.30672@home.osdl.org.suse.lists.linux.kernel><220850000.1076102320@flay.suse.lists.linux.kernel> <p738yjflf38.fsf@verdi.suse.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Andi Kleen <ak@suse.de> wrote (on Saturday, February 07, 2004 04:54:03 +0100):

> "Martin J. Bligh" <mbligh@aracnet.com> writes:
>  
>> If we really want to do good testing, we should make a fake NUMA config
>> that can run a 4x SMP box as fake NUMA, with half the memory in each
>> "node" and half the processors ... but I never got around to coding that ;-)
> 
> I have such a patch for x86-64 if anybody is interested in that.
> 
> x86-64 low level NUMA is quite different from IA32 NUMA though so it 
> would be a bit difficult to port.

Not quite sure what you mean ... I was driving at pretending an SMP box
was NUMA ... but the x86_64 is already NUMA ... are you grouping nodes
together into single nodes with 2 cpus each?

What might be intriguing is to use Nick's domains stuff to create a heirarchy
for the scheduler where we have 1 cpu nodes and 2 cpu nodes above that, but
still keep the normal NUMA stuff flat for mem allocation. What might be 
interesting is a heirarchy where if this is the HT connections of cpu layouts:

1 --- 2
|     |
|     | 
|     |
3 --- 4

then domains of (1,2,3) (2,3,4) (1,3,4) (1 2 4), with a view to restricting
the "double hop" traffic as much as possible. But I'm not sure the domains
code copes with multiple overlapping domains - Nick?

Andi, do you already set up the mem allocation fallback zonelists like that?

M.

