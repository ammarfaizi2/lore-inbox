Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261658AbTCJXFz>; Mon, 10 Mar 2003 18:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261660AbTCJXFy>; Mon, 10 Mar 2003 18:05:54 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:47033
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261658AbTCJXFq>; Mon, 10 Mar 2003 18:05:46 -0500
Subject: Re: aacraid (dell PERC) cannot handle a degraded mirror
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Josh Brooks <user@mail.econolodgetulsa.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030309233257.O74417-100000@mail.econolodgetulsa.com>
References: <20030309233257.O74417-100000@mail.econolodgetulsa.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047342169.16969.47.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 11 Mar 2003 00:22:54 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-10 at 07:44, Josh Brooks wrote:
> 1. I start getting things like this in /var/log/messages
> 
> Mar  9 07:12:36 system kernel: aacraid:ID(0:02:0); Error Event
> [command:0x28]
> Mar  9 07:12:36 system kernel: aacraid:ID(0:02:0); Medium Error, Block
> Range 435200 : 435327
> Mar  9 07:12:36 system kernel: aacraid:ID(0:02:0); Error Too Long To
> Correct
> Mar  9 07:12:36 system kernel: aacraid:ID(0:02:0) Medium Error, LBN Range
> 435200:435327
> Mar  9 07:12:36 system kernel: aacraid:ID(0:02:0) Starting BBR sequence
> 

These come from the firmware

> Mar  9 07:13:00 system kernel: scsi : aborting command due to timeout :
> pid
> 162469964, scsi0, channel 0, id 1, lun 0 Read (10) 00 00 06 a3 ff 00 00 08
> 00

We start to timeout because the firmware isnt responding

> Mar  9 07:13:07 system kernel: aacraid:ID(0:02:0); Error Event
> [command:0x28]
> Mar  9 07:13:07 system kernel: aacraid:ID(0:02:0); Medium Error, Block
> Range 435234 : 435234
> Mar  9 07:13:07 system kernel: aacraid:ID(0:02:0); Error Too Long To
> Correct

Firmware finally gives up

> 
> 3. disk 2 on channel 0 fails.  No problem, it's a mirror, right ?

> Mar  9 07:13:36 system kernel: aacraid:  BBR timed out at Block 0x6a42d
> Mar  9 07:13:36 system kernel: aacraid:Drive 0:2:0 returning error
> Mar  9 07:13:36 system kernel: aacraid:ID(0:02:0) - IO failed, Cmd[0x28]

Drive firmware fails the I/O

> So, why does the system run fine on the broken mirror, but panics and
> crashes when the mirror actually breaks ?
> 
> This is very frustrating - one of the reasons we spent money to mirror
> things was to reduce possible downtimes (since a disk failure will not
> crash the machine) but ... a disk failure does crash the machine.
> Explanations welcome.

Looking at the trace the driver was thrown by something. I think I know
what may have occurred in your case but not in the test/qualification
sets. Somehow the firmware spent so long we aborted/gave up and killed 
of a command - then it completed and we tried to sell the scsi layer.

It'll be a while before I can validate that, you might also want to 
report it to aacraid@adapter.com (I think - see MAINTAINERS file for
the kernel)


