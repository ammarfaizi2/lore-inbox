Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262618AbVCVKnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262618AbVCVKnO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 05:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262617AbVCVKnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 05:43:14 -0500
Received: from fire.osdl.org ([65.172.181.4]:27594 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262615AbVCVKmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 05:42:47 -0500
Date: Tue, 22 Mar 2005 02:42:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: Holger.Kiehl@dwd.de, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, emoore@lsil.com
Subject: Re: Fusion-MPT much faster as module
Message-Id: <20050322024215.2896fb13.akpm@osdl.org>
In-Reply-To: <200503221029.j2MATNg12775@unix-os.sc.intel.com>
References: <Pine.LNX.4.61.0503220813290.17195@diagnostix.dwd.de>
	<200503221029.j2MATNg12775@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
>
> On Mon, 21 Mar 2005, Andrew Morton wrote:
> > Holger, this problem remains unresolved, does it not?  Have you done any
> > more experimentation?
> >
> > I must say that something funny seems to be happening here.  I have two
> > MPT-based Dell machines, neither of which is using a modular driver:
> >
> > akpm:/usr/src/25> 0 hdparm -t /dev/sda
> >
> > /dev/sda:
> > Timing buffered disk reads:  64 MB in  5.00 seconds = 12.80 MB/sec
> 
> 
> Holger Kiehl wrote on Tuesday, March 22, 2005 12:31 AM
> > Got the same result when compiled in, always between 12 and 13 MB/s. As
> > module it is approx. 75 MB/s.
> 
> 
> Half guess, half with data to prove: it must be the variable driver_setup
> initialization.  If compiled as built-in, driver_setup is initialized to
> zero for all of its member variables, which isn't the fastest setting. If
> compiled as module, it gets first class treatment with shinny performance
> setting.  Goofing around, this patch appears to be giving higher throughput.

ooh, you actually looked at the code ;)

> Before:
> /dev/sdc:
>  Timing buffered disk reads:   92 MB in  3.03 seconds =  30.32 MB/sec
> 
> After:
> /dev/sdc:
>  Timing buffered disk reads:  174 MB in  3.02 seconds =  57.61 MB/sec
> 

Yes, that's it.  Eric, you owe me about 10000 hours ;)

