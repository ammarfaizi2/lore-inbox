Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbTAWTMc>; Thu, 23 Jan 2003 14:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261376AbTAWTMc>; Thu, 23 Jan 2003 14:12:32 -0500
Received: from ulima.unil.ch ([130.223.144.143]:31964 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S261302AbTAWTMa>;
	Thu, 23 Jan 2003 14:12:30 -0500
Date: Thu, 23 Jan 2003 20:21:40 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: Jens Axboe <axboe@suse.de>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, cdwrite@other.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: Can't burn DVD under 2.5.59 with ide-cd
Message-ID: <20030123192140.GD9141@ulima.unil.ch>
References: <200301231752.h0NHqOM5001079@burner.fokus.gmd.de> <20030123180124.GB9141@ulima.unil.ch> <20030123180653.GU910@suse.de> <20030123181002.GV910@suse.de> <20030123185554.GC9141@ulima.unil.ch> <20030123190711.GW910@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030123190711.GW910@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2003 at 08:07:11PM +0100, Jens Axboe wrote:

> just add a len=%d to the printk line, and failed->sense_len as the
> argument.

Does it show like this:

        if ((rq->flags & REQ_SENSE) && uptodate) {
                /*
                 * For REQ_SENSE, "rq->buffer" points to the original failed
                 * request
                 */
                struct request *failed = (struct request *) rq->buffer;
                struct cdrom_info *info = drive->driver_data;
                void *sense = &info->sense_data;

                if (failed && block_pc_request(failed))
                        printk("%s: failed %p len=%d  \n", __FUNCTION__, failed->sense,failed->sense_len);

                if (failed && failed->sense)
                        sense = failed->sense;

In that case, I got:

  	ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group  -o vmlinux
drivers/built-in.o(.text+0x5c563): In function `cdrom_end_request':
: undefined reference to `block_pc_request'
make: *** [vmlinux] Error 1

Sorry I certainly didn't understand you right...

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
