Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292981AbSCDXKD>; Mon, 4 Mar 2002 18:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292967AbSCDXJy>; Mon, 4 Mar 2002 18:09:54 -0500
Received: from 64-166-72-137.ayrnetworks.com ([64.166.72.137]:25472 "EHLO 
	ayrnetworks.com") by vger.kernel.org with ESMTP id <S292970AbSCDXJp>;
	Mon, 4 Mar 2002 18:09:45 -0500
Date: Mon, 4 Mar 2002 15:09:38 -0800
From: William Jhun <wjhun@ayrnetworks.com>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide_free_irq()
Message-ID: <20020304150938.E1247@ayrnetworks.com>
In-Reply-To: <20020304141709.C1247@ayrnetworks.com> <Pine.LNX.4.10.10203041456040.13256-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10203041456040.13256-100000@master.linux-ide.org>; from andre@linuxdiskcert.org on Mon, Mar 04, 2002 at 02:57:01PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2002 at 02:57:01PM -0800, Andre Hedrick wrote:
> 
> 
> Sure but only one arch I see that is effected and they do not use this
> storage class ...
> 
> asm-s390/ide.h:#define ide_free_irq(irq,dev_id)         do {} while (0)
> asm-s390x/ide.h:#define ide_free_irq(irq,dev_id)        do {} while (0)
> 
> Is there another ?

Well, our MIPS-based platform (whose changes haven't been submitted
yet). We have some broken PCMCIA hardware that requires us to actually
simulate interrupts with a hi-res timer (by calling ide_intr() directly).
Yes, it's ugly, but it's our only solution. This change would enable us
to put our device-specific interrupt "simulation" code into the ide_*
routines only.

It's not a must right now, but it looked like something that was left
out, since the rest of the ide code uses the ide_* generic #defines...

Thanks,
Will Jhun
