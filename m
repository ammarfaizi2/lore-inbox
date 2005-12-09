Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932504AbVLIWzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbVLIWzZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 17:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbVLIWzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 17:55:25 -0500
Received: from fmr23.intel.com ([143.183.121.15]:30679 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S932504AbVLIWzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 17:55:24 -0500
Subject: Re: [discuss] [patch] x86_64:  align and pad x86_64 GDT on page
	boundary
From: Rohit Seth <rohit.seth@intel.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, zach@vmware.com,
       shai@scalex86.org, nippung@calsoftinc.com
In-Reply-To: <20051209221922.GA3676@localhost.localdomain>
References: <20051208215514.GE3776@localhost.localdomain>
	 <1134083357.7131.21.camel@akash.sc.intel.com>
	 <20051208231141.GX11190@wotan.suse.de>
	 <1134084367.7131.32.camel@akash.sc.intel.com>
	 <20051208232610.GY11190@wotan.suse.de>
	 <1134085511.7131.53.camel@akash.sc.intel.com>
	 <20051208234320.GB11190@wotan.suse.de>
	 <20051209221922.GA3676@localhost.localdomain>
Content-Type: text/plain
Organization: Intel 
Date: Fri, 09 Dec 2005 15:01:27 -0800
Message-Id: <1134169287.21462.7.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Dec 2005 22:54:37.0674 (UTC) FILETIME=[87EF4CA0:01C5FD13]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-09 at 14:19 -0800, Ravikiran G Thirumalai wrote:
> On Fri, Dec 09, 2005 at 12:43:20AM +0100, Andi Kleen wrote:
> >
> > For scalex I think it needs to be page aligned because that is what
> > the effective cacheline size for remote nodes is in their setup. 
> > That would be difficult for kmalloc because it cannot guarantee that
> > alignment nor avoid false sharing. 
> 
> Exactly.
> 

Are you saying remote node will cache a whole page for every byte access
on that page.

> > For the BP case it's ok as 
> > long as the beginning is correctly aligned and the rest 
> > is read-only.
> 
> Just that any writes on the bp GDT will invalidate the idt_table cacheline,
> which is read mostly (as Nippun pointed out).  So could we keep the padding
> as it is for the BP too? 
> 

Do you write into GDT often for this to be an issue.  The reason I'm
asking this because the per-cpu IDTs that Andi refered in the future.
If we are really not using too many bytes in GDT then rest of the page
can be used for IDT and such mostly RO data.

-rohit

