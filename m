Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbTIDUhF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 16:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbTIDUhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 16:37:05 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:45534 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262086AbTIDUhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 16:37:00 -0400
Date: Thu, 4 Sep 2003 16:36:56 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scaling noise
In-Reply-To: <25950000.1062601832@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0309041634250.14715-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003, Martin J. Bligh wrote:

> The real core use of NUMA is to run one really big app on one machine,
> where it's hard to split it across a cluster. You just can't build an
> SMP box big enough for some of these things.

That only works when the NUMA factor is low enough that
you can effectively treat the box as an SMP system.

It doesn't work when you have a NUMA factor of 15 (like
some unspecified box you are very familiar with) and
half of your database index is always on the "other half"
of the two-node NUMA system.

You'll end up with half your accesses being 15 times as
slow, meaning that your average memory access time is 8
times as high!  Good way to REDUCE performance, but most
people won't like that...

If the NUMA factor is low enough that applications can
treat it like SMP, then the kernel NUMA support won't
have to be very high either...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

