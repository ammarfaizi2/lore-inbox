Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268120AbUJOB6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268120AbUJOB6c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 21:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268130AbUJOB6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 21:58:32 -0400
Received: from ozlabs.org ([203.10.76.45]:42205 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268129AbUJOB6K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 21:58:10 -0400
Subject: Re: [STACK] >3k call path in ide
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       michael@metaparadigm.com,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hugh@veritas.com
In-Reply-To: <20040610161021.7997ad9d.akpm@osdl.org>
References: <20040609122921.GG21168@wohnheim.fh-wedel.de>
	 <40C72B68.1030404@metaparadigm.com>
	 <20040609162949.GC29531@wohnheim.fh-wedel.de>
	 <20040609122721.0695cf96.akpm@osdl.org>
	 <20040610225938.GF3340@wohnheim.fh-wedel.de>
	 <20040610161021.7997ad9d.akpm@osdl.org>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1097805499.22673.65.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 15 Oct 2004 11:58:19 +1000
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-11 at 09:10, Andrew Morton wrote:
> Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
> >
> > read_page_state doesn't exist in 2.6.7-rc3 or 2.6.6-mm5.  How is it
> > defined?
> 
> It was in 2.6.7-rc3-mm1.
> 
> 
> 
> struct page_state is large (148 bytes) and we put them on the stack in awkward
> code paths (page reclaim...)
> 
> So implement a simple read_page_state() which can be used to pluck out a
> single member from the all-cpus page_state accumulators.
> 
> Signed-off-by: Andrew Morton <akpm@osdl.org>
...
> +unsigned long __read_page_state(unsigned offset)
> +{
> +	unsigned long ret = 0;
> +	int cpu;
> +
> +	for (cpu = 0; cpu < NR_CPUS; cpu++) {
> +		unsigned long in;
> +
> +		if (!cpu_possible(cpu))
> +			continue;

for_each_cpu(cpu) here perhaps?

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

