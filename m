Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267851AbUH2Nxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267851AbUH2Nxr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 09:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267835AbUH2Nvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 09:51:51 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:13534 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267839AbUH2Nuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 09:50:44 -0400
Date: Sun, 29 Aug 2004 15:50:37 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Jens Axboe <axboe@suse.de>
Cc: Oliver Neukum <oliver@neukum.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch][3/3] mm/ BUG -> BUG_ON conversions
Message-ID: <20040829135037.GA12134@fs.tum.de>
References: <20040828151137.GA12772@fs.tum.de> <20040828212419.GM12772@fs.tum.de> <20040829120324.GB10112@suse.de> <200408291418.50255.oliver@neukum.org> <20040829130155.GA10279@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040829130155.GA10279@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2004 at 03:01:56PM +0200, Jens Axboe wrote:
> On Sun, Aug 29 2004, Oliver Neukum wrote:
> > Am Sonntag, 29. August 2004 14:03 schrieb Jens Axboe:
> > > > The intention is, to add an option that lets BUG/BUG_ON/WARN_ON/PAGE_BUG 
> > > > do nothing. This option should be hidden under EMBEDDED.
> > > > 
> > > > In some environments, this seems to be desirable.
> > > 
> > > That only makes sense if you are using BUG incorrectly. A BUG()
> > > condition is something that is non-recoverable, undefining that doesn't
> > > make any sense regardless of the environment.
> > 
> > Why not? Giving reports about unrecoverable errors is sensible
> > only if the report can be read. On system this is not the case, you
> > can just salvage the memory and let it crash.
> 
> "Unrecoverable" can quite easily mean "something really bad has
> happened, corruption imminent". So maybe you would want BUG/BUG_ON to
> restart the box there, the restart-on-panic should help you there.
>...

The current sh/sh64 implementation doesn't seem to do any of the things 
you expect from BUG:

#define BUG() do { \
        printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
        asm volatile("nop"); \
} while (0)

> Jens Axboe

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

