Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbTJFUUk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 16:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbTJFUUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 16:20:40 -0400
Received: from gemini.smart.net ([205.197.48.109]:21011 "EHLO gemini.smart.net")
	by vger.kernel.org with ESMTP id S261459AbTJFUUj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 16:20:39 -0400
Message-ID: <3F81CE9A.851806B8@smart.net>
Date: Mon, 06 Oct 2003 16:20:42 -0400
From: "Daniel B." <dsb@smart.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18+dsb+smp+ide i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE DMA errors, massive disk corruption:  Why?  Fixed Yet?  Why not  
 re-do failed op?
References: <785F348679A4D5119A0C009027DE33C105CDB20A@mcoexc04.mlm.maxtor.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mudama, Eric" wrote:
... 
> > Doesn't the kernel keep track of uncompleted operations,
> > retain the information needed to try again, and try again
> > if there's a failure?  If not, why not?
> 
> If the disk has write cache enabled, this isn't necessarilly possible, since
> there's nothing in the IDE specification that guarantees the order of writes
> to the media without a FLUSH CACHE (EXT) command.

Are you sure?  If you issue a write to block 1 and then issue another
write to block 1, it would have to guarantee the relative order of those 
writes (or equivalent optimization in the write cache), wouldn't it?


> Hypothetically, if you were doing full-pack random writes continuously with
> no idle time and no FLUSH CACHE, you can have writes that are days old still
> in the drive's buffer and still un-attempted.  A write with write-cache
> enabled reports ending status at the completion of the transfer.  There is
> no mechanism to tell the host that a cached write failed, other than giving
> an error on the next command.

But we're not talking about errors IN the disk drive after the communi-
cation between the kernel and drive is already done.  We're talking
about errors in the communication BETWEEN the kernel and the drive (lost
DMA interrupts), aren't we?

If the kernel issues a write command to the drive, and never gets a 
response (DMA-complete interrupt?) from the drive that it has accepted 
the command, why can't the kernel repeat the write command?

Daniel
-- 
Daniel Barclay
dsb@smart.net
