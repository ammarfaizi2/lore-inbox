Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262838AbTAXWgn>; Fri, 24 Jan 2003 17:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264644AbTAXWfh>; Fri, 24 Jan 2003 17:35:37 -0500
Received: from packet.digeo.com ([12.110.80.53]:60126 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262838AbTAXWf1>;
	Fri, 24 Jan 2003 17:35:27 -0500
Date: Fri, 24 Jan 2003 15:03:40 -0800
From: Andrew Morton <akpm@digeo.com>
To: David Mansfield <david@cobite.com>
Cc: piggin@cyberone.com.au, lkml@dm.cobite.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.59mm5 database 'benchmark' results
Message-Id: <20030124150340.32e57f19.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0301241718440.32240-100000@admin>
References: <3E3188EB.4050807@cyberone.com.au>
	<Pine.LNX.4.44.0301241718440.32240-100000@admin>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Jan 2003 22:44:33.0743 (UTC) FILETIME=[2A393DF0:01C2C3FA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mansfield <david@cobite.com> wrote:
>
> 
> Hi Nick, Andrew, lists,
> 
> I've been testing some recent kernels to see how they compare with a 
> particular database workload.  The workload is actually part of our 
> production process (last months run) but on a test server.  I'll describe 
> the platform and the workload, but first, the results :-)
> 
> kernel           minutes     comment
> -------------    ----------- ---------------------------------
> 2.4.20-aa1       134         i consider this 'baseline'
> 2.5.59           124         woo-hoo
> 2.4.18-19.7.xsmp 128         not bad for frankenstein's montster
> 2.5.59-mm5       157         uh-oh
> 
> Platform:
> HP LH3000 U3.  Dual 866 Mhz Intel Pentium III, 2GB ram.  megaraid 
> controller with two channels, each channel raid 5 PV on 6 15k scsi disks, 
> one megaraid LV per PV.
> 
> Two plain disks w/pairs of partitions in raid 1 for OS (redhat 7.3), a 
> second pair for Oracle redo-log (in a log 'group').
> 
> Oracle version 8.1.7 (no aio support in this release) is accessing
> datafiles on the two megaraid devices via /dev/raw stacked on top of
> device-mapper 

Rather impressed that you got all that to work ;)

It does appear that the IO scheduler change is not playing nicely with
software RAID.

> I'll test any kernel you throw my way.

Thanks.  Could you please try 2.5.59-mm5, with

http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.59/2.5.59-mm5/broken-out/anticipatory_io_scheduling-2_5_59-mm3.patch

reverted?


