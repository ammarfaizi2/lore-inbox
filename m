Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262628AbSJBVx1>; Wed, 2 Oct 2002 17:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262638AbSJBVx1>; Wed, 2 Oct 2002 17:53:27 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:18416 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S262628AbSJBVxZ>; Wed, 2 Oct 2002 17:53:25 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 2 Oct 2002 15:56:49 -0600
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH]  4KB stack + irq stack for x86
Message-ID: <20021002215649.GY3000@clusterfs.com>
Mail-Followup-To: Dave Hansen <haveblue@us.ibm.com>,
	linux-kernel@vger.kernel.org,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>, linux-mm@kvack.org
References: <3D9B62AC.30607@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D9B62AC.30607@us.ibm.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 02, 2002  14:18 -0700, Dave Hansen wrote:
> I've resynced Ben's patch against 2.5.40.  However, I'm getting some 
> strange failures.  The patch is good enough to pass LTP, but 
> consistently freezes when I run tcpdump on it.
> 
> Although I don't have CONFIG_PREEMPT on, I have the feeling that I 
> need to disable preemption in common_interrupt() like it was before. 
>   Any insights would be appreciated.

I'm a little bit worried about this patch.  Have you tried something
like NFS-over-ext3-over-LVM-over-MD or so, which can have a deep stack?

We hit a bunch of deep stack problems like this (overflowing an 8kB stack)
even without interrupts involved when developing Lustre.  Granted, we
fixed some large stack allocations in the ext3 indexed-directory code
and in our own code, but I'm still worried that a 4kB stack is too small.

The Stanford checker folks would probably be able to run a test for
large stack allocations in 2.5.40 if you asked them nicely, and maybe
even do stack depths for call chains.

Alternately, you could set up an 8kB stack + IRQ stack and "red-zone"
the high page of the current 8kB stack and see if it is ever used.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

