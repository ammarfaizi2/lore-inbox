Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbVHDCUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbVHDCUd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 22:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbVHDCUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 22:20:33 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:21122 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261644AbVHDCUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 22:20:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=IuwzCQupaWbGpaBZ6Be+IQgl5H9LPaZluDaCc5nlpwcYbe/KovCIMRrnbMZT7EAJSf5aNUR+aNEnDZ3GzIX9C8nLej3G2mD6a2yygcETi0VJY3f6+/cGdEi1eabR5DxqFcIBqeFVWUUw0qwNuODVIqfPOJzu87ZLX9rEFGQOxgQ=
Date: Thu, 4 Aug 2005 11:20:25 +0900
From: Tejun Heo <htejun@gmail.com>
To: Edward Falk <efalk@google.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Carlos Pardo <Carlos.Pardo@siliconimage.com>
Subject: Re: [PATCH linux-2.6.13-rc3] SATA: rewritten sil24 driver
Message-ID: <20050804022025.GA19237@htj.dyndns.org>
References: <20050728013622.GA14026@htj.dyndns.org> <42E93FB9.6090800@pobox.com> <20050730081734.GA14242@htj.dyndns.org> <42EFFA05.8010003@google.com> <42F04361.4020001@pobox.com> <20050803142812.GA25446@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050803142812.GA25446@htj.dyndns.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Edward.

 One more question.

> > >
> > >I think this will work (adapted from sil_interrupt():
> > >
> > >static void sil_irq_clear(struct ata_port *ap)
> > >{
> > >        struct sil_port_priv *pp = ap->private_data;
> > >        struct Port_Registers *port_base = pp->pregs;
> > >    unsigned long port_int;
> > >
> > >    port_int  = readl((void *)&port_base->IntStatus);
> > >    writel(port_int, &port_base->IntStatus);
> > >}
> > >
> > >I'm assuming that this entry point is expected to clear all interrupts, no?
> > 
> > Correct.
> > 
> 
>  I'll verify with the error register clearing part of the original
> driver and submit a patch.
> 

 Command completion interrupt is automatcally cleared by reading
PORT_SLOT_STAT register (SlotStatus in the original driver), and error
registers should be manually cleared by writing to PORT_IRQ_STAT
(IntStatus).

 I agree that above code should clear both.  Just wanna verify.  Have
you tested it and/or do you have any information confirming this?  If
we don't have any further info, I think we should read PORT_SLOT_STAT
before clearing PORT_IRQ_STAT to be on the safe side.

 Thanks.

-- 
tejun
