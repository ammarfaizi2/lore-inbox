Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262565AbVAETXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262565AbVAETXj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 14:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbVAETXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 14:23:38 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:33761 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262565AbVAETVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 14:21:47 -0500
Message-ID: <41DC3E96.4020807@sgi.com>
Date: Wed, 05 Jan 2005 13:23:02 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve Longerbeam <stevel@mvista.com>
CC: Andi Kleen <ak@muc.de>, Hirokazu Takahashi <taka@valinux.co.jp>,
       Dave Hansen <haveblue@us.ibm.com>,
       Marcello Tosatti <marcelo.tosatti@cyclades.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, andrew morton <akpm@osdl.org>
Subject: Re: page migration patchset
References: <41DB35B8.1090803@sgi.com> <m1wtusd3y0.fsf@muc.de> <41DB5CE9.6090505@sgi.com> <41DC34EF.7010507@mvista.com>
In-Reply-To: <41DC34EF.7010507@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve!

Steve Longerbeam wrote:

> 
> well, I need to study the page migration patch more (this is the
> first time I've heard of it). But it sounds as if my patch and the
> page migration patch are complementary.
> 

Did you get the url from the last email?

http://sr71.net/patches/2.6.10/2.6.10-mm1-mhp-test7/page_migration/

>>
>> On the other hand, there is some work to be done wrt memory policies
>> and page migration.  For the project I am working on, we need to be able
>> to move all of the pages used by a process on one set of nodes to another
>> set of nodes.  At some point during this process we will need to update
>> the memory policy for that process.  For Steve's patch, we will
>> similarly need to update the policy associated with files associated with
>> the process, I would think, elsewise new pages will get allocated on the
>> old set of nodes, which is something we don't want.  Sounds like some
>> new interfaces will have to be developed here.  Does that make sense
>> to you, Andi and Steve?
> 
> yes.
> 
>>
>> My personal preference would be to keep as much of this as possible
>> under user space control; that is, rather than having a big autonomous
>> system call that migrates pages and then updates policy information,
>> I'd prefer to split the work into several smaller system calls that
>> are issued by a user space program responsible for coordinating the
>> process migration as a series of steps, e. g.:
>>
>> (1)  suspend the process via SIGSTOP
>> (2)  update the mempolicy information
>> (3)  migrate the process's pages
>> (4)  migrate the process to the new cpu via set_schedaffinity()
>> (5)  resume the process via SIGCONT
>>
> 
> steps 2 and 3 can be accomplished by a call to mbind() and
> specifying MPOL_MF_MOVE. And since mbind() takes an
> address range, you could probably migrate pages and change
> the policies for all of the process' mappings in a single mbind()
> call.
> 

Interesting, I hadn't tbought of that.  I'll look at that.

> Note that Andrew had to drop my patch from 2.6.10, because
> the 4-level page tables feature was re-implemented using a
> different interface, which broke my patch. So Andrew asked me
> to re-do the patch for inclusion in 2.6.11. That gives us ~2 months
> to work on integrating the page migration and NUMA mempolicy
> filemap patches.

Sounds like a plan.

> 
> Ray, btw it is beneficial that I can work with you on this, because I have
> no access to true NUMA machines. My testing of the filemap mempolicy
> patch has only been on a UP discontiguous memory system. I assume
> you've got access to Altix machines at SGI to do testing and benchmarking
> of my filemap patch and your migration patches.
> 
> Steve
> 
> 

Oh yeah, I have access to a >>few<< Altix systems.  :-)

I'd be happy to test your patches on Altix.  I have another project sitting
on the back burner to get page cache allocated (by default) in round-robin
memory for Altix; I need to see how to integrate this with your work (which
is how this was all left a few months back when I got pulled off to work on
the latest release for Altix.)  So that is another area for collaboration.

Is the latest version of your patch the one from lkml dated 11/02/2004?


-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------
