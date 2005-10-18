Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbVJRDUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbVJRDUt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 23:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbVJRDUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 23:20:49 -0400
Received: from serv01.siteground.net ([70.85.91.68]:21167 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932401AbVJRDUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 23:20:48 -0400
Date: Mon, 17 Oct 2005 20:20:25 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Muli Ben-Yehuda <mulix@mulix.org>,
       Andi Kleen <ak@suse.de>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, shai@scalex86.org, clameter@engr.sgi.com,
       muli@il.ibm.com, jdmason@us.ibm.com
Subject: Re: [discuss] Re: x86_64: 2.6.14-rc4 swiotlb broken
Message-ID: <20051018032025.GA3692@localhost.localdomain>
References: <20051017184523.GB26239@granada.merseine.nu> <Pine.LNX.4.64.0510171200490.3369@g5.osdl.org> <20051018101604.6795.Y-GOTO@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051018101604.6795.Y-GOTO@jp.fujitsu.com>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2005 at 11:29:18AM +0900, Yasunori Goto wrote:
> Hello. Linus-san.
> ... 
> In our making IA64 machine node 0 might not have any low-memory, and
> another node can have low-memory instead.
> 
> This cause comes from hotplug whole of one node.
> For example, please imagine following case.
> 
> 1) In this case, firmware remembers pxm 1's node has low memory.
> 
>                  node 0             node 1 
>                +--------------+  +-----------+
>                |  pxm = 1     |  | pxm = 2   |
>                |  low memory  |  |           |
>                +--------------+  +-----------+
> 
> 
> 2) If one node is hot-added at pxm = 0 (pxm is decided from physical
>    locate by firmware.), new node will be node 2.
> 
>   node 2          node 0          node 1 
> +-----------+  +--------------+  +-----------+
> | pxm = 0   |  |  pxm = 1     |  | pxm = 2   |
> |           |  |  low memory  |  |           |
> +-----------+  +--------------+  +-----------+
> 
> 3) If user reboots the machine, Linux decides node id from pxm's order.
>    But firmware still remembers which node has low memory.
>    So, node 0 will not have any low memory.
> 
>   node 0          node 1          node 2
> +-----------+  +--------------+  +-----------+
> | pxm = 0   |  |  pxm = 1     |  | pxm = 2   |
> |           |  |  low memory  |  |           |
> +-----------+  +--------------+  +-----------+
> 
> So, just "use NODE(0)" is not enough hack for our machine.
> If "use NODE(0)" is selected, kernel must sort pgdat link and
> node id by memory address. I think that hot add code will be a 
> bit messy instead.

Yasunori-san,
Does this patch work on your boxes instead? (For 2.6.14)
http://marc.theaimsgroup.com/?l=linux-kernel&m=112959469914681&w=2

Thanks,
Kiran
