Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262782AbVBYW0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262782AbVBYW0m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 17:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262783AbVBYW0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 17:26:42 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:9382 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262782AbVBYW0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 17:26:38 -0500
Message-ID: <421FA61B.9050705@us.ibm.com>
Date: Fri, 25 Feb 2005 14:26:35 -0800
From: Darren Hart <dvhltc@us.ibm.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: hugh@veritas.com, akpm@osdl.org, andrea@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] allow vma merging with mlock et. al.
References: <421E74B5.3040701@us.ibm.com> <20050225171122.GE28536@shell0.pdx.osdl.net> <20050225220543.GC15867@shell0.pdx.osdl.net>
In-Reply-To: <20050225220543.GC15867@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Chris Wright (chrisw@osdl.org) wrote:
> 
>>* Darren Hart (dvhltc@us.ibm.com) wrote:
>>
>>>The were a couple long standing (since at least 2.4.21) superfluous 
>>>variables and two unnecessary assignments in do_mlock().  The intent of 
>>>the resulting code is also more obvious.
>>>
>>>Tested on a 4 way x86 box running a simple mlock test program.  No 
>>>problems detected.
>>
>>Did you test with multiple page ranges, and locking subsets of vmas?
>>Seems that splitting could cause a problem since you now sample vm_end
>>before and after fixup, where the vma could be changed in the middle.
> 
> 
> Actually I think it winds up being fine since we don't do merging with
> mlock.  But why not?  Patch below remedies that.

We don't merge, but we do split if necessary, so the temp variables are 
still needed.  As I understand it, the reason we don't merge is because 
it is expected that a task will lock and unlock the same memory range 
more than once and we don't want to waste our time merging and splitting 
the VMAs.

Thanks,

--Darren
