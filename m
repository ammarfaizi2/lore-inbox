Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262030AbULMGQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbULMGQs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 01:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbULMGQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 01:16:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:42393 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262030AbULMGQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 01:16:46 -0500
Date: Sun, 12 Dec 2004 22:13:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: paulmck@us.ibm.com, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com, shaohua.li@intel.com, len.brown@intel.com
Subject: Re: [PATCH] Remove RCU abuse in cpu_idle()
Message-Id: <20041212221327.375fa4d0.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0412112244000.7847@montezuma.fsmlabs.com>
References: <20041205004557.GA2028@us.ibm.com>
	<20041206111634.44d6d29c.sfr@canb.auug.org.au>
	<20041205232007.7edc4a78.akpm@osdl.org>
	<Pine.LNX.4.61.0412060157460.1036@montezuma.fsmlabs.com>
	<20041206160405.GB1271@us.ibm.com>
	<Pine.LNX.4.61.0412060941560.5219@montezuma.fsmlabs.com>
	<20041206192243.GC1435@us.ibm.com>
	<Pine.LNX.4.61.0412110804500.5214@montezuma.fsmlabs.com>
	<Pine.LNX.4.61.0412112123490.7847@montezuma.fsmlabs.com>
	<Pine.LNX.4.61.0412112205290.7847@montezuma.fsmlabs.com>
	<Pine.LNX.4.61.0412112244000.7847@montezuma.fsmlabs.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
>
> On Sat, 11 Dec 2004, Zwane Mwaikambo wrote:
> 
> > > Introduce cpu_idle_wait() on architectures requiring modification of 
> > > pm_idle from modules, this will ensure that all processors have updated 
> > > their cached values of pm_idle upon exit. This patch is to address the bug 
> > > report at http://bugme.osdl.org/show_bug.cgi?id=1716 and replaces the 
> > > current code fix which is in violation of normal RCU usage as pointed out 
> > > by Stephen, Dipankar and Paul.
> 
> ...
> 
>  void cpu_idle (void)
>  {
> +	int cpu = smp_processor_id();
> +
>  	/* endless idle loop with no priority at all */

This gives me scadzillions of "using smp_procesor_id() in preemptible"
warnings.

I'll shut that up with _smp_processor_id() but one does wonder what happens
if we get preempted and `cpu' refers to some other CPU?

