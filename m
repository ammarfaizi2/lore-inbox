Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266261AbUBDG3q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 01:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266262AbUBDG3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 01:29:46 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:34741 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S266261AbUBDG3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 01:29:42 -0500
Date: Tue, 03 Feb 2004 22:29:33 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Dave Hansen <haveblue@us.ibm.com>
cc: Alok Mooley <rangdi@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
Subject: Re: Active Memory Defragmentation: Our implementation & problems
Message-ID: <38540000.1075876171@[10.10.2.4]>
In-Reply-To: <1075875756.14153.251.camel@nighthawk>
References: <20040204050915.59866.qmail@web9704.mail.yahoo.com> <1075874074.14153.159.camel@nighthawk>  <35380000.1075874735@[10.10.2.4]> <1075875756.14153.251.camel@nighthawk>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Dave Hansen <haveblue@us.ibm.com> wrote (on Tuesday, February 03, 2004 22:22:36 -0800):

> On Tue, 2004-02-03 at 22:05, Martin J. Bligh wrote:
>> >> In order to move such pages, we will have to patch macros like
>> >> "virt_to_phys" & other related macros, so that the address 
>> >> translation for pages moved by us will take place vmalloc style, i.e.,
>> >> via page tables, instead of direct +-3GB. Is it worth introducing such
>> >> an overhead for address translation (vmalloc does it!)? If no, then is
>> >> there another way out, or is it better to stick to our current
>> >> definition of a movable page? 
>> > 
>> > Low memory kernel pages are a much bigger deal to defrag.  I've started
>> > to think about these for hotplug memory and it just makes my head hurt. 
>> > If you want to do this, you are right, you'll have to alter virt_to_phys
>> > and company.  The best way I've seen this is with CONFIG_NONLINEAR:
>> > http://lwn.net/2002/0411/a/discontig.php3
>> > Those lookup tables are pretty fast, and have benefits to many areas
>> > beyond defragmentation like NUMA and the memory hotplug projects.  
>> 
>> I don't think that helps you really - the mappings are usually done on
>> chunks signficantly larger than one page, and we don't want to break
>> away from using large pages for the kernel mappings.
> 
> Yeah, you're right about that one.  The defrag thing needs to deal with
> much smaller sections than nonlinear does.  That pretty much leaves
> being careful where you allocate.

There are a couple of special cases that might be feasible without making
an ungodly mess. PTE pages spring to mind (particularly as they can be
in highmem too). They should be reasonably easy to move (assuming we can
use rmap to track them back to the process they belong to to lock them ...
hmmm ....)

M.

