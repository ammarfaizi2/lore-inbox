Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263555AbUFZImI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263555AbUFZImI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 04:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266889AbUFZImI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 04:42:08 -0400
Received: from astound-64-85-224-245.ca.astound.net ([64.85.224.245]:56327
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S263555AbUFZImD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 04:42:03 -0400
Date: Sat, 26 Jun 2004 01:31:00 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
cc: Jens Axboe <axboe@suse.de>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jeff Garzik <jgarzik@pobox.com>, Ed Tomlinson <edt@aei.ca>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: ide errors in 7-rc1-mm1 and later
In-Reply-To: <20040610164135.GA2230@bounceswoosh.org>
Message-ID: <Pine.LNX.4.10.10406260118220.19080-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Eric,

There is no need for a new opcode.
The behavior is simple and trivial to support.

If standard flush_cache/ext were to behave just like standard data_in
taskfile register setup, yet use a non_data command state machine it would
be done.

Special case would be deal with LBA Zero and this would have to behave
like a complete device flush.  Since flushing sector zero is not generally
done ... well this would go into a design debate and it is not my issue
nor my desire to enter one today.

28-bit would support max 256 sectors
48-bit would support max 65536 sectors

Anyone could write this simple proposal to T13 for SATA and T10 for SAS.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Thu, 10 Jun 2004, Eric D. Mudama wrote:

> On Thu, Jun 10 at  8:11, Jens Axboe wrote:
> >On Thu, Jun 10 2004, Bartlomiej Zolnierkiewicz wrote:
> >> 
> >> /me just thinks loudly
> >> 
> >> 'linear range' FLUSH CACHE seems so easy to implement that I always wondered
> >> why FLUSH CACHE command doesn't make any use of LBA address and number
> >> of sectors.
> >
> >Indeed, that would be very helpful as well.
> 
> Neat idea... so you send us a LBA and a block count, and we return
> good status if that region is flushed.
> 
> Each command can specify a 32MiB region, assuming a device with
> 512-byte LBAs.
> 
> Propose an exact implementation and an opcode...
> 
> -- 
> Eric D. Mudama
> edmudama@mail.bounceswoosh.org
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

