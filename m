Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVBVR04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVBVR04 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 12:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVBVR0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 12:26:55 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:33760 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261185AbVBVR01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 12:26:27 -0500
Message-ID: <421B6C12.5020108@sgi.com>
Date: Tue, 22 Feb 2005 11:29:54 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, mort@wildopensource.com, pj@sgi.com,
       linux-kernel@vger.kernel.org, hilgeman@sgi.com, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH/RFC] A method for clearing out page cache
References: <20050214154431.GS26705@localhost> <20050214193704.00d47c9f.pj@sgi.com> <20050221192721.GB26705@localhost> <20050221134220.2f5911c9.akpm@osdl.org> <421A607B.4050606@sgi.com> <20050221144108.40eba4d9.akpm@osdl.org> <20050222075304.GA778@elte.hu> <20050222000710.5ad0d8c1.akpm@osdl.org> <20050222082454.GA2401@elte.hu>
In-Reply-To: <20050222082454.GA2401@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> 
>>> . enable users to
>>> specify an 'allocation priority' of some sort, which kicks out the
>>> pagecache on the local node - or something like that.
>>
>>Yes, that would be preferable - I don't know what the difficulty is
>>with that.  sys_set_mempolicy() should provide a sufficiently good
>>hint.
> 
> 
> yes. I'm not against some flushing mechanism for debugging or test
> purposes (it can be useful to start from a new, clean state - and as
> such the sysctl for root only and depending on KERNEL_DEBUG is probably
> better than an explicit syscall), but the idea to give a flushing API to
> applications is bad i believe.
> 

We're pretty agnostic about this.  I agree that if we were to make this
a system call, then it should be restricted to root.  Or make it a
sysctl.  Whichever way you guys want to go is fine with us.

> It is the 'easy and incorrect path' to a number of NUMA (and non-NUMA)
> VM problems and i fear that it will destroy the evolution of VM
> priority/placement/affinity APIs (NUMAlib, etc.).
>

I have two observations about this:

(1)  It is our intent to use the infrastructure provided by this patch
      as the basis for an automatic (i. e. included with the VM) approach
      that selectively removes unused page cache pages before spilling
      off node.  We just figured it would be easier to get the
      infrastructure in place first.

(2)  If a sufficiently well behaved application knows in advance how
      much free memory it needs per node, then it makes sense to provide
      a mechanism for the application to request this, rather than for
      the VM to try to puzzle this out later.  Automatic algorithms in
      the VM are never perfect; they should be reserved to work in those
      cases where the application(s) either cooperate in such a way to
      make memory demands impossible to predict, or the application
      programmer can't (or can't take the time to) predict how much
      memory the application will use.

> At least making it sufficiently painful to use (via the originally
> proposed root-only sysctl) could still preserve some of the incentive to
> provide a clean solution for applications. 'Time to market' constraints
> should not be considered when adding core mechanisms.
> 
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


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
