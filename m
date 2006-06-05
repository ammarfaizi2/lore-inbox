Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751396AbWFEUGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbWFEUGw (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 16:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWFEUGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 16:06:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27590 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751396AbWFEUGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 16:06:50 -0400
Date: Mon, 5 Jun 2006 13:06:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@suse.cz>,
        Takashi Iwai <tiwai@suse.de>
Subject: Re: 2.6.17-rc5-mm3
Message-Id: <20060605130626.3f2917a2.akpm@osdl.org>
In-Reply-To: <20060605194844.GA6143@redhat.com>
References: <20060603232004.68c4e1e3.akpm@osdl.org>
	<20060605194844.GA6143@redhat.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2006 15:48:45 -0400
Dave Jones <davej@redhat.com> wrote:

> On Sat, Jun 03, 2006 at 11:20:04PM -0700, Andrew Morton wrote:
>  > 
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm3/
>  > 
>  > - Lots of PCI and USB updates
>  > 
>  > - The various lock validator, stack backtracing and IRQ management problems
>  >   are converging, but we're not quite there yet.
> 
> Thought I'd try my bi-annual "poke at -mm". Results were less
> than spectacular.
> 
> http://www.codemonkey.org.uk/junk/DSC00347.JPG
> First the sound driver oopsed.

That's a bug in sound/pci/cs4281.c.

There's a debug patch in -mm
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm3/broken-out/debug-shared-irqs.patch
which trips up drivers which request an IRQ before their IRQ handler is
ready to accept IRQs (they'll crash in real life if the IRQ is shared).

> Then, the whole thing locked up after probing the parallel port.
> I disabled it in the BIOS, and then it locked up probing the floppy drive..
> http://www.codemonkey.org.uk/junk/DSC00348.JPG

That looks like the same thing?

> System is still alive, and responds to keyboard, but makes no forward progress.
> 
> (sysrq-B spewed a lockdep trace and then rebooted. I'll try and get
> that hooked up to a serial console)
> 
> On a whim, I enabled the floppy drive in the BIOS, and rebooted.
> That got me here. http://www.codemonkey.org.uk/junk/DSC00349.JPG
> Same dead userspace.

So does that.

> Off to find a serial cable.

Try reverting debug-shared-irqs.patch, or disable the sound driver?
