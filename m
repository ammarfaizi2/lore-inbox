Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262882AbTCKKHY>; Tue, 11 Mar 2003 05:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262888AbTCKKHY>; Tue, 11 Mar 2003 05:07:24 -0500
Received: from mail.econolodgetulsa.com ([198.78.66.163]:43794 "EHLO
	mail.econolodgetulsa.com") by vger.kernel.org with ESMTP
	id <S262882AbTCKKHX>; Tue, 11 Mar 2003 05:07:23 -0500
Date: Tue, 11 Mar 2003 02:18:02 -0800 (PST)
From: Josh Brooks <user@mail.econolodgetulsa.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: aacraid (dell PERC) cannot handle a degraded mirror
In-Reply-To: <1047342169.16969.47.camel@irongate.swansea.linux.org.uk>
Message-ID: <20030311021253.I5773-100000@mail.econolodgetulsa.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thank you for looking at this - I have seen this happen many times across
many machines, and it is always the disk that is bad.  Replace the disk,
and this stops happening - even though the firmware was not ever replaced.

Relevant details- (and these are interesting):

1. Controller BIOS: 2.7-0 (Build #3153)
2. using fujitsu drives
3. previously, these fujitsu drives, with older firmwares on the PERC
would confuse it so bad it would drop them off and do this same behavior -
now it only happens when a drive actually goes bad.

thanks!

On 11 Mar 2003, Alan Cox wrote:

> On Mon, 2003-03-10 at 07:44, Josh Brooks wrote:
> > 1. I start getting things like this in /var/log/messages
> >
> > Mar  9 07:12:36 system kernel: aacraid:ID(0:02:0); Error Event
> > [command:0x28]
> > Mar  9 07:12:36 system kernel: aacraid:ID(0:02:0); Medium Error, Block
> > Range 435200 : 435327
> > Mar  9 07:12:36 system kernel: aacraid:ID(0:02:0); Error Too Long To
> > Correct
> > Mar  9 07:12:36 system kernel: aacraid:ID(0:02:0) Medium Error, LBN Range
> > 435200:435327
> > Mar  9 07:12:36 system kernel: aacraid:ID(0:02:0) Starting BBR sequence
> >
>
> These come from the firmware
>
> > Mar  9 07:13:00 system kernel: scsi : aborting command due to timeout :
> > pid
> > 162469964, scsi0, channel 0, id 1, lun 0 Read (10) 00 00 06 a3 ff 00 00 08
> > 00
>
> We start to timeout because the firmware isnt responding
>
> > Mar  9 07:13:07 system kernel: aacraid:ID(0:02:0); Error Event
> > [command:0x28]
> > Mar  9 07:13:07 system kernel: aacraid:ID(0:02:0); Medium Error, Block
> > Range 435234 : 435234
> > Mar  9 07:13:07 system kernel: aacraid:ID(0:02:0); Error Too Long To
> > Correct
>
> Firmware finally gives up
>
> >
> > 3. disk 2 on channel 0 fails.  No problem, it's a mirror, right ?
>
> > Mar  9 07:13:36 system kernel: aacraid:  BBR timed out at Block 0x6a42d
> > Mar  9 07:13:36 system kernel: aacraid:Drive 0:2:0 returning error
> > Mar  9 07:13:36 system kernel: aacraid:ID(0:02:0) - IO failed, Cmd[0x28]
>
> Drive firmware fails the I/O
>
> > So, why does the system run fine on the broken mirror, but panics and
> > crashes when the mirror actually breaks ?
> >
> > This is very frustrating - one of the reasons we spent money to mirror
> > things was to reduce possible downtimes (since a disk failure will not
> > crash the machine) but ... a disk failure does crash the machine.
> > Explanations welcome.
>
> Looking at the trace the driver was thrown by something. I think I know
> what may have occurred in your case but not in the test/qualification
> sets. Somehow the firmware spent so long we aborted/gave up and killed
> of a command - then it completed and we tried to sell the scsi layer.
>
> It'll be a while before I can validate that, you might also want to
> report it to aacraid@adapter.com (I think - see MAINTAINERS file for
> the kernel)
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

