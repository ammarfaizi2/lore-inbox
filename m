Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264792AbTE1P6J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 11:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264791AbTE1P6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 11:58:08 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:28944 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264788AbTE1P6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 11:58:02 -0400
Date: Mon, 26 May 2003 11:42:41 +0200
From: Pavel Machek <pavel@suse.cz>
To: pavel@ucw.cz
Cc: Ted Kremenek <kremenek@cs.stanford.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mc@cs.stanford.edu, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [CHECKER] 12 potential leaks in kernel 2.5.69
Message-ID: <20030526094241.GD642@zaurus.ucw.cz>
References: <BAF1B694.8EBC%kremenek@cs.stanford.edu> <20030522100358.GB6708@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030522100358.GB6708@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

linux-2.5.69/drivers/message/i2o/i2o_core.c (lines 1668-1722)
> > [BUG/LEAK: may be false positive; status appears to be leaked elsewhere in
> > the function on purpose]
> > 
> >     m=i2o_wait_message(c, "AdapterReset");
> >     if(m==0xFFFFFFFF)
> >         return -ETIMEDOUT;
> >     msg=(u32 *)(c->mem_offset+m);
> >     
> > Start --->
> >     status = pci_alloc_consistent(c->pdev, 4, &status_phys);
> > 
> >     ... DELETED 48 lines ...
> > 
> >         { 
> >             if((jiffies-time) >= 30*HZ)
> >             {
> >                 printk(KERN_ERR "%s: Timeout waiting for IOP reset.\n",
> >                         c->name);
> > Error --->
> >                 return -ETIMEDOUT;
> >             } 
> >             schedule();
> >             barrier();
> 
> Iirc, the above will leak 4 bytes (plus overhead) once per kernel
> boot and controller. This only happens for broken hardware and the
> alternative is memory corruption, depending on how broken the hardware
> is. Wontfix.

Perhaps comment should be added?

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

