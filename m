Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265256AbUBFM0F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 07:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265290AbUBFM0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 07:26:05 -0500
Received: from codepoet.org ([166.70.99.138]:51356 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S265256AbUBFM0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 07:26:02 -0500
Date: Fri, 6 Feb 2004 05:25:33 -0700
From: Erik Andersen <andersen@codepoet.org>
To: DervishD <raul@pleyades.net>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with IDE taskfile
Message-ID: <20040206122533.GA26575@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	DervishD <raul@pleyades.net>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20040202120120.GC570@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202120120.GC570@DervishD>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Feb 02, 2004 at 01:01:20PM +0100, DervishD wrote:
>     Hi all :))
> 
>     In my logs I have the following message:
> 
> <28>Feb  2 12:18:41 kernel: hda: ST340016A, ATA DISK drive
> <28>Feb  2 12:18:41 kernel: hdb: ST34310A, ATA DISK drive
> <28>Feb  2 12:18:41 kernel: blk: queue c02d0020, I/O limit 4095Mb (mask 0xffffffff)
> <28>Feb  2 12:18:41 kernel: blk: queue c02d015c, I/O limit 4095Mb (mask 0xffffffff)
> [...]
> <28>Feb  2 12:18:41 kernel: hda: attached ide-disk driver.
> <28>Feb  2 12:18:41 kernel: hda: host protected area => 1
> <30>Feb  2 12:18:41 kernel: hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63, UDMA(100)
> <28>Feb  2 12:18:41 kernel: hdb: attached ide-disk driver.
> <28>Feb  2 12:18:41 kernel: hdb: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> <28>Feb  2 12:18:41 kernel: hdb: task_no_data_intr: error=0x04 { DriveStatusError }
> <30>Feb  2 12:18:41 kernel: hdb: 8420832 sectors (4311 MB) w/512KiB Cache, CHS=524/255/63, UDMA(33)
> 
>     The problem is that message from function 'task_no_data_intr'.
> What can be the problem? Should I worry about it? Is the drive
> damaged?

Nope.  This is a bug in the 2.4.x ide driver.  I sent in a patch
for it a while back that made it into 2.6, but not into 2.4.
Basically, the 2.4.x ide driver always asks the drive if it
supports HPA.  In this case, your drive is old and doesn't know
what an HPA is, and complains.  Some older drives get confused
and have to be power cycled when this happens.

http://lkml.org/lkml/2003/8/22/193

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
