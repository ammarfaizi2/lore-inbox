Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317923AbSGQK2a>; Wed, 17 Jul 2002 06:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318196AbSGQK23>; Wed, 17 Jul 2002 06:28:29 -0400
Received: from cmailg7.svr.pol.co.uk ([195.92.195.177]:22139 "EHLO
	cmailg7.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S317923AbSGQK23>; Wed, 17 Jul 2002 06:28:29 -0400
Date: Wed, 17 Jul 2002 11:31:12 +0100
To: linux-lvm@sistina.com
Cc: Andrew Theurer <habanero@us.ibm.com>, Kevin Corry <corryk@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-lvm] Re: [Announce] device-mapper beta3 (fast snapshots)
Message-ID: <20020717103112.GA595@fib011235813.fsnet.co.uk>
References: <3D2F6464.60908@us.ibm.com> <02071513565400.06209@boiler> <20020716084234.GA431@fib011235813.fsnet.co.uk> <200207161105.49328.habanero@us.ibm.com> <20020716163157.GA11334@fib011235813.fsnet.co.uk> <1026840444.21656.544.camel@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1026840444.21656.544.camel@tiny>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2002 at 01:27:24PM -0400, Chris Mason wrote:
> Some IDE drives ignore commands to turn off the write back cache, or
> turn it back on when load gets high.

I'm amazed hardware manufacturers would dare to do such a thing - I
guess I'm naive.

> Try iozone -s 50M -i 0 -o with writeback on and off.  If you get the
> same answer the benchmarks are suspect....

I tried this and found that /proc/ide/hda/settings was lying in that
it always reports write caching as disabled.  Once disabled with
hdparm the disks didn't re-enable write caching on their own.

These are new test results run on a pair of 5k rpm disks with write
caching disabled (average of three runs):


Non Persistent snapshots
------------------------

		Run 1 .. 3			Average		

baseline	15.349	14.835	14.724		14.979
8k		19.43	21.629	19.951		20.337
16k		19.373	21.579	20.373		20.442
32k		22.158	19.505	21.472		21.045
64k		19.745	19.273	20.191		19.736
128k		19.588	20.86	20.166		20.205
256k		19.67	19.819	21.216		20.235
512k		20.439	22.621	20.753		21.271


Persistent snapshots
--------------------

		Run 1 .. 3			Average		

baseline	15.342	14.81	14.514		14.889
8k		25.24	26.985	27.092		26.439
16k		24.869	23.943	24.687		24.500
32k		27.084	25.861	24.728		25.891
64k		23.646	23.051	24.786		23.828
128k		23.761	24.596	25.53		24.629
256k		25.472	26.962	27.225		26.553
512k		29.076	27.183	27.795		28.018



As you can see the persistent snapshots are taking a significant
performance hit compared to the non-persistent ones due to the
overhead of ensuring all the data on the disk is consistent.

I would expect the EVMS async snapshots to perform similarly to
device-mappers non-persistent snapshots since they are not ensuring
any form of consistency.  Effectively they are not writing any
exception metadata to the disk until a controlled shutdown occurs.

- Joe
