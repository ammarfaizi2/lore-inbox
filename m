Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbUKIPnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbUKIPnG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 10:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbUKIPnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 10:43:06 -0500
Received: from postino4.roma1.infn.it ([141.108.26.24]:17645 "EHLO
	postino4.roma1.infn.it") by vger.kernel.org with ESMTP
	id S261556AbUKIPnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 10:43:00 -0500
Subject: Re: isa memory address
From: Antonino Sergi <Antonino.Sergi@roma1.infn.it>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <418FA2F1.2090003@osdl.org>
References: <1099901664.2718.92.camel@delphi.roma1.infn.it>
	 <418FA2F1.2090003@osdl.org>
Content-Type: text/plain
Message-Id: <1100014956.30102.54.camel@delphi.roma1.infn.it>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 09 Nov 2004 16:42:36 +0100
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.6; VAE 6.28.0.12; VDF 6.28.0.65
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I looked for iomem with a kernel-2.4.2:

/proc/iomem reports
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1fffbfff : System RAM

Nothing in the region 000d0000-000d0006 (used by my driver),
so why is it BUSY?

I have not tried yet to use it anyway.

Thanks

Antonino Sergi

On Mon, 2004-11-08 at 17:46, Randy.Dunlap wrote:
> Antonino Sergi wrote:
> > Hi,
> > 
> > I'm working with an old data acquisition system that uses an 8-bit card
> > in an ISA slot (address 0xd0000), by a simple driver I ported from
> > kernel 1.1.x to 2.2.24.
> > 
> > It works fine, but I'd like to have features by newer kernels (2.4 or
> > even 2.6), like new filesystems support.
> > 
> > On kernels >=2.4.0 check_region returns -EBUSY for that address,
> > but it is not actually used; I tried to understand if something has been
> > changed/removed, because of obsolescence of devices, in IO management,
> > but I couldn't.
> > 
> > Does anybody have any explanation/suggestion?
> 
> Please post contents of /proc/iomem .
> I'm guessing that it will show something like:
> 000e0000-000effff : Extension ROM
> (but for address 000d0000).
> So then the question becomes how to assign/allocate it for your
> driver.
> 
> You might have to dummy up a call to release_resource() first,
> then use request_resource() to acquire it.
> Or just use the addresses anyway.... even though check_region() says
> -EBUSY.  BTW, check_region() is deprecated in 2.6.x, so if your
> driver could just use request_region() and release_region(), that
> would be better.
> 
> > Thank you
> > 
> > Best Regards,
> > 
> > Antonino Sergi
> > 
> > PS:As I'm not subscribed, please CC me your answers.
> 

