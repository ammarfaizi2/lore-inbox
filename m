Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWBMQ2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWBMQ2H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 11:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWBMQ2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 11:28:06 -0500
Received: from mail.gmx.de ([213.165.64.21]:9605 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750808AbWBMQ2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 11:28:05 -0500
X-Authenticated: #428038
Date: Mon, 13 Feb 2006 17:28:01 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: "logical unit communication failure" c2scan NEC ND-4550A 1.07
Message-ID: <20060213162801.GC15889@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <m3bqxhtmkq.fsf@merlin.emma.line.org> <43EB1F64.nail7GZ11H1SY@burner> <m3psltbumj.fsf@merlin.emma.line.org> <43EE6FF6.nailKBD11GI1Z@burner> <43F00EEA.6070509@tmr.com> <43F09AB1.nailKUSM1KY4M@burner> <20060213150112.GC14544@merlin.emma.line.org> <43F0A8CE.nailKUS1410VN7@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F0A8CE.nailKUS1410VN7@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-02-13:

> Matthias Andree <matthias.andree@gmx.de> wrote:
> 
> > Joerg Schilling schrieb am 2006-02-13:
> >
> > > Filtering SCSI commands was an unannounced change of the interface
> > > that needs to be called a bug. I still do not see any fix for this.

You don't need a fix for the status quo, as shown before and below.

> > SCSI commands are not filtered for processes with RAWIO capability,
> > which root processes have by default.
> 
> It seems that you did loose contact to reality :-(

Have you ever read /usr/src/linux/block/scsi_ioctl.c?

You should pay particular attention to the verify_command() function.

Quoting Linux 2.6.15.4 (you won't understand this, but that doesn't
matter, the rest of the world knows I can prove my point, unlike you):

        /* And root can do any command.. */
        if (capable(CAP_SYS_RAWIO))
                return 0;

        if (!type) {
                cmd_type[cmd[0]] = CMD_WARNED;
                printk(KERN_WARNING "scsi: unknown opcode 0x%02x\n", cmd[0]);
        }

        /* Otherwise fail it with an "Operation not permitted" */
        return -EPERM;

This is taken from block/scsi_ioctl.c's verify_command(), ll. 204ff.

> Try to inform yourself about the problems or stay quiet.

Yeah right, I'll shut up because some guy with scruffy manners comes
along and tells everybody they were stupid. Dream on.

> > The recommended installation on Linux is still setuid, so any claims
> > cdrecord were affected are hypocritical.
> 
> Wrong again, check the recent workarounds in libscg/cdrecord to
> understand that the problem was not fixed in the Linux kernel but
> I introduced a workaround.

Which function should I look at?

> > Plus, you have been offered by Linux developers to send a list of
> > commands that need to be allowed, you have not accepted that offer.
> 
> Are you really so ignorant?
> 
> I did tell people how to extract such a list _and_ I told them
> that such a list is subject to daily changes in case a new drive needs 
> new SCSI commands.

You want them to do you a favor, so you get to show them the list they
asked for. If you don't, you aren't getting anything. You can stomp your
foot on the ground, cry out loud, shout your frustration from the
rooftops, it isn't going to change the kernel, you know.

-- 
Matthias Andree
