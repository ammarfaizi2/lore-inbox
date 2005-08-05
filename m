Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262011AbVHEWlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbVHEWlz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 18:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbVHEWly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 18:41:54 -0400
Received: from fmr17.intel.com ([134.134.136.16]:52665 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261559AbVHEWkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 18:40:15 -0400
Subject: Re: [PATCH] 6700/6702PXH quirk
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: greg@kroah.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, rajesh.shah@intel.com
In-Reply-To: <20050805152645.60c0e8d4.akpm@osdl.org>
References: <1123259263.8917.9.camel@whizzy>
	 <20050805183505.GA32405@kroah.com> <1123279513.4706.7.camel@whizzy>
	 <20050805152645.60c0e8d4.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 05 Aug 2005 15:40:03 -0700
Message-Id: <1123281604.4706.13.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
X-OriginalArrivalTime: 05 Aug 2005 22:40:05.0030 (UTC) FILETIME=[9FBFE460:01C59A0E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-05 at 15:26 -0700, Andrew Morton wrote:
> Kristen Accardi <kristen.c.accardi@intel.com> wrote:

> > +	if (!quirk)
> > +		return -ENOMEM;
> > +	
> > +	INIT_LIST_HEAD(&quirk->list);
> > +	quirk->dev = dev;
> > +	list_add(&quirk->list, &msi_quirk_list);
> > +	return 0;
> > +}
> 
> Does the list not need any locking?

Actually, I'm glad you asked that question because I was wondering that
myself.  The devices are added to the list at boot time, and after that
time, the list will never change.  Does PCI enumeration happen on all
processors?  I thought maybe it only happened on one.  In that case we
don't need a lock I don't think.  



