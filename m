Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266570AbUGPUPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266570AbUGPUPw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 16:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266575AbUGPUPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 16:15:52 -0400
Received: from havoc.gtf.org ([216.162.42.101]:16603 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266570AbUGPUPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 16:15:49 -0400
Date: Fri, 16 Jul 2004 16:15:15 -0400
From: David Eger <eger@havoc.gtf.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pmac_zilog: initialize port spinlock on all init paths
Message-ID: <20040716201515.GA14095@havoc.gtf.org>
References: <20040712075113.GB19875@havoc.gtf.org> <20040712082104.GA22366@havoc.gtf.org> <20040712220935.GA20049@havoc.gtf.org> <20040713003935.GA1050@havoc.gtf.org> <1089692194.1845.38.camel@gaston> <20040714040403.GA29729@havoc.gtf.org> <20040714233920.GP21856@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714233920.GP21856@smtp.west.cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 04:39:20PM -0700, Tom Rini wrote:
> On Wed, Jul 14, 2004 at 12:04:03AM -0400, David Eger wrote:
> > > > ( of course, it still spews diahrea of 'IN from bad port XXXXXXXX'
> > > >   but then, I don't have the hardware.... still, seems weird that OF
> > > >   would report that I do have said hardware :-/ )
> > > 
> > > The IN from bad port is a different issue, it's probably issued by
> > > another driver trying to tap legacy hardware, either serial.o or
> > > ps/2 kbd, I suppose, check what else of that sort you have in your
> > >  .config
> > 
> > Sure enough, the "IN from bad port XXXXXXXX" ended up being the i8042
> > serial PC keyboard driver, enabled with CONFIG_SERIO_I8042.  Don't know
> > why that's in ppc defconfig....
> 
> That's on for all of the ppc boards with an i8042 which the defconfig is
> supposed to support (prep & chrp hardware).

Sorry, I tend to think "ppc == pmac".  So, a couple of thoughts:

(1) Can you make the i8042 disable itself if the hardware isn't there?
    Those damned bad port messages eat my entire syslog buffer.

(2) At the moment, that defconfig is also shared by us TiBook hackers.
    Would it be feasible to have a separate pmac_defconfig?  How do 
    'make menuconfig' and friends choose a defconfig if there isn't a .config?

-dte

