Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266519AbUITNtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266519AbUITNtc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 09:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266555AbUITNtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 09:49:32 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:60148 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266519AbUITNta (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 09:49:30 -0400
Date: Mon, 20 Sep 2004 19:19:11 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, fastboot@osdl.org,
       Suparna Bhattacharya <suparna@in.ibm.com>, mbligh@aracnet.com,
       agl@us.ibm.com
Subject: Re: [Fastboot] Re: [PATCH][2/6]Memory preserving reboot using kexec
Message-ID: <20040920134911.GA4592@in.ibm.com>
Reply-To: hari@in.ibm.com
References: <20040915125041.GA15450@in.ibm.com> <20040915125145.GB15450@in.ibm.com> <20040915125322.GC15450@in.ibm.com> <m1d60i8075.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1d60i8075.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Sun, Sep 19, 2004 at 02:37:18PM -0600, Eric W. Biederman wrote:
> Hariprasad Nellitheertha <hari@in.ibm.com> writes:
> 
> > This patch contains the code that does the memory preserving reboot. It 
> > copies over the first 640k into a backup region before handing over to 
> > kexec. The second kernel will boot using only the backup region.
> 
> Do you know what the kernel does with the low 1M?
> 
> Nothing in the hardware architecture requires us to use the
> low 1M.  So I think we would be safer if we could track down
> and remove this dependency.
> 
> In general I agree that we need to be prepared to save some of the
> original machine state, because some architectures give special
> meaning to addresses in memory.  But x86 is not one of those.
> 
> Perhaps the proper abstraction is to add a use_mem= variable
> that simply tells us which memory addresses we can use.
> 
> By still doing some copying we run into the problem, of
> potentially running out of memory areas where ongoing DMA
> transfers may be happening.  So this is worth
> tracking down.

I am trying to track this down. I tried moving the first segment of vmlinux
into the reserved section by modifying kexec-tools. This is the command line
argument segment. It still seems to need the first few kilobytes, though. 

Eliminating this is definitely needed so we can avoid using the first 
kernel's region completely.

Also, I will make the changes in the rest of the patch as per your review
comments.

Regards, Hari
-- 
Hariprasad Nellitheertha
Linux Technology Center
India Software Labs
IBM India, Bangalore
