Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262022AbVHEWzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbVHEWzJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 18:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbVHEWxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 18:53:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58006 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262022AbVHEWwn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 18:52:43 -0400
Date: Fri, 5 Aug 2005 15:51:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: greg@kroah.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, rajesh.shah@intel.com
Subject: Re: [PATCH] 6700/6702PXH quirk
Message-Id: <20050805155131.7e3fdcf7.akpm@osdl.org>
In-Reply-To: <1123281604.4706.13.camel@whizzy>
References: <1123259263.8917.9.camel@whizzy>
	<20050805183505.GA32405@kroah.com>
	<1123279513.4706.7.camel@whizzy>
	<20050805152645.60c0e8d4.akpm@osdl.org>
	<1123281604.4706.13.camel@whizzy>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristen Accardi <kristen.c.accardi@intel.com> wrote:
>
> On Fri, 2005-08-05 at 15:26 -0700, Andrew Morton wrote:
> > Kristen Accardi <kristen.c.accardi@intel.com> wrote:
> 
> > > +	if (!quirk)
> > > +		return -ENOMEM;
> > > +	
> > > +	INIT_LIST_HEAD(&quirk->list);
> > > +	quirk->dev = dev;
> > > +	list_add(&quirk->list, &msi_quirk_list);
> > > +	return 0;
> > > +}
> > 
> > Does the list not need any locking?
> 
> Actually, I'm glad you asked that question because I was wondering that
> myself.  The devices are added to the list at boot time, and after that
> time, the list will never change.  Does PCI enumeration happen on all
> processors?  I thought maybe it only happened on one.  In that case we
> don't need a lock I don't think.  
> 

do_basic_setup() is called after SMP is up and running.  do_basic_setup()
calls driver_init() and most of the initcalls.  Plus there's kernel
preemption.

So yup, I think you need locking..
