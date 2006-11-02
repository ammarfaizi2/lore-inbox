Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWKBXUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWKBXUl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 18:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752779AbWKBXUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 18:20:40 -0500
Received: from mx3.cs.washington.edu ([128.208.3.132]:5338 "EHLO
	mx3.cs.washington.edu") by vger.kernel.org with ESMTP
	id S1750807AbWKBXUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 18:20:40 -0500
Date: Thu, 2 Nov 2006 15:19:46 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: "Richard B. Johnson" <jmodem@AbominableFirebug.com>
cc: muli@il.ibm.com, ak@suse.de, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, jdmason@kudzu.us
Subject: Re: [PATCH 1/4] Calgary: phb_shift can be int
In-Reply-To: <014101c6fed4$d0e4b850$0732700a@djlaptop>
Message-ID: <Pine.LNX.4.64N.0611021519320.7138@attu4.cs.washington.edu>
References: <11625041803066-git-send-email-muli@il.ibm.com>
 <11625041802816-git-send-email-muli@il.ibm.com>
 <Pine.LNX.4.64N.0611021401180.1797@attu4.cs.washington.edu>
 <014101c6fed4$d0e4b850$0732700a@djlaptop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2006, Richard B. Johnson wrote:

> > > diff --git a/arch/x86_64/kernel/pci-calgary.c
> > > b/arch/x86_64/kernel/pci-calgary.c
> > > index 37a7708..31d5758 100644
> > > --- a/arch/x86_64/kernel/pci-calgary.c
> > > +++ b/arch/x86_64/kernel/pci-calgary.c
> >> @@ -740,7 +740,7 @@ static void __init calgary_increase_spli
> > >  {
> > >  u64 val64;
> > >  void __iomem *target;
> > > - unsigned long phb_shift = -1;
> > > + unsigned int phb_shift = ~0; /* silence gcc */
> > >  u64 mask;
> > >
> > >  switch (busno_to_phbid(busnum)) {
> > >
> >
> > There's been a suggestion to add
> >
> > #define SILENCE_GCC(x) = x
> 
> This was previously discussed. To quiet gcc warnings, one can use "var=var",
> but you do not want  to hide it in a macro! That hides bonafide bugs. If you
> carefully review code and see that there is absolutely no possibility of using
> an uninitialized variable in any execution path, then you can assign it to
> itself to quiet the compiler.
> 

Such as the case above.

		David
