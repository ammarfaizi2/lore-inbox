Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135206AbRDLPmb>; Thu, 12 Apr 2001 11:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135193AbRDLPmM>; Thu, 12 Apr 2001 11:42:12 -0400
Received: from [32.97.182.101] ([32.97.182.101]:18566 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S135181AbRDLPlu>;
	Thu, 12 Apr 2001 11:41:50 -0400
Date: Thu, 12 Apr 2001 21:13:54 +0530
From: Maneesh Soni <smaneesh@in.ibm.com>
To: Anton Blanchard <anton@samba.org>
Cc: tridge@samba.org, lkml <linux-kernel@vger.kernel.org>,
        lse tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [RFC][PATCH] Scalable FD Management using Read-Copy-Update
Message-ID: <20010412211354.A25905@in.ibm.com>
Reply-To: smaneesh@in.ibm.com
In-Reply-To: <20010409201311.D9013@in.ibm.com> <20010411182929.A16665@va.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010411182929.A16665@va.samba.org>; from anton@samba.org on Wed, Apr 11, 2001 at 06:29:30PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2001 at 06:29:30PM -0700, Anton Blanchard wrote:
> 
> > This patch provides a very good performance improvement in file 
> > descriptor management for SMP linux kernel on a 4-way machine with the 
> > expectation of even higher gains on higher end machines. The patch uses the 
> > read-copy-update mechanism for Linux, published earlier at the sourceforge
> > site under Linux Scalablity Effort project.
> >        http://lse.sourceforge.net/locking/rclock.html.
> 
> Good stuff!
> 
> It would be interesting to try a filesystem benchmark such as dbench. On
> a quad PPC fget was chewing up more than its fair share of cpu time.
> 
> Anton

Hello Anton,

Thank you for your suggestion. I tried dbench for on a 4-way PIII Xeon box, with
1MB L2 Cache and 1GB of RAM. I ran it on 8 GB ext2 partition with Adaptec 7896 
SCSI controller. I ran "dbench 100" and "dbench 200" for five times and took the
average of the throughput and found that for 

Base (2.4.2) - 
        100 Average Throughput = 39.628  MB/sec
        200 Average Throughput = 22.792  MB/sec

Base + files_struct patch - 
        100 Average Throughput = 39.874 MB/sec
        200 Average Throughput = 23.174 MB/sec  
         
I found this value quite less than the one present in the README distributed
with dbench tarball. I think the numbers in the README were for a similar 
machine but with 2.2.9 kernel.

As you can see the performance with files_struct patch is almost same as base. 
I feel I am hitting some bottleneck other than fget() in both base and the 
patched versions. I think atleast for base version I should get similar numbers
as mentions in the README for similar configuration. Though I intend to do some 
profiling to look into this but it will be helpfull if you can tell me if there 
is some known thing regarding this.

I am copying this to Andrew also, if he can also help. Also if you have some
dbench numbers from 2.4.x kernel, please let me have a look into those also.

Thank you,
Maneesh


-- 
Maneesh Soni <smaneesh@in.ibm.com>
IBM Linux Technology Center,
IBM Software Lab, Bangalore, India
