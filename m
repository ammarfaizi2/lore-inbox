Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263138AbUEQWuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263138AbUEQWuK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 18:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbUEQWuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 18:50:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:30647 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263033AbUEQWtq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 18:49:46 -0400
Date: Mon, 17 May 2004 15:52:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org, james.bottomley@steeleye.com,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH] init. mca_bus_type even if !MCA_bus
Message-Id: <20040517155222.11f4b253.akpm@osdl.org>
In-Reply-To: <20040517150828.2d5afc1a.rddunlap@osdl.org>
References: <20040517144603.1c63895f.rddunlap@osdl.org>
	<20040517151412.1f7fb7d4.akpm@osdl.org>
	<20040517150828.2d5afc1a.rddunlap@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>
> On Mon, 17 May 2004 15:14:12 -0700 Andrew Morton wrote:
> 
> | "Randy.Dunlap" <rddunlap@osdl.org> wrote:
> | >
> | > -	if(mca_system_init()) {
> | > +	if (mca_system_init()) {
> | >  		printk(KERN_ERR "MCA bus system initialisation failed\n");
> | >  		return -ENODEV;
> | >  	}
> | >  
> | > +	if (!MCA_bus)
> | > +		return -ENODEV;
> | 
> | Why is it appropriate to register the MCA bus type when there is no
> | MCA bus present?
> 
> Mostly because it was selected with CONFIG_MCA=y.
> 
> Another option (I think, need to test) is to check !MCA_bus
> in drivers/mca/mca-legacy.c::find_mca_adapter(), so that
> mca_bus_type isn't used when it shouldn't be.
> 
> Do you prefer that approach?

well my question really was a question, rather than a reimplementation
suggestion.  If it _is_ appropriate that mca_bus_type be registered on a
platform which is discovered to have no MCA hardware then fine.

Greg? James?  Any insights?
