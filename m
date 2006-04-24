Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751484AbWDXBvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbWDXBvg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 21:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWDXBvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 21:51:36 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:14465 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1751484AbWDXBvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 21:51:35 -0400
Date: Mon, 24 Apr 2006 10:47:01 +0900 (JST)
Message-Id: <20060424.104701.10576428.taka@valinux.co.jp>
To: sekharan@us.ibm.com
Cc: akpm@osdl.org, haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] [RFC] [PATCH 00/12] CKRM after a major overhaul
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <1145670536.15389.132.camel@linuxchandra>
References: <1145638722.14804.0.camel@linuxchandra>
	<20060421155727.4212c41c.akpm@osdl.org>
	<1145670536.15389.132.camel@linuxchandra>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chandra,

> > Could I ask that you briefly enumerate
> > 
> > a) which controllers you think we'll need in the forseeable future
> > 
> 
> Our main object is to provide resource control for the hardware
> resources: CPU, I/O and memory.
> 
> We have already posted the CPU controller.
> 
> We have two implementations of memory controller and a I/O controller. 
> 
> Memory controller is understandably more complex and controversial, and
> that is the reason we haven't posted it this time around (we are looking
> at ways to simplify the design and hence the complexity). Both the
> memory controllers has been posted to linux-mm.
> 
> I/O controller is based on CFQ-scheduler.
> 
> > b) what they need to do

	(snip)

> I/O Controller that we are working on is based on CFQ scheduler and
> provides bandwidth control.  
> > 
> > c) pointer to prototype code if poss

	(snip)

> i/o controller: This controller is not ported to the framework posted,
> but can be taken for a prototype version. New version would be simpler
> though.

I think controlling I/O bandwidth is right way to go.

However, I think you need to change the design of the controller a bit.
A lot of I/O requests processes issue will be handled by other contexts.
There are AIO, journaling, pdflush and vmscan, which some kernel threads
treat instead of the processes.

The current design looks not to care about this.

Thanks,
Hirokazu Takahashi.
