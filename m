Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbVDEOL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbVDEOL0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 10:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbVDEOL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 10:11:26 -0400
Received: from alog0440.analogic.com ([208.224.222.216]:38889 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261732AbVDEOLM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 10:11:12 -0400
Date: Tue, 5 Apr 2005 10:10:37 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Julien Wajsberg <julien.wajsberg@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: How's the nforce4 support in Linux?
In-Reply-To: <2a0fbc5905040506422fbf6356@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0504050957400.15886@chaos.analogic.com>
References: <2a0fbc59050325145935a05521@mail.gmail.com>
 <2a0fbc5905040506422fbf6356@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2005, Julien Wajsberg wrote:

> On Mar 26, 2005 12:59 AM, Julien Wajsberg <julien.wajsberg@gmail.com> wrote:
>> I own an Asus A8N-Sli motherboard with the Nforce4-Sli chipset, and I
>> experiment the following problem :
>>
>> Mar 25 22:42:55 evenflow kernel: hda: dma_timer_expiry: dma status == 0x60
>> Mar 25 22:42:55 evenflow kernel: hda: DMA timeout retry
>> Mar 25 22:42:55 evenflow kernel: hda: timeout waiting for DMA
>> Mar 25 22:42:55 evenflow kernel: hda: status error: status=0x58 {
>> DriveReady SeekComplete DataRequest }
>> Mar 25 22:42:55 evenflow kernel:
>> Mar 25 22:42:55 evenflow kernel: ide: failed opcode was: unknown
>> Mar 25 22:42:55 evenflow kernel: hda: drive not ready for command
>> Mar 25 22:42:55 evenflow kernel: hda: status timeout: status=0xd0 { Busy }
>> Mar 25 22:42:55 evenflow kernel:
>> Mar 25 22:42:55 evenflow kernel: ide: failed opcode was: unknown
>> Mar 25 22:42:55 evenflow kernel: hdb: DMA disabled
                                      ^^^^^^^^^^^^^^^^^
>> Mar 25 22:42:55 evenflow kernel: hda: drive not ready for command
>>
>> Of course, if I disable DMA with hdparm, this problem disappear.. but
>> it isn't a long-term solution ;-)
>>

The long-term solution is to replace either the drive, cable, or the
motherboard that can't do DMA. A bad DMA operation can write data
anywhere (right into the middle of the kernel). There isn't
anything software can do about it. Software sets up the
controller for a DMA operation, then waits for an interrupt
that tells it has completed or failed. Software can retry failed
operations until software gets destroyed by the hardware, but
there isn't anything else that can be done.

The fact that disabling DMA makes the problem(s) go away is
proof that it isn't a software problem. There are flash-RAM
devices that emulate IDE drives. Most of these can't do DMA
and the IDE driver doesn't accept that fact. That is a known
bug. One needs to use hdparm to tell it to stop trying to
use DMA. In your case, the driver stopped using DMA when
it found out that it didn't work. There is no bug.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
