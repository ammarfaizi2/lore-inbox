Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261523AbUK1Q7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbUK1Q7I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 11:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbUK1Q4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 11:56:04 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:684 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261530AbUK1QxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 11:53:19 -0500
Date: Sun, 28 Nov 2004 17:52:58 +0100
From: Jens Axboe <axboe@suse.de>
To: Thomas Fritzsche <tf@noto.de>
Cc: Pasi Savolainen <psavo@iki.fi>, linux-kernel@vger.kernel.org
Subject: Re: Is controlling DVD speeds via SET_STREAMING supported?
Message-ID: <20041128165257.GA26714@suse.de>
References: <33133.192.168.0.2.1101499190.squirrel@192.168.0.10> <32942.192.168.0.2.1101549298.squirrel@192.168.0.10> <slrncqhqib.19r.psavo@varg.dyndns.org> <33262.192.168.0.2.1101597468.squirrel@192.168.0.10> <slrncqjcve.19r.psavo@varg.dyndns.org> <33050.192.168.0.5.1101651929.squirrel@192.168.0.10>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33050.192.168.0.5.1101651929.squirrel@192.168.0.10>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28 2004, Thomas Fritzsche wrote:
> Hi,
> 
> (please CC me because I'm not subscribed to the list)
> 
> >> What Kernel do you use?
> >
> > Linux tienel 2.6.10-rc2-mm1 #1 SMP Wed Nov 17 01:19:53 EET 2004 i686
> > GNU/Linux
> 
> Maybe you can give a 2.4.27'er kernel a try.
> 
> >
> > Actually now that I rebooted (for DVD flashing) and started back into
> > linux, after running dvdspeed it also says:
> > "scsi: unknown opcode 0xb6" (which is SET_STREAMING). Code for this is
> > in drivers/block/scsi_ioctl.c, and if I read it right, it can't prevent
> > root from executing that command.
> 
> I have the same impression after reading drivers/block/scsi_ioctl.c . I
> think you will need root permission to send this command, RW-Permission
> for the device file is not enough! Did you try this as root?

You just need to add SET_STREAMINIG as a write-safe command, then it
will work as a regular user. Hmm, it is already added as write safe. You
don't have write permission on the device, then.

> But I'm wondering that scsi_ioctl.c comes into play, because It's a
> ATAPI-Device. Isn't it? Do you use the scsi emulation? If so please try
> without.

The 'scsi' in the name doesn't refer to the transport used, but the
command set being scsi-like. ide-scsi emulation has nothing to do with
it.

> > I modified your speed-1.0 to open device O_RDWR, didn't help.
> > I modified it to also dump_sense after CMD_SEND_PACKET, it's just
> > duplicate packet.
> 
> No this will definitively not solve this issue. I will try to check this
> in the kernel, but because I'm not a kernel developer I will CC Jens
> Axboe. Maybe he can help?

Just fix the permission on the special file. Additionally, the program
must open the device O_RDWR.

-- 
Jens Axboe

