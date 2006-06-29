Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWF2Svo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWF2Svo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 14:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbWF2Svn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 14:51:43 -0400
Received: from rtsoft3.corbina.net ([85.21.88.6]:14390 "EHLO
	buildserver.ru.mvista.com") by vger.kernel.org with ESMTP
	id S1751264AbWF2Svn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 14:51:43 -0400
Date: Thu, 29 Jun 2006 22:51:31 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Andy Fleming <afleming@freescale.com>
Cc: Li Yang-r58472 <LeoLi@freescale.com>,
       Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>,
       Yin Olivia-r63875 <Hong-Hua.Yin@freescale.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       linuxppc-dev@ozlabs.org, "'Paul Mackerras'" <paulus@samba.org>,
       Chu hanjin-r52514 <Hanjin.Chu@freescale.com>
Subject: Re: [PATCH 1/7] powerpc: Add mpc8360epb platform support
Message-ID: <20060629225131.43b9ed59@localhost.localdomain>
In-Reply-To: <8A7E4B7C-8744-47FF-90FA-9B68C5187CEE@freescale.com>
References: <9FCDBA58F226D911B202000BDBAD467306E04FE2@zch01exm40.ap.freescale.net>
	<8A7E4B7C-8744-47FF-90FA-9B68C5187CEE@freescale.com>
X-Mailer: Sylpheed-Claws 2.3.0cvs16 (GTK+ 2.8.19; i686-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006 13:03:23 -0500
Andy Fleming wrote:

[snip]
> >>> +	iounmap(bcsr_regs);
> >>> +
> >> And if we have a design, which do not contain real ethernet UCC  
> >> usage? Or UCC
> >> geth is disabled somehow explicitly? Stuff like that normally
> >> goes to the
> >> callback that is going to be triggered upon Etherbet init.
> > I will move it.
> 
> 
> Wait...no.  I don't understand Vitaly's objection.  If someone  
> creates a board with an 8360 that doesn't use the UCC ethernet, they  
> can create a separate board file.  This is the board-specific code,  
> and it is perfectly acceptable for it to reset the PHY like this.   
> What ethernet callback could be used?
> 

I am sort of against the unconditional trigger of the ethernet-specific stuff,
dependless if UCC eth is really wanted in specific configuration.

For stuff like that I'd make a function (to setup low-level stuff), and pass it 
via platform_info to the eth driver, so that really driver-specific things happen in driver context only.

Yes this is board specific file, and virtually everything needed for the board can take place here. 
But usually BCSR acts as a toggle for a several things, and IOW, I see it more correct to trigger those stuff from the respective drivers (using a callback passed through platform_info)

-Vitaly
