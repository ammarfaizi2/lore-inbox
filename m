Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbVC3B4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVC3B4y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 20:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVC3B4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 20:56:54 -0500
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:62805 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261418AbVC3B4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 20:56:47 -0500
Message-ID: <424A075E.6080100@yahoo.com.au>
Date: Wed, 30 Mar 2005 11:56:46 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: Linus Torvalds <torvalds@osdl.org>, "'Andrew Morton'" <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Industry db benchmark result on recent 2.6 kernels
References: <200503300138.j2U1cJg03717@unix-os.sc.intel.com>
In-Reply-To: <200503300138.j2U1cJg03717@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote:
> Nick Piggin wrote on Tuesday, March 29, 2005 5:32 PM
> 
>>If it is doing a lot of mapping/unmapping (or fork/exit), then that
>>might explain why 2.6.11 is worse.
>>
>>Fortunately there are more patches to improve this on the way.
> 
> 
> Once benchmark reaches steady state, there is no mapping/unmapping
> going on.  Actually, the virtual address space for all the processes
> are so stable at steady state that we don't even see it grow or shrink.
> 

Oh, well there goes that theory ;)

The only other thing I can think of is the CPU scheduler changes
that went into 2.6.11 (but there are obviously a lot that I can't
think of).

I'm sure I don't need to tell you it would be nice to track down
the source of these problems rather than papering over them with
improvements to the block layer... any indication of what has gone
wrong?

Typically if the CPU scheduler has gone bad and is moving too many
tasks around (and hurting caches), you'll see things like copy_*_user
increase in cost for the same units of work performed. Wheras if it
is too reluctant to move tasks, you'll see increased idle time.


