Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268044AbTBWQFY>; Sun, 23 Feb 2003 11:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268051AbTBWQFY>; Sun, 23 Feb 2003 11:05:24 -0500
Received: from franka.aracnet.com ([216.99.193.44]:1436 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268044AbTBWQFY>; Sun, 23 Feb 2003 11:05:24 -0500
Date: Sun, 23 Feb 2003 08:14:56 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: lse-tech@lists.sf.et, linux-kernel@vger.kernel.org, haveblue@us.ibm.com,
       dmccr@us.ibm.com
Subject: object-based rmap and pte-highmem
Message-ID: <11090000.1046016895@[10.10.2.4]>
In-Reply-To: <20030222192424.6ba7e859.akpm@digeo.com>
References: <96700000.1045871294@w-hlinder> <20030222192424.6ba7e859.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So whole stole the remaining 1.85 seconds?   Looks like pte_highmem.

I have a plan for that (UKVA) ... we reserve a per-process area with 
kernel type protections (either at the top of user space, changing
permissions appropriately, or inside kernel space, changing per-process
vs global appropriately). 

This area is permanently mapped into each process, so that there's no
kmap_atomic / tlb_flush_one overhead ... it's highmem backed still.
In order to do fork efficiently, we may need space for 2 sets of 
pagetables (12Mb on PAE).

Dave McCracken had an earlier implementation of that, but we never saw
an improvement (quite possibly because the fork double-space wasn't
there) - Dave Hansen is now trying to get something work with current
kernels ... will let you know.

M.


