Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271214AbTHMWSF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 18:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271235AbTHMWSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 18:18:05 -0400
Received: from mail.kroah.org ([65.200.24.183]:56035 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S271214AbTHMWSA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 18:18:00 -0400
Date: Wed, 13 Aug 2003 15:18:13 -0700
From: Greg KH <greg@kroah.com>
To: junkio@cox.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: C99 Initialisers
Message-ID: <20030813221813.GA7418@kroah.com>
References: <jRnj.2dx.11@gated-at.bofh.it> <jRwZ.2kJ.15@gated-at.bofh.it> <jRQi.2zQ.5@gated-at.bofh.it> <jRZY.2Hw.5@gated-at.bofh.it> <jS9J.2Np.5@gated-at.bofh.it> <jUbt.57S.7@gated-at.bofh.it> <jUuT.5kZ.13@gated-at.bofh.it> <k13k.22O.3@gated-at.bofh.it> <k7Lq.7Gr.7@gated-at.bofh.it> <7v7k5hw907.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7v7k5hw907.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 02:19:36PM -0700, junkio@cox.net wrote:
>  (1) If .subvendor and .subdevice are always PCI_ANY_ID, are
>      there any reason to keep them in the structure in the first
>      place?  I imagine there are some devices but not in the
>      tg3_pci_tbl list that need to have different values there,
>      but if that is the case we may want to generalize the macro
>      PCI_DEVICE like this:
> 
>         #define PCI_DEVICE(vend, dev) \
>             PCI_DEVICE_WITH_SUB(vend, dev, PCI_ANY_ID, PCI_ANY_ID)
>         #define PCI_DEVICE_WITH_SUB(vend, dev, subv, subd) \
>          .vendor = (vend), \
>          .device = (dev), \
>          .subvendor = (subv), \
>          .subdevice = (subd)

Patches always are gladly accepted :)

>  (2) PCI_VENDOR_ID_ and PCI_DEVICE_ID_ seem to be common prefix,
>      so how about doing something like this?
> 
>      #define PCI_DEVICE(vend,dev) \
>          .vendor = (PCI_VENDOR_ID_ ## vend), \
>          .device = (PCI_DEVICE_ID_ ## dev), \
>          .subvendor = PCI_ANY_ID, \
>          .subdevice = PCI_ANY_ID
> 
>      Then the table becomes much shorter:
> 
>      static struct pci_device_id tg3_pci_tbl[] = {
>      ...
>        { PCI_DEVICE(BROADCOM, TIGON3_5700) },
>        { PCI_DEVICE(BROADCOM, TIGON3_5701) },
>      ...

As has been responded before, this isn't a good idea right now.

thanks,

greg k-h
