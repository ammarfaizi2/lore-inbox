Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262645AbTEVJve (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 05:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262671AbTEVJve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 05:51:34 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:61640 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262645AbTEVJvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 05:51:32 -0400
Date: Thu, 22 May 2003 12:03:58 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Ted Kremenek <kremenek@cs.stanford.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mc@cs.stanford.edu, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [CHECKER] 12 potential leaks in kernel 2.5.69
Message-ID: <20030522100358.GB6708@wohnheim.fh-wedel.de>
References: <BAF1B694.8EBC%kremenek@cs.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BAF1B694.8EBC%kremenek@cs.stanford.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 May 2003 23:04:52 -0700, Ted Kremenek wrote:
> linux-2.5.69/drivers/message/i2o/i2o_core.c (lines 1668-1722)
> [BUG/LEAK: may be false positive; status appears to be leaked elsewhere in
> the function on purpose]
> 
>     m=i2o_wait_message(c, "AdapterReset");
>     if(m==0xFFFFFFFF)
>         return -ETIMEDOUT;
>     msg=(u32 *)(c->mem_offset+m);
>     
> Start --->
>     status = pci_alloc_consistent(c->pdev, 4, &status_phys);
> 
>     ... DELETED 48 lines ...
> 
>         { 
>             if((jiffies-time) >= 30*HZ)
>             {
>                 printk(KERN_ERR "%s: Timeout waiting for IOP reset.\n",
>                         c->name);
> Error --->
>                 return -ETIMEDOUT;
>             } 
>             schedule();
>             barrier();

Iirc, the above will leak 4 bytes (plus overhead) once per kernel
boot and controller. This only happens for broken hardware and the
alternative is memory corruption, depending on how broken the hardware
is. Wontfix.

Alan, was that correct?

Jörn

-- 
Those who come seeking peace without a treaty are plotting.
-- Sun Tzu
