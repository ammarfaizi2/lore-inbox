Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288552AbSADIqh>; Fri, 4 Jan 2002 03:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288550AbSADIq1>; Fri, 4 Jan 2002 03:46:27 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:62224 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S288552AbSADIqM>;
	Fri, 4 Jan 2002 03:46:12 -0500
Date: Fri, 4 Jan 2002 09:45:46 +0100
From: Jens Axboe <axboe@suse.de>
To: R.Oehler@GDImbH.com
Cc: Keith Owens <kaos@ocs.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.17 crashes on SCSI-errors
Message-ID: <20020104094546.O8673@suse.de>
In-Reply-To: <19996.1010086392@ocs3.intra.ocs.com.au> <XFMail.20020104093136.R.Oehler@GDImbH.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <XFMail.20020104093136.R.Oehler@GDImbH.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04 2002, R.Oehler@GDImbH.com wrote:
> 
> On 03-Jan-2002 Keith Owens wrote:
> > On Thu, 03 Jan 2002 14:39:02 +0100 (MET), 
> > R.Oehler@GDImbH.com wrote:
> >>Ksymoops was not possible, because after rebooting the 
> >>memory/module-layout had changed. (Or is there a trick
> >>I don't know?)
> > 
> > /var/log/ksymoops.  man insmod, look for ksymoops assistance.
> > 
> 
> Thanks a lot, I'll try it for the next crash.
> But for now, I think, the output of the SGI debugger I sent
> to the list shows the same.
> 
> kernel BUG at /usr/src/linux-2.4.17-Dbg/include/asm/pci.h:147!
> from [aic7xxx]ahc_linux_run_device_queue+0x39d

aic7xxx is calling pci_map_sg on either an unitialized scatterlist, or
maybe just specifying too many segments. try and add a printk to print
'i' before the BUG() at line 147 in include/asm-i386/pci.h

-- 
Jens Axboe

