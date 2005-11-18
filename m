Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161008AbVKRKcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161008AbVKRKcF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 05:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161020AbVKRKcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 05:32:05 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:54405 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161008AbVKRKcE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 05:32:04 -0500
Date: Fri, 18 Nov 2005 15:59:33 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, venkatesh.pallipadi@intel.com,
       len.brown@intel.com, Andrew Morton <akpm@osdl.org>
Subject: Re: maxcpus=1 broken, ACPI bug?
Message-ID: <20051118102933.GA5687@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20051117063103.GB6836@in.ibm.com> <Pine.LNX.4.64.0511171137450.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511171137450.13959@g5.osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 11:54:32AM -0800, Linus Torvalds wrote:
> 
> 
> On Thu, 17 Nov 2005, Maneesh Soni wrote:
> > 
> > Using maxcpus=1 boot option, hangs the system while booting. It was
> > working till 2.6.13-rc2. After git bisect I found that after backing
> > out this ACPI patch it works again, though I had to manually sort the
> > reject while backing out.
> > 
> > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=acf05f4b7f558051ea0028e8e617144123650272
> 
> Hmm. That patch had a totally idiotic thinko in it (look at the for-loop 
> in acpi_processor_get_power_info_default() and notice how it doesn't 
> actually change anything in the loop).
> 
> That thinko was later fixed (albeit in a really stupid way, and the same 
> cut-and-paste bug still exists in acpi_processor_get_power_info_fadt()).
> 
> Anyway, can you test this diff? It
> 
>  (a) removes the insane (and in one case incorrect) memset loop
>  (b) makes the code that sets "pr->flags.power = 1" match the comment and 
>      the previous behaviour.
> 
> Does that make a difference?
> 

Yes, it works now. I just have to remove the declaration of "i" at
both the places to avoid compiler warnings.

Thanks a lot..
Maneesh

-- 
Maneesh Soni
Linux Technology Center, 
IBM India Software Labs,
Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044990
