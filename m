Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbUD3WGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbUD3WGP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 18:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbUD3WGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 18:06:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:49868 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261576AbUD3WGL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 18:06:11 -0400
Date: Fri, 30 Apr 2004 15:08:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: corbet@lwn.net (Jonathan Corbet)
Cc: ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: [MICROPATCH] Make x86_64 build work without GART_IOMMU
Message-Id: <20040430150828.1594ad6a.akpm@osdl.org>
In-Reply-To: <20040430214040.25268.qmail@lwn.net>
References: <m3ad0t9o54.fsf@averell.firstfloor.org>
	<20040430214040.25268.qmail@lwn.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

corbet@lwn.net (Jonathan Corbet) wrote:
>
> > > My Radeon 9200SE goes nuts if I build a GART-enabled
> > > kernel.  Haven't figured out why...
> > 
> > Define 'nuts' and supply full boot log (with GART enabled)
> 
> Oops, sorry for the technical term...:)

"No User Time Scheduled".  Silly Andi.

> Andrew asked for a profile to help track down where the kernel loop is.  I
> just did one, but the results are less than illuminating:
> 
> 	105219 total                                      0.0448
> 	 85232 __delay                                  2663.5000
> 	 14076 default_idle                             293.2500
> 	  4679 __do_softirq                              26.5852
> 	   474 check_poison_obj                           1.0216
> 	   197 handle_IRQ_event                           2.0521
> 	    91 kmem_cache_free                            0.1034

Yup, that's the one.  There are various loops where the driver spins on a
hardware register, with an mdelay() in the loop.

Can you get a sysrq-p trace?


