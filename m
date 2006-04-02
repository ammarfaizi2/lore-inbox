Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWDBIz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWDBIz3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 04:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbWDBIz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 04:55:29 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:43390 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932283AbWDBIz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 04:55:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=O9bOPoo0s+Xjt6qPKTF6WZP5ug/X9PfDNXNNgrWsHpdFXkyqKSkkAWvaXdQKwd8nOKSYboDNOxUBdzCUSvtkyIrS9swQHn+/2uhqrxBSW814p/xab0IIeQFXewEKjt4VVlkQFPXwY6QQnjDAcaaUkMiHXpxd0i/YNXi7SoaOQbo=  ;
Message-ID: <442F5F51.3030104@yahoo.com.au>
Date: Sun, 02 Apr 2006 15:21:21 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       suresh.b.siddha@intel.com, Dinakar Guniguntala <dino@in.ibm.com>,
       pj@sgi.com, hawkes@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16-mm2 4/4] sched_domain: Allocate sched_group structures
 dynamically
References: <20060401185644.GC25971@in.ibm.com> <442F2B52.6000205@yahoo.com.au> <20060402050400.GA13423@in.ibm.com>
In-Reply-To: <20060402050400.GA13423@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> On Sun, Apr 02, 2006 at 11:39:30AM +1000, Nick Piggin wrote:
> 
>>Srivatsa Vaddagiri wrote:
>>
>>>+		if (!sched_group_phys) {
>>>+			sched_group_phys
>>>+				= kmalloc(sizeof(struct sched_group) * 
>>>NR_CPUS,
>>>+					  GFP_KERNEL);
>>>+			if (!sched_group_phys) {
>>>+				printk (KERN_WARNING "Can not alloc phys 
>>>sched"
>>>+						     "group\n");
>>>+				goto error;
>>>+			}
>>>+			sched_group_phys_bycpu[i] = sched_group_phys;
>>>+		}
>>
>>Doesn't the last assignment have to be outside the if statement?
> 
> 
> I dont think so. The assignment can happen once (when we allocate
> successfully) and not every time in the for loop?
> 

Then after you have allocated sched_group_phys, subsequent cpus
in cpu_map will have their sched_group_phys_bycpu[] entry
uninitialised, by the looks?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
