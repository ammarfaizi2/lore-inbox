Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263174AbUCaBJD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 20:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263346AbUCaBJC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 20:09:02 -0500
Received: from fw.osdl.org ([65.172.181.6]:15772 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263174AbUCaBI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 20:08:59 -0500
Date: Tue, 30 Mar 2004 17:11:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: rddunlap@osdl.org, hari@in.ibm.com, linux-kernel@vger.kernel.org,
       apw@shadowen.org, jamesclv@us.ibm.com
Subject: Re: BUG_ON(!cpus_equal(cpumask, tmp));
Message-Id: <20040330171104.752104a9.akpm@osdl.org>
In-Reply-To: <270000000.1080694659@flay>
References: <006701c415a4$01df0770$d100000a@sbs2003.local>
	<20040329162123.4c57734d.akpm@osdl.org>
	<20040329162555.4227bc88.akpm@osdl.org>
	<20040330132832.GA5552@in.ibm.com>
	<20040330151729.1bd0c5d0.rddunlap@osdl.org>
	<187940000.1080692555@flay>
	<20040330163928.7cafae3d.akpm@osdl.org>
	<270000000.1080694659@flay>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> I made a similar patch, but I don't see how we can really fix it without
> providing locking on cpu_online_map.

Are we missing something here?

Why does, for example, smp_send_reschedule() not have the same problem? 
Because we've gone around and correctly removed all references to the CPU
from the scheduler data structures before offlining it.

But we're not doing that in the mm code, right?  Should we not be taking
mmlist_lock and running around knocking this CPU out of everyone's
cpu_vm_mask before offlining it?

