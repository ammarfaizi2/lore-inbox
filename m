Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268430AbTBNOok>; Fri, 14 Feb 2003 09:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268431AbTBNOok>; Fri, 14 Feb 2003 09:44:40 -0500
Received: from ip252-142.choiceonecom.com ([216.47.252.142]:13065 "EHLO
	explorer.reliacomp.net") by vger.kernel.org with ESMTP
	id <S268430AbTBNOoh>; Fri, 14 Feb 2003 09:44:37 -0500
Message-ID: <3E4D0029.5090005@cendatsys.com>
Date: Fri, 14 Feb 2003 08:41:45 -0600
From: Edward King <edk@cendatsys.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre4: PDC ide driver problems with shared interrupts
References: <7b263321.0302140626.2ddb7980@posting.google.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 2003-02-06 at 13:20, Stephan von Krawczynski wrote:
> > On 05 Feb 2003 18:12:31 +0100
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > 
> > 
> > > Stephan: Can you try editing ide-dma.c, function
> > > __ide_dma_test_irq(), and remove that line:
> > > 
> > > -	drive->waiting_for_dma++;
> > > 
> > > And tell us if it helps in any way.
> > > 
> > > Ben.
> > 
> > Hello Ben,
> > 
> > as requested I tried the above "patch" and had no problem so far. Current
> > situation is:
> > (ide2, ide3 are PDC, eth2 is tg3)
> 
> Ok, well, if it' still stable by now, I beleive we can safely remove
> that line from ide_dma_test_irq(). AFAIK, it really have nothing to do
> here.

Just wanted to jump in here -- I'm setting up a box using two PDC20268
controllers for a 4 drive software raid.  The system locks on heavy
disk activity only if dma is active.

I was watching this thread and put in the patch to remove the
"drive->waiting_for_dma++;" line.  I still get lockups and the message
on the console is:

hdg: dma_timer_expiry: dma status == 0x21
hde: dma_timer_expiry: dma status == 0x21
hdg: timeout waiting for DMA
PDC202XX: Secondary channel reset
hdg: timeout waiting for DMA
hdg: (__ide_dma_test_irq) called while not waiting
hdg: status error: status = 0x58 { DriveReady SeekComplete DataRequest
}
hdg: drive not ready for command
hde: timeout waiting for DMA
PDC202XX: Primary channel reset
hde: timeout waiting for DMA
hde: (__ide_dma_test_irq) called while not waiting

I copied these -- everything with with dma disabled.  I beleive this
is the same problem, and can reproduce it (this occurred deleting a
400MB file on a reiserfs.)

The kernel is 2.4.21-pre4
The chipset is nVidia
The controllers each have their own interrupt (not shared)

I have used PDC controllers for raids in the past, but only one PDC
and the other drives used the onboard ide -- this works fine.

Regards,

edk@cendatsys.com



