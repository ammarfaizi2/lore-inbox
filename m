Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264299AbUE2PWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbUE2PWr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 11:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264302AbUE2PWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 11:22:46 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:54224 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264299AbUE2PWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 11:22:34 -0400
Date: Sat, 29 May 2004 17:22:17 +0200
From: Jens Axboe <axboe@suse.de>
To: Greg KH <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.6-BK usb (printing) broken
Message-ID: <20040529152217.GA17758@suse.de>
References: <20040529140757.GA16264@suse.de> <20040529143941.GA12257@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040529143941.GA12257@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29 2004, Greg KH wrote:
> On Sat, May 29, 2004 at 04:08:00PM +0200, Jens Axboe wrote:
> > 
> > Something between 2.6.7-rc1 and current 2.6-BK broke usb printing here
> > again. I have two printers attached:
> > 
> > usb 1-1: new full speed USB device using address 6
> > usb 1-1: control timeout on ep0out
> > usb 1-1: control timeout on ep0out
> > usb 1-1: device not accepting address 6, error -110
> > usb 1-1: new full speed USB device using address 7
> > usb 1-1: control timeout on ep0out
> > usb 1-1: control timeout on ep0out
> > usb 1-1: device not accepting address 7, error -110
> > 
> > It's a VIA EPIA-800 board, lspci shows the following for usb:
> > 
> > 00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 24)
> > 00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 24)
> 
> Alan, looks like your "fix the VIA controller driver" patch broke
> something here, care to look into it?

Thanks for the hint, backing out this patch:

http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/cset-stern@rowland.harvard.edu|ChangeSet|20040525183839|17182.txt

fixes 2.6-BK for me. Both 2.6.7-rc1 and BK current spit out a bunch of:

drivers/usb/class/usblp.c: usblp1: nonzero read/write bulk status received: -2
drivers/usb/class/usblp.c: usblp1: error -2 reading from printer
drivers/usb/class/usblp.c: usblp1: error -115 reading from printer
drivers/usb/class/usblp.c: usblp1: error -115 reading from printer
...

(about ~80 of that last line) but work for me.

-- 
Jens Axboe

