Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264486AbTEaQHL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 12:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264490AbTEaQHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 12:07:11 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:7056 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S264486AbTEaQHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 12:07:09 -0400
Date: Sat, 31 May 2003 11:24:17 -0400
From: Ben Collins <bcollins@debian.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Willy Tarreau <willy@w.ods.org>, Jason Papadopoulos <jasonp@boo.net>,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: Linux 2.4.21-rc3 : IDE pb on Alpha
Message-ID: <20030531152417.GY13766@phunnypharm.org>
References: <5.2.1.1.2.20030526232835.00a468e0@boo.net> <20030527045302.GA545@alpha.home.local> <20030527134017.B3408@jurassic.park.msu.ru> <20030527123152.GA24849@alpha.home.local> <20030527180403.A2292@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030527180403.A2292@jurassic.park.msu.ru>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 06:04:03PM +0400, Ivan Kokshaysky wrote:
> On Tue, May 27, 2003 at 02:31:52PM +0200, Willy Tarreau wrote:
> > Sorry, I pasted the .config that I used just after, and which allowed me to
> > boot. Later I set CONFIG_BLK_DEV_ALI15X3 again and CONFIG_BLK_DEV_IDEDMA_PCI,
> > but I left CONFIG_IDEDMA_PCI_AUTO disabled. I now can boot and enable DMA
> > later. That's weird, but it works.
> 
> Perhaps not that weird. From my experience, ALi DMA is sensitive to
> some of "PIO timings". That is, if SRM hasn't initialized the chipset
> properly (on Nautilus it has, BTW), DMA won't work. When you boot with
> DMA disabled, driver has to set right PIO mode, so you can safely
> enable DMA later.
> 
> Can you (and Jason) try this patch with CONFIG_IDEDMA_PCI_AUTO=y?

Dave Miller asked me to try this patch. On sparc64, we've had a never
ending battle with ALi 5229 on Sun Blade 100's. After some time, files
would start to get corrupted (in memory, not on disk, unless the
corruption was saved somehow inadvertently). It exposed itself as two
null bytes at the start of a file.

I just tried this patch, and for the first time in a long time, I've
been able to boot with UDMA(66) enabled and not get the corruption.
Usually I can expose the corruption with kernel compiles within 10-60
minutes. I've been running your patch for almost 2 days now, and so far
have not been able get corruption. I even left a looping 2.5.69 compile
going (make clean; make) for over 10 hours.



-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
