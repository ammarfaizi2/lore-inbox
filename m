Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWDTAxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWDTAxi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 20:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbWDTAxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 20:53:38 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:24508 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750706AbWDTAxi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 20:53:38 -0400
Subject: Re: [RFC PATCH 1/2] Makefile: export-symbol usage report generator.
From: Ram Pai <linuxram@us.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, arjan@infradead.org,
       greg@kroah.com, hch@infradead.org
In-Reply-To: <20060419234112.GI25047@stusta.de>
References: <20060413123826.52D94470030@localhost>
	 <20060418140927.GB11582@stusta.de> <1145489158.7323.169.camel@localhost>
	 <20060419234112.GI25047@stusta.de>
Content-Type: text/plain
Organization: IBM 
Date: Wed, 19 Apr 2006 17:53:34 -0700
Message-Id: <1145494414.7323.178.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-20 at 01:41 +0200, Adrian Bunk wrote:
> On Wed, Apr 19, 2006 at 04:25:58PM -0700, Ram Pai wrote:
> > On Tue, 2006-04-18 at 16:09 +0200, Adrian Bunk wrote:
> > > On Thu, Apr 13, 2006 at 05:38:26AM -0700, Ram Pai wrote:
> > > 
> > > > I ran a report to extract export-symbol usage by kernel modules.  The results
> > > > are at http://www.sudhaa.com/~ram/misc/export_report.txt
> > > > 
> > > > The report lists:
> > > > 1. All the exported symbols and their usage counts by in-kernel modules.
> > > > 2. for each in-kernel module, lists the modules and the exported symbols
> > > > 	from those modules, that it depends on.
> > > > 
> > > > Highlights: 
> > > > 	On x86 architecture
> > > >  	(1) 880 exported symbols not used by any in-kernel modules.
> > > >         (2) 1792 exported symbols used only once.
> > > > 
> > > > I hope this report/tool shall help all inkernel modules to revisit their usage
> > > > of kernel interfaces.
> > > > 
> > > > This patch integrates the report-generator into the kernel build process. After
> > > > applying this patch, invoke 'make export_report'  and it creates the report in
> > > > Documentation/export_report.txt
> > > >...
> > > 
> > > I like your patch, but I have observed two issues:
> > > - please don't force an allmodconfig, simply use the currently compiled
> > >   kernel 
> > 
> > Looking for ideas. Its hard to extract out the imported symbols unless
> > they are compiled as modules. Running the report on a currently compiled
> > kernel will miss most of the subsystems that are not compile as modules.
> > Hence the report wont be complete.  Any suggestions?
> >...
> 
> - it's a tool for kernel hackers who know what they are doing
> - it's a tool to help you finding unused exports, but each one still
>   requires manual verification

I am not sure I understand you.  Are you saying:

        A) the tool should report the export symbol usage with whatever
		set of modules the user has configured in his .config ?
		
		or

        B) the tool should report the export symbol usage for all the
	    modules irrespective of what has been configured in the
	    users .config ?
RP
> 
> Besides this, e.g. CONFIG_SMP=n brings you more modules and therefore a 
> better coverage than allmodconfig.
> 
> cu
> Adrian
> 

