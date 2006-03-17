Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030179AbWCQONb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030179AbWCQONb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 09:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932747AbWCQONb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 09:13:31 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:23756 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932736AbWCQONa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 09:13:30 -0500
Date: Fri, 17 Mar 2006 19:43:22 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, shaohua.li@intel.com,
       bryce@osdl.org, ashok.raj@intel.com
Subject: Re: [PATCH] Check for online cpus before bringing them up
Message-ID: <20060317141322.GB27325@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060316174447.GA8184@in.ibm.com> <20060316170814.02fa55a1.akpm@osdl.org> <20060317084653.GA4515@in.ibm.com> <20060317010412.3243364c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060317010412.3243364c.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2006 at 01:04:12AM -0800, Andrew Morton wrote:
> OK..  I guess we should fix those architectures while we're thinking about it.

Only x86 has this bug, so only x86 needs to be fixed. Neverthless
Ashok's patch [1] should address all architectures that may implement
smp_prepare_cpu() in future as well.

> How well tested is this?  From my reading, this will cause
> enable_nonboot_cpus() to panic.  Is that intended?

I have done some basic test of the patch using Bryce's scripts.
Regarding enable_nonboot_cpus(), from my reading of it, it should not
call smp_prepare_cpu on online cpus, so the check added should not cause
it to panic. Am I missing something?

Finally, I think the patch Ashok posted sometime back [1] is probably a more
neater solution to this bug (he probably needs to modify it slightly to 
remove smp_prepare_cpu from enable_nonboot_cpus as well).


[1] http://lkml.org/lkml/2006/3/17/103

-- 
Regards,
vatsa
