Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbUCCPuM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 10:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbUCCPuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 10:50:12 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:12695 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S262491AbUCCPuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 10:50:08 -0500
Date: Wed, 03 Mar 2004 07:46:32 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org, hugh@veritas.com, wli@holomorphy.com,
       dmccr@us.ibm.com
Subject: Re: 230-objrmap fixes for 2.6.3-mjb2
Message-ID: <7440000.1078328791@[10.10.2.4]>
In-Reply-To: <20040303025820.2cf6078a.akpm@osdl.org>
References: <20040303070933.GB4922@dualathlon.random> <20040303025820.2cf6078a.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Andrew Morton <akpm@osdl.org> wrote (on Wednesday, March 03, 2004 02:58:20 -0800):

> Andrea Arcangeli <andrea@suse.de> wrote:
>> 
>> --- sles-objrmap/mm/rmap.c.~1~	2004-03-03 06:45:38.995594456 +0100
>>  +++ sles-objrmap/mm/rmap.c	2004-03-03 07:01:39.200621104 +0100
>>  @@ -470,7 +470,7 @@ try_to_unmap_obj_one(struct vm_area_stru
>>   	if (!pte)
>>   		goto out;
>>   
>>  -	if (vma->vm_flags & VM_LOCKED) {
>>  +	if (vma->vm_flags & (VM_LOCKED|VM_RESERVED)) {
>>   		ret =  SWAP_FAIL;
>>   		goto out_unmap;
> 
> I keep on wanting to put that in there too.  But pages in a VM_RESERVED vma
> should not find their way onto the LRU.  Maybe we should be checking for
> that in do_no_page().

There was talk at one point of moving the "unswappable" state down into 
the struct page. Is that still realistic? It would seem rather more
efficient, but I forget what problem we ran into with it.

M.

