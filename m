Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268593AbRG3Nja>; Mon, 30 Jul 2001 09:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268590AbRG3NjU>; Mon, 30 Jul 2001 09:39:20 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:21265 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S268593AbRG3NjH>;
	Mon, 30 Jul 2001 09:39:07 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Olaf Hering <olh@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: new scsi hardware detection in 2.4.7(pre) 
In-Reply-To: Your message of "Mon, 30 Jul 2001 15:31:17 +0200."
             <20010730153117.A2142@suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 30 Jul 2001 23:39:10 +1000
Message-ID: <24749.996500350@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 30 Jul 2001 15:31:17 +0200, 
Olaf Hering <olh@suse.de> wrote:
>On Tue, Jul 24, Keith Owens wrote:
>
>> On Mon, 23 Jul 2001 17:10:19 +0200, 
>> Olaf Hering <olh@suse.de> wrote:
>> >I get this on non-scsi systems with scsi compiled into the kernel:
>> >
>> >SCSI subsystem driver Revision: 1.00
>> >request_module[scsi_hostadapter]: Root fs not mounted
>> >request_module[scsi_hostadapter]: Root fs not mounted
>> >request_module[scsi_hostadapter]: Root fs not mounted
>> 
>> The SCSI midlayer is trying to load the SCSI host adapter, that is an
>> unavoidable side effect of including SCSI support.  Because no adapter
>> is found, kmod tries to automatically load a module that can find a
>> host adapter.  The "Root fs not mounted" message occurs when you try to
>> load any module before / is mounted.
>
>Does that make any sense? I mean, there are some scsi drivers, none of
>them found a valid device, why do we look for more drivers? It would
>make sense if there are no low level device drivers in the kernel
>binary.

There is no way for the mid layer to distinguish between "no SCSI card
configured into kernel" and "SCSI card configured but failed to detect
hardware".  Even when there is a card built into the kernel, it still
makes sense to scan for modules if the initial card failed.  That gives
you fallback to modules when you change your hardware.

If you boot a SCSI kernel on a non-SCSI box then you should alias
scsi_hostadapter off.  You still get the 'Root fs not mounted' warning
messages, just ignore them.  If you are using one kernel build for lots
of different hardware you should be using initrd, then the root fs
messages go away as well.

