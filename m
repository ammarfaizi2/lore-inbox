Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262134AbUK3Qa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbUK3Qa7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 11:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbUK3Qa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 11:30:58 -0500
Received: from smtp09.auna.com ([62.81.186.19]:16518 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S262183AbUK3QaA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 11:30:00 -0500
Date: Tue, 30 Nov 2004 16:29:59 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: cdrecord dev=ATA cannont scanbus as non-root
To: Jens Axboe <axboe@suse.de>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
References: <1101763996l.13519l.0l@werewolf.able.es>
	<Pine.LNX.4.53.0411292246310.15146@yvahk01.tjqt.qr>
	<1101765555l.13519l.1l@werewolf.able.es> <20041130071638.GC10450@suse.de>
In-Reply-To: <20041130071638.GC10450@suse.de> (from axboe@suse.de on Tue Nov
	30 08:16:39 2004)
X-Mailer: Balsa 2.2.6
Message-Id: <1101832199l.9494l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.11.30, Jens Axboe wrote:
> On Mon, Nov 29 2004, J.A. Magallon wrote:
> > dev=ATAPI uses ide-scsi interface, through /dev/sgX. And:
> > 
> > > scsibus: -1 target: -1 lun: -1
> > > Warning: Using ATA Packet interface.
> > > Warning: The related Linux kernel interface code seems to be unmaintained.
> > > Warning: There is absolutely NO DMA, operations thus are slow.
> > 
> > dev=ATA uses direct IDE burning. Try that as root. In my box, as root:
> 
> Oh no, not this again... Please check the facts: the ATAPI method uses
> the SG_IO ioctl, which is direct-to-device. It does _not_ go through
> /dev/sgX, unless you actually give /dev/sgX as the device name. It has
> nothing to do with ide-scsi. Period.
> 
> ATA uses CDROM_SEND_PACKET. This has nothing to do with direct IDE
> burning, it's a crippled interface from the CDROM layer that should not
> be used for anything.  scsi-linux-ata.c should be ripped from the
> cdrecord sources, or at least cdrecord should _never_ select that
> transport for 2.6 kernels. For 2.4 you are far better off using
> ide-scsi.
> 
> > The scan through ATA lasts much less than with ATAPI, and you can burn with
> > dev=ATA:1,0,0 or dev=/dev/burner, which is the new recommended way.
> 
> No! ATAPI is the recommended way.
> 
> -- 
> Jens Axboe
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-rc2-jam3 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #1


