Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbUK2SAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbUK2SAg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 13:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbUK2SAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 13:00:36 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:683 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261440AbUK2SAS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 13:00:18 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 29 Nov 2004 18:34:19 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: MTRR vesafb and wrong X performance
Message-ID: <20041129173419.GC26190@bytesex>
References: <1101338139.1780.9.camel@PC3.dom.pl> <20041124171805.0586a5a1.akpm@osdl.org> <1101419803.1764.23.camel@PC3.dom.pl> <87is7ogb93.fsf@bytesex.org> <20041129154006.GB3898@redhat.com> <20041129162242.GA25668@bytesex> <20041129165701.GA903@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041129165701.GA903@redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> size_total is calculated thus:
> 
>     size_total = screen_info.lfb_size * 65536;

That comes almost directly from the BIOS, the screen_info struct is
filled by the real mode boot code (vga.S IIRC).

>     if (vram_total)
>         size_total = vram_total * 1024 * 1024;

The vesafb option to override stuff.

>     if (size_total < size_vmode)
>         size_total = size_vmode;

Thats kida silly, but as I've found some simliar construct in the old
code I left it in to avoid breaking stuff.  Guess there is a reason that
this was there.  I'll take that as proof that broken BIOSes exist which
don't fill screen_info.lfb_size correctly ;)

> or blacklist if there aren't too many perhaps?

Hmm, how identify them?  Map the BIOS and poke around there?
screen_info gives next to no info here.

Maybe it works better to walk the PCI device list, find the correct
gfx card using the framebuffer start address, then double-check the
size by looking at the PCI ressources?

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
