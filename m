Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261985AbUK3HRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbUK3HRR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 02:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbUK3HRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 02:17:17 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:2496 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261985AbUK3HRM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 02:17:12 -0500
Date: Tue, 30 Nov 2004 08:16:39 +0100
From: Jens Axboe <axboe@suse.de>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: cdrecord dev=ATA cannont scanbus as non-root
Message-ID: <20041130071638.GC10450@suse.de>
References: <1101763996l.13519l.0l@werewolf.able.es> <Pine.LNX.4.53.0411292246310.15146@yvahk01.tjqt.qr> <1101765555l.13519l.1l@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101765555l.13519l.1l@werewolf.able.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29 2004, J.A. Magallon wrote:
> dev=ATAPI uses ide-scsi interface, through /dev/sgX. And:
> 
> > scsibus: -1 target: -1 lun: -1
> > Warning: Using ATA Packet interface.
> > Warning: The related Linux kernel interface code seems to be unmaintained.
> > Warning: There is absolutely NO DMA, operations thus are slow.
> 
> dev=ATA uses direct IDE burning. Try that as root. In my box, as root:

Oh no, not this again... Please check the facts: the ATAPI method uses
the SG_IO ioctl, which is direct-to-device. It does _not_ go through
/dev/sgX, unless you actually give /dev/sgX as the device name. It has
nothing to do with ide-scsi. Period.

ATA uses CDROM_SEND_PACKET. This has nothing to do with direct IDE
burning, it's a crippled interface from the CDROM layer that should not
be used for anything.  scsi-linux-ata.c should be ripped from the
cdrecord sources, or at least cdrecord should _never_ select that
transport for 2.6 kernels. For 2.4 you are far better off using
ide-scsi.

> The scan through ATA lasts much less than with ATAPI, and you can burn with
> dev=ATA:1,0,0 or dev=/dev/burner, which is the new recommended way.

No! ATAPI is the recommended way.

-- 
Jens Axboe

