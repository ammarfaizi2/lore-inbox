Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751435AbVJREaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbVJREaL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 00:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbVJREaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 00:30:11 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:745 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751435AbVJREaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 00:30:09 -0400
Date: Tue, 18 Oct 2005 13:28:20 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Subject: Re: [discuss] Re: x86_64: 2.6.14-rc4 swiotlb broken
Cc: Linus Torvalds <torvalds@osdl.org>, Muli Ben-Yehuda <mulix@mulix.org>,
       Andi Kleen <ak@suse.de>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, shai@scalex86.org, clameter@engr.sgi.com,
       muli@il.ibm.com, jdmason@us.ibm.com
In-Reply-To: <20051018032025.GA3692@localhost.localdomain>
References: <20051018101604.6795.Y-GOTO@jp.fujitsu.com> <20051018032025.GA3692@localhost.localdomain>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.051
Message-Id: <20051018125342.6799.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > So, just "use NODE(0)" is not enough hack for our machine.
> > If "use NODE(0)" is selected, kernel must sort pgdat link and
> > node id by memory address. I think that hot add code will be a 
> > bit messy instead.
> 
> Yasunori-san,
> Does this patch work on your boxes instead? (For 2.6.14)
> http://marc.theaimsgroup.com/?l=linux-kernel&m=112959469914681&w=2

Not yet. But could you change this line at least?

+	
+	for_each_node(node) {
+		io_tlb_start = alloc_bootmem_node(NODE_DATA(node), iotlbsz);

for_each_node() loop walks around node_possible_map which includes
"offlined" node. 
Please use for_each_online_node() instead. Then, I'll check it. :-)



And I understand why my patch doesn't work on your box by
your patch. (Thanks!)
x86-64's DMA zone is smaller area than 16MB.
But swiotlb requires the area which is smaller than 4GB.
There is no interface to describe its difference.

I think your patch looks reasonable for 2.6.14 to be produced ASAP.
This is less impact than mine. 

However, kernel should have new interface like alloc_bootmmem_low32().
This problem will occur not only by swiotlb.

I'll rewrite my patch to make it. If it is applied at 2.6.15,
I'll be glad.

Thanks.

-- 
Yasunori Goto 

