Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266648AbUAWTgk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 14:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266652AbUAWTgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 14:36:40 -0500
Received: from h00a0cca1a6cf.ne.client2.attbi.com ([65.96.182.167]:17280 "EHLO
	h00a0cca1a6cf.ne.client2.attbi.com") by vger.kernel.org with ESMTP
	id S266648AbUAWTgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 14:36:37 -0500
Date: Fri, 23 Jan 2004 14:36:35 -0500
From: timothy parkinson <t@timothyparkinson.com>
To: john stultz <johnstul@us.ibm.com>
Cc: hauan@cmu.edu, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1 "clock preempt"?
Message-ID: <20040123193635.GA492@h00a0cca1a6cf.ne.client2.attbi.com>
Mail-Followup-To: john stultz <johnstul@us.ibm.com>, hauan@cmu.edu,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <1074697593.5650.26.camel@steinar.cheme.cmu.edu> <1074709166.16374.73.camel@cog.beaverton.ibm.com> <20040122193704.GA552@h00a0cca1a6cf.ne.client2.attbi.com> <1074800554.21658.68.camel@cog.beaverton.ibm.com> <20040122195026.GA579@h00a0cca1a6cf.ne.client2.attbi.com> <1074801242.21658.71.camel@cog.beaverton.ibm.com> <20040122200044.GA593@h00a0cca1a6cf.ne.client2.attbi.com> <1074806504.21658.76.camel@cog.beaverton.ibm.com> <20040123190205.GA477@h00a0cca1a6cf.ne.client2.attbi.com> <1074885449.12446.27.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074885449.12446.27.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 11:17:29AM -0800, john stultz wrote:
> On Fri, 2004-01-23 at 11:02, timothy parkinson wrote:
> > On Thu, Jan 22, 2004 at 01:21:45PM -0800, john stultz wrote:
> > > Its likely you need to enable support in the kernel for your IDE
> > > controller, or your DMA on your controller isn't supported.  
> > 
> > so, apparently the problem was that i just needed to enable dma...  which meant
> > that i needed to set "CONFIG_BLK_DEV_VIA82CXXX=y" in my .config.
> > 
> > been running all night/morning with load - no "losing ticks" message or slowing
> > clock yet.  thanks for pointing me in the right direction.
> > 
> > think we could improve that error message?  i'd never have guessed that it was
> > hard disk related if you hadn't told me...
> 
> Well, lost ticks can be caused by many things, but your point is valid,
> the message could be a bit more elightening. 
> 
> thanks
> -john
> 
> 

googling for this issue turns up quite a few questions about it - there's
already one possible answer in the source, couldn't hurt to stick in a few
more:


      if (lost_count++ > 100) {
              printk(KERN_WARNING "Losing too many ticks!\n");
              printk(KERN_WARNING "TSC cannot be used as a timesource.\n"
                    "Are you running with SpeedStep?\n"
+                   "Perhaps you should enable DMA using \"hdparm\"?\n"
+                   "etc..........)\n");
              printk(KERN_WARNING "Falling back to a sane timesource.\n");
              clock_fallback();
      }

not that you have to actually listen to me or anything...  :-)

