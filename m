Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261552AbSIXEn7>; Tue, 24 Sep 2002 00:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261555AbSIXEn6>; Tue, 24 Sep 2002 00:43:58 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:15490 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261552AbSIXEn6>; Tue, 24 Sep 2002 00:43:58 -0400
Message-ID: <3D8FEEBE.F471CA10@us.ibm.com>
Date: Mon, 23 Sep 2002 21:49:02 -0700
From: Larry Kessler <kessler@us.ibm.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH-RFC] README 1ST - New problem logging macros (2.5.38)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> >       }
> >       if (!request_mem_region(pci_resource_start(pdev, 0),
> >                       pci_resource_len(pdev, 0), "eepro100")) {
> > -             printk (KERN_ERR "eepro100: cannot reserve MMIO region\n");
> > +             pci_problem(LOG_ERR, pdev, "eepro100: cannot reserve MMIO region");
> 
> bloat, no advantage over printk

the advantage is that the string, which means plenty to the developer, but possibly
much less to a Sys Admin, can be replaced with a more descriptive message,
in the local language, by editing the formatting template in user-space.  Since the
printk messages were mapped directly over to the problem macros, then the issue here
I think is how useful (or not) the info. is more so than what interface is used. 


> >               if (sum != 0xBABA)
> > -                     printk(KERN_WARNING "%s: Invalid EEPROM checksum %#4.4x, "
> > -                                "check settings before activating this device!\n",
> > -                                dev->name, sum);
> > +                     net_pci_problem(LOG_WARNING, dev, pdev, "Invalid EEPROM checksum, "
> > +                                "check settings before activating this device!",
> 
> > +                                detail(checksum, "%#4.4x", sum));
> 
> bloat, checksum is purely informational, and can be obtained through
> other means

indeed.  See previous comment.
