Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263079AbUCaAhg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 19:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263083AbUCaAhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 19:37:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:36488 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263079AbUCaAhX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 19:37:23 -0500
Date: Tue, 30 Mar 2004 16:39:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: rddunlap@osdl.org, hari@in.ibm.com, linux-kernel@vger.kernel.org,
       apw@shadowen.org
Subject: Re: BUG_ON(!cpus_equal(cpumask, tmp));
Message-Id: <20040330163928.7cafae3d.akpm@osdl.org>
In-Reply-To: <187940000.1080692555@flay>
References: <006701c415a4$01df0770$d100000a@sbs2003.local>
	<20040329162123.4c57734d.akpm@osdl.org>
	<20040329162555.4227bc88.akpm@osdl.org>
	<20040330132832.GA5552@in.ibm.com>
	<20040330151729.1bd0c5d0.rddunlap@osdl.org>
	<187940000.1080692555@flay>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> > I'll just say that kexec fails without this patch and works with
> > it applied, so I'd like to see it merged.  If this patch isn't
> > acceptable, let's find out why and try to make one that is.
> > 
> > Thanks for the patch, Hari.
> 
> >From discussions with Andy, it seems this still has the same race as before
> just smaller. I don't see how we can fix this properly without having some
> locking on cpu_online_map .... probably RCU as it's massively read-biased
> and we don't want to pay a spinlock cost to read it.

We do want to avoid adding stuff to the IPI path.  If the going-away CPU
still responds to IPIs after it has gone away then do we actually need to
do anything?  For x86, at least?
