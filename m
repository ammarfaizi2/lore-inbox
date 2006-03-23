Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbWCWFqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbWCWFqZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 00:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWCWFqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 00:46:25 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:52892 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932428AbWCWFqX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 00:46:23 -0500
Date: Wed, 22 Mar 2006 21:41:50 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, perfmon@napali.hpl.hp.com,
       linux-ia64@vger.kernel.org
Subject: Re: perfmon2 context: thread_struct vs. task_struct?
Message-ID: <20060323054150.GC26848@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20060322233253.GB26602@frankl.hpl.hp.com> <20060322183736.4a3bb1c2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060322183736.4a3bb1c2.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

On Wed, Mar 22, 2006 at 06:37:36PM -0800, Andrew Morton wrote:
> > Would it make sense  to move the pointer to the perfmon2
> > context into the task_struct?
> 
> I'd say so, yes.  Especialy if the struct is the same on all architectures,
> is referred to from non-arch-specific code and is absent if
> CONFIG_PERFMON=n.
> 
Yes the structure is the same for all architectures. It looks like
task_struct already has #ifdefs in it. So I could do:

struct task_struct {
	....
#ifdef CONFIG_PERFMON
	struct pfm_context *pfm_context;
#endif
	...
};

-- 
-Stephane
