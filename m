Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263652AbTETJB4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 05:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263654AbTETJB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 05:01:56 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:33593 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263652AbTETJBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 05:01:54 -0400
Date: Tue, 20 May 2003 02:17:12 -0700
From: Andrew Morton <akpm@digeo.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: haveblue@us.ibm.com, wli@holomorphy.com, davem@redhat.com,
       arjanv@redhat.com, pbadari@us.ibm.com, linux-kernel@vger.kernel.org,
       gh@us.ibm.com, johnstul@us.ibm.com, jamesclv@us.ibm.com,
       mannthey@us.ibm.com
Subject: Re: userspace irq balancer
Message-Id: <20030520021712.1a548e2d.akpm@digeo.com>
In-Reply-To: <20030520090017.D17268@devserv.devel.redhat.com>
References: <200305191314.06216.pbadari@us.ibm.com>
	<1053382055.5959.346.camel@nighthawk>
	<20030519221111.P7061@devserv.devel.redhat.com>
	<1053382943.4827.358.camel@nighthawk>
	<1053401130.6830.3.camel@rth.ninka.net>
	<20030520034622.GK8978@holomorphy.com>
	<1053407030.13207.253.camel@nighthawk>
	<20030520090017.D17268@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 May 2003 09:14:48.0497 (UTC) FILETIME=[43140A10:01C31EB0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com> wrote:
>
> On Mon, May 19, 2003 at 10:03:50PM -0700, Dave Hansen wrote:
> > Does anyone have a patch to tear it out already?  Is the current proc
> > interface acceptable, or do we want a syscall interface like wli
> > suggests?
> 
> I have no problems with the proc interface; it's ascii so reasonably
> extendible in the future for, say, when 64 cpus on
> 32 bit linux get supported. It's also not THAT inefficient since my code
> only uses it when some binding changes, not all the time.

Concerns have been expressed that the /proc interface may be a bit racy. 
One thing we do need to do is to write a /proc stresstest tool which pokes
numbers into the /proc files at high rates, run that under traffic for a
few hours.

There is no need to pull out the existing balancer until the userspace
solution is proven - it can be turned off with `noirqbalance' until that
work has been performed.

Nobody has tried improving the current balancer.  From a quick look it
appears that it could work reasonably for the problematic packet-forwarding
workload if the when-to-start-balancing threshold is reduced from 1000/sec
to (say) 10/sec.  Don't know - I've never seen a description of how the
algorithm should be improved.



