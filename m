Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271095AbTGPUvG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 16:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271104AbTGPUvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 16:51:05 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:10256 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S271095AbTGPUu6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 16:50:58 -0400
Date: Wed, 16 Jul 2003 23:05:48 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jens Axboe <axboe@suse.de>, Dave Jones <davej@codemonkey.org.uk>,
       vojtech@suse.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PS2 mouse going nuts during cdparanoia session.
Message-ID: <20030716210548.GA1951@win.tue.nl>
References: <20030716165701.GA21896@suse.de> <20030716170352.GJ833@suse.de> <1058375425.6600.42.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058375425.6600.42.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 06:10:33PM +0100, Alan Cox wrote:
> On Mer, 2003-07-16 at 18:03, Jens Axboe wrote:
> > > The IDE CD drive is using DMA, and interrupts are unmasked.
> > > according to the logs, its happened 32 times since I last
> 
> So why isnt this occurring on 2.4 .. thats the important question here is
> this a logging thing, a new input layer bug, an ide bug or what ?

The default kernel can spend very large amounts of time in IDE code.
With DMA it can be seconds.
With PIO it can be minutes.
This means that with PIO one may think that the system crashed, and see
(under X) keyboard or mouse actions only after for example two minutes.
With DMA things are much better, but still a delay of seconds
is very noticeable.

The input code used to have

        if (psmouse->pktcnt && time_after(jiffies, psmouse->last + HZ/20)) {
                printk(KERN_WARNING "psmouse.c: Lost synchronization, throwing \
%d bytes away.\n", psmouse->pktcnt);
                psmouse->pktcnt = 0;
        }

and I patched it to HZ/2, that helps, but is still not good enough.


Andries

