Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262338AbUBYB15 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 20:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262350AbUBYB15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 20:27:57 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:10661 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262338AbUBYB1i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 20:27:38 -0500
Subject: Re: 2.6.3-mm3 hangs on  boot x440 (scsi?)
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1077672147.2857.78.camel@cog.beaverton.ibm.com>
References: <20040222172200.1d6bdfae.akpm@osdl.org>
	 <1077668801.2857.63.camel@cog.beaverton.ibm.com>
	 <20040224170645.392abcff.akpm@osdl.org>
	 <1077672147.2857.78.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1077672445.2857.80.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 24 Feb 2004 17:27:26 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-02-24 at 17:22, john stultz wrote:
> On Tue, 2004-02-24 at 17:06, Andrew Morton wrote:
> > john stultz <johnstul@us.ibm.com> wrote:
> > >
> > > 	Booting 2.6.3-mm3 on an x440 hangs the box during the SCSI probe after
> > > the following:
> > >  
> > > scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
> > >         <Adaptec aic7899 Ultra160 SCSI adapter>                 
> > >         aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
> > >                                                                 
> > > 
> > > I went back to 2.6.3-mm1 (as it was a smaller diff) and the problem was
> > > there as well. 
> > 
> > Could you try reverting aic7xxx-deadlock-fix.patch?  Also, add
> > initcall_debug to the boot command just so we know we aren't blaming the
> > wrong thing.
> 
> I was suspecting that patch, unfortunately reverting it doesn't seem to
> help.
> 
> Here's the initcall_debug output:
> 
> ide-floppy driver 0.99.newide
> calling initcall 0xc04d6821  
> scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
>         <Adaptec aic7899 Ultra160 SCSI adapter>                 
>         aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

Sorry, sent that too quickly. 

[jstultz@elm3b59 linux-2.6.3]$ grep c04d6821 System.map 
c04d6821 t ahc_linux_init

thanks
-john


