Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266626AbUAWW1h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 17:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266667AbUAWW1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 17:27:36 -0500
Received: from fujitsu2.FUJITSU.COM ([192.240.0.2]:22454 "EHLO
	fujitsu2.fujitsu.com") by vger.kernel.org with ESMTP
	id S266626AbUAWW1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 17:27:33 -0500
Date: Fri, 23 Jan 2004 14:27:23 -0800
From: Yasunori Goto <ygoto@fsw.fujitsu.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [PATCH] Remove memblks from the kernel
Cc: akpm@us.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>,
       colpatch@us.ibm.com,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
In-Reply-To: <237770000.1074843321@[10.10.2.4]>
References: <237770000.1074843321@[10.10.2.4]>
Message-Id: <20040123114352.C758.YGOTO@fsw.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.07.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello. 

> This patch removes memblks from the kernel ... we don't use them, and
> the NUMA API that was planning to use them when they were originally 
> designed isn't going to use them anymore. They're just unnecessary 
> added complexity now ... time for them to go.
> 
> There's a slight complication in that ia64 uses something with a similar
> name for part of its memory layout, but Jes Sorensen kindly untangled them
> from each other for us. The patch with his modifications is below. Jes 
> tested it on ia64, and I testbuilt it with every config in my arsenal.
> 
> Please apply ... thanks,

I suppose that memblk isn't meaningless from memory hotplug standpoint.
If 1 node includes some memblks, I might be able to make partial
memory offline on the node.

For example, there are a machine which has 2 node like this figure.

   node 0             node 1
   +--------+        +--------+
   |        |        |        |
   |--------|        |--------|
   |        |--------|memblk X|
   |--------|        |--------|
   |        |        |        |
   +--------+        +--------+
  
If memory failure (like 1xECC error) occur on node 1, 
what unit should be removed? 
If only node structure, memory hotplug system has to 
remove whole memory of node 1.
But user sometimes needs much time to prepare new node for exchange.
(Becouse cost is expensive, the system is non-stop-system, etc....)

If there are some memblks in the node like figure,
the system can remove only memblk X.
So, the server can work nearer condition before failure,
and user can keep their software performance till preparing new node.

I don't have any patch of this yet, because memory hotplug need 
much other work.


But....How do you think this idea?

Thanks.

-- 
Yasunori Goto <ygoto at fsw.fujitsu.com>

