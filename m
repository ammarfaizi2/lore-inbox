Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbTKLObb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 09:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbTKLObb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 09:31:31 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:52893 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262074AbTKLOba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 09:31:30 -0500
Date: Wed, 12 Nov 2003 15:31:30 +0100
From: Jens Axboe <axboe@suse.de>
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide cdrom sg like access / rpcmgr ?
Message-ID: <20031112143130.GL21141@suse.de>
References: <1068494681.808.11.camel@simulacron> <20031112113604.GG21141@suse.de> <1068640776.10684.2.camel@simulacron>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1068640776.10684.2.camel@simulacron>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 12 2003, Andreas Jellinghaus wrote:
> On Wed, 2003-11-12 at 12:36, Jens Axboe wrote:
> > Post the code and I'll show you how to do it. Generally, you should just
> > use SG_IO or CDROM_SEND_PACKET for this.
> 
> thanks, the code is at
> http://www.ilovedvd.co.nz/downloads/unix-linux/rpcmgr11.c

How overly complex :-). I wrote a similar tool, dunno if it still works.
Googling shows:

http://www.au.linuxvideo.org/lists/livid-dev/2000-June/msg00649.html

To make the below work, all you probably need to do is change sgio() to
use CDROM_SEND_PACKET for instance. That'll work in 2.4 and 2.6. You
just need to fill a cdrom_generic_command and send it to the cdrom fd.
Ala

	struct cdrom_generic_command cgc;

	memset(&cgc, 0, sizeof(cgc));
	memcpy(cgc.cmd, cdb, sizeof(cdb));
	cgc.buffer = the_buffer_to_write_to;
	cgc.buflen = sizeof(the_buffer_to_write_to);
	cgc.data_direction = CGC_DATA_READ;
	cgc.quiet = 1;

	if (ioctl(cdrom_fd, CDROM_SEND_PACKET, cdrom_fd) < 0) {
		perror("CDROM_SEND_PACKET");
		return 1;
	}

	/* success */
	return 0;

-- 
Jens Axboe

