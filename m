Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262122AbUKJWJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbUKJWJy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 17:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbUKJWJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 17:09:54 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:58607 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262120AbUKJWJY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 17:09:24 -0500
Subject: Re: Externalize SLIT table
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Erich Focht <efocht@hpce.nec.com>
Cc: Mark Goodwin <markgw@sgi.com>, Jack Steiner <steiner@sgi.com>,
       Takayoshi Kochi <t-kochi@bq.jp.nec.com>, linux-ia64@vger.kernel.org,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200411101945.34003.efocht@hpce.nec.com>
References: <20041103205655.GA5084@sgi.com>
	 <1100044724.3980.23.camel@arrakis>
	 <Pine.LNX.4.61.0411101532350.15897@woolami.melbourne.sgi.com>
	 <200411101945.34003.efocht@hpce.nec.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1100124559.6811.4.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 10 Nov 2004 14:09:20 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-10 at 10:45, Erich Focht wrote:
> On Wednesday 10 November 2004 06:05, Mark Goodwin wrote:
> > On a system that has nodes with multiple sockets (each supporting
> > multiple cores or HT "CPUs" sharing some level of cache), when the
> > scheduler needs to migrate a task it would first choose a CPU
> > sharing the same cache, then a CPU on the same node, then an
> > off-node CPU (i.e. falling back to node distance).
> 
> This should be done by correctly setting up the sched domains. It's
> not a question of exporting useless or redundant information to user
> space.
> 
> The need for some (any) cpu-to-cpu metrics initially brought up by
> Jack seemed mainly motivated by existing user space tools for
> constructing cpusets (maybe in PBS). I think it is a tolerable effort
> to introduce in user space an inlined function or macro doing
> something like
>    cpu_metric(i,j) := node_metric(cpu_node(i),cpu_node(j))
> 
> It keeps the kernel free of misleading information which might just
> slightly make cpusets construction more comfortable. In user space you
> have the full freedom to enhance your metrics when getting more
> details about the next generation cpus.

Good point, Erich.  I don't think there is any desperate need for
CPU-to-CPU distances to be exported to userspace right now.  If that is
incorrect and someone really needs a particular distance metric to be
exported by the kernel, we can look into that and export the required
info.  For now I think the Node-to-Node distance information is enough. 
-Matt

