Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268101AbUJOCFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268101AbUJOCFV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 22:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268126AbUJOCFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 22:05:20 -0400
Received: from ozlabs.org ([203.10.76.45]:57821 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268101AbUJOCFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 22:05:14 -0400
Subject: Re: 2.6.9-rc3-mm2
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: dominik.karall@gmx.net,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041014184427.65d75324.akpm@osdl.org>
References: <20041004020207.4f168876.akpm@osdl.org>
	 <200410051607.40860.dominik.karall@gmx.net>
	 <1097804285.22673.47.camel@localhost.localdomain>
	 <20041014184427.65d75324.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1097805925.22673.70.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 15 Oct 2004 12:05:25 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-15 at 11:44, Andrew Morton wrote:
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> > Please, please please!  Never use per_cpu(XXX, smp_processor_id())!
> 
> Why?

Because that's what get_cpu_var() does, and an arch might not need to
get the processor id to do it.  As more things get per-cpu-ified, and
smp_processor_id() for its own sake becomes more unusual, I expect archs
to go to smp_processor_id() as a per-cpu variable, and a register
holding the per-cpu offset.  (This needs a real dynamic per-cpu
allocator, as well, which I've been meaning to polish off).

> We were getting warnings from somewhere or other due to smp_processor_id()
> within preemptible code - I don't recall the callsite.

That's weird, but implies bogosity in the caller.  Covering it up like
this is not necessarily a win.

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

