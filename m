Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265245AbUHHJle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265245AbUHHJle (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 05:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265247AbUHHJle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 05:41:34 -0400
Received: from vsmtp14.tin.it ([212.216.176.118]:62662 "EHLO vsmtp14.tin.it")
	by vger.kernel.org with ESMTP id S265245AbUHHJlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 05:41:32 -0400
Date: Sun, 8 Aug 2004 11:39:11 +0200
From: Giuliano Pochini <pochini@shiny.it>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SCSI removable devices problem
Message-Id: <20040808113911.6185276c.pochini@shiny.it>
In-Reply-To: <20040801092421.3f138fac.rddunlap@osdl.org>
References: <20040801141931.6e026422.pochini@shiny.it>
	<20040801092421.3f138fac.rddunlap@osdl.org>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Aug 2004 09:24:21 -0700
"Randy.Dunlap" <rddunlap@osdl.org> wrote:

> On Sun, 1 Aug 2004 14:19:31 +0200 Giuliano Pochini wrote:
> 
> | 
> | 
> | It seems that 2.6.7 reads the partition table only once: when the scsi unit
> | is added to the list during boot or when I send the "add-single-device"
> | command. This is a problem with removable devices because if the drive
> | hasn't a disk inserted at boot time, attempting to mount a partitioned disk
> | always results in:
> | 
> | mount: /dev/sdb1 is not a valid block device
> | 
> | Also, bad things may happen (not tested) if a disk was in during boot and I
> | replace it with another one with a different partitioning.
> | 
> | As a workaround I have to send the "remove-single-device" command after
> | having unmounted a volume and "add-single-device" after I have inserted a
> | new one. I don't know when this problem was introduced, sorry.
> 
> I think that it's been this way for some time now...
> 
> Does using
> 	blockdev --rereadpt /dev/sdb1
> help?

Yes, that works.  But IIRC I didn't need that with linux 2.4. The kernel
should reread the table automatically when it receaves an UNIT_ATTENTION
message from the scsi bus.




--
Giuliano.
