Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVC0WRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVC0WRr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 17:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVC0WRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 17:17:47 -0500
Received: from kishna.firstlight.net ([63.80.208.5]:53900 "EHLO
	kishna.firstlight.net") by vger.kernel.org with ESMTP
	id S261603AbVC0WRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 17:17:40 -0500
Date: Sun, 27 Mar 2005 14:17:38 -0800 (PST)
From: Neil Whelchel <koyama@firstlight.net>
To: quasiben <quasiben@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: SATA Promise TX4 Crash
In-Reply-To: <1111898649.185617.170980@g14g2000cwa.googlegroups.com>
Message-ID: <Pine.LNX.4.44.0503271409430.11318-100000@kishna.firstlight.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Mar 2005, quasiben wrote:

> Dear Neil Whelchel,
>      I have been having very similar problems.  However, my setup is
> somewhat different.  I have a LVM logical volume that spans two disks
> (one PATA and one SATA).  Did you upgrade your PSU as one person
> suggested ? If so, did it work ?
>
> --Benji
>
> Neil Whelchel wrote:
> > Hello,
> > I have two Promise SATA TX4 cards connected to a total of 6 Maxtor
> 250 GB
> > drives (7Y250M0) configured into a RAID 5. All works well with small
> > disk load, but when a large number of requests are issued, it causes
> crash
> > similar to the attached, except that the errors before the crash are
> on a
> > different drive nearly every time. I have tried several different
> > motherboards with both Nvidia and Via chipsets, with Athlon and K6
> > CPUs, and the crash remains the same. I have also seen the same crash
> > with both a preemptable and a non-preemptable kernel, with kernel
> > versions 2.6.9, 2.6.10, 2.6.11, and 2.6.11.2 (this one).
> > Any suggestions, or is this a bug?
> >
> >
> > ata3: status=0x51 { DriveReady SeekComplete Error }
> > ata3: error=0x40 { UncorrectableError }
> > ata3: status=0x51 { DriveReady SeekComplete Error }
> > ata3: error=0x40 { UncorrectableError }
> > ata3: status=0x51 { DriveReady SeekComplete Error }
> > ata3: error=0x40 { UncorrectableError }
> > ata3: status=0x51 { DriveReady SeekComplete Error }
> > ata3: error=0x40 { UncorrectableError }
> > ata3: status=0x51 { DriveReady SeekComplete Error }
> > ata3: error=0x40 { UncorrectableError }
> > ata3: command timeout
> > Assertion failed! qc->flags &
> >
> ATA_QCFLAG_ACTIVE,drivers/scsi/libata-core.c,ata_qc_complete,line=2807
> > ata3: status=0x51 { DriveReady SeekComplete Error }
> > ata3: called with no error (51)!
> > ------------[ cut here ]------------
> > kernel BUG at drivers/scsi/scsi.c:299!
> > invalid operand: 0000 [#1]
> > PREEMPT
> > Modules linked in:
> > CPU:    0
> > EIP:    0060:[<c02a9ddb>]    Not tainted VLI
> > EFLAGS: 00010046   (2.6.11.2)
> > EIP is at scsi_put_command+0xbb/0x100
> > eax: 00000001   ebx: c2f5e390   ecx: 00000001   edx: c2f5e390
> > esi: c2f5e380   edi: 00000246   ebp: c7c4beb4   esp: c7c4be9c
> > ds: 007b   es: 007b   ss: 0068
> > Process scsi_eh_2 (pid: 821, threadinfo=c7c4a000 task=c7c315b0)
> > Stack: 00000296 c7c30000 c7c26400 c7c23030 c2f5e380 00000246 c7c4bec4
> c02ae9b3
> >        c2f5e380 c44a1740 c7c4bee0 c02aeabc c2f5e380 c7c23030 c2f5e380
> 08000002
> >        c44a1740 c7c4bf28 c02aedd2 c2f5e380 00000001 00000000 00000000
> 00000000
> > Call Trace:
> >  [<c0102c12>] show_stack+0x72/0xa0
> >  [<c0102d64>] show_registers+0x104/0x180
> >  [<c0102f53>] die+0xd3/0x180
> >  [<c0103330>] do_invalid_op+0x90/0xa0
> >  [<c010282b>] error_code+0x2b/0x30
> >  [<c02ae9b3>] scsi_next_command+0x13/0x20
> >  [<c02aeabc>] scsi_end_request+0xbc/0xe0
> >  [<c02aedd2>] scsi_io_completion+0x132/0x3c0
> >  [<c02ba698>] sd_rw_intr+0xb8/0x2c0
> >  [<c02b8420>] ata_scsi_qc_complete+0x20/0x40
> >  [<c02b658c>] ata_qc_complete+0x2c/0xa0
> >  [<c02b9473>] pdc_eng_timeout+0x93/0x120
> >  [<c02b7ef4>] ata_scsi_error+0x14/0x40
> >  [<c02add5b>] scsi_error_handler+0x5b/0xc0
> >  [<c0100811>] kernel_thread_helper+0x5/0x14
> > Code: ec 8b 42 08 ff 30 e8 e5 cd e8 ff 59 5b 8b 45 f0 05 84 01 00 00
> 89 45
> > 08 8d 65 f4 5b 5e 5f c9 e9 ac 41 fc ff e8 47 6c 13 00 eb ce <0f> 0b
> 2b 01
> > d6 e8 40 c0 e9 6c ff ff ff e8 33 6c 13 00 eb 8b 89
> >  <6>note: scsi_eh_2[821] exited with preempt_count 1
> >
> >
> > -Neil Whelchel-
> > First Light Internet Services
> > 760 366-0145
> > - We don't do Window$, that's what the janitor is for -
> >
> > Bubble Memory, n.:
> >         A derogatory term, usually referring to a person's
> > intelligence.  See also "vacuum tube".
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>
Hello,
Yes, I did replace the PSU about 6 times. I had the same problem with 4
similar machines (all the same), and in one of them I tried two
other different power supplies, so there were a total of three completely
different supplies tested. All of them were 450 Watts, except for one 500
Watt that I tested..
While, my 'feelings' tell me that the PSU is the issue, I have been
looking more to grounding and SATA cable than anything else. But there is
one HUGE however here... If there is a communication failure, it should
not cause a crash in the kernel, this should be fixed!

-Neil Whelchel-
First Light Internet Services
760 366-0145
- We don't do Window$, that's what the janitor is for -

Bubble Memory, n.:
        A derogatory term, usually referring to a person's
intelligence.  See also "vacuum tube".

