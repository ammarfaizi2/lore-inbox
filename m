Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbVIIMcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbVIIMcR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 08:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbVIIMcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 08:32:17 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:23567 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751384AbVIIMcR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 08:32:17 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20050909132725.C23462@pixie.comlab>
References: <20050909132725.C23462@pixie.comlab>
X-OriginalArrivalTime: 09 Sep 2005 12:32:15.0610 (UTC) FILETIME=[82BD45A0:01C5B53A]
Content-class: urn:content-classes:message
Subject: Re: 2.6.13: loop ioctl crashes
Date: Fri, 9 Sep 2005 08:32:10 -0400
Message-ID: <Pine.LNX.4.61.0509090829260.8368@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.13: loop ioctl crashes
Thread-Index: AcW1OoLEWatBqdWJTlGpoxWH0oyS6g==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Ian Collier" <Ian.Collier@comlab.ox.ac.uk>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 9 Sep 2005, Ian Collier wrote:

> I'm trying out PPDD from https://retiisi.dyndns.org/~sailus/ppdd/
> because I have some old stuff in that format.  However, the crash
> seems to occur in code that isn't touched by the PPDD patch.  It
> happens while I'm trying to set up the loop device - I haven't got
> as far as actually using it yet.
>
> If I'm lucky then when I issue the losetup command and successfully
> type in the passphrase then losetup says something of the form
> ioctl: LOOP_SET_STATUS: Bad address
> and the kernel says:
>
> Debug: sleeping function called from invalid context at arch/i386/lib/usercopy.c:634
> in_atomic():1, irqs_disabled():0
>  [<c011f8eb>] __might_sleep+0xab/0xc0
>  [<c0211aa3>] copy_from_user+0x23/0x90
>  [<d0a9fe80>] loop_set_status_old+0x30/0x70 [loop]
>
> However, it often seems to panic in a variety of horrible ways while
> trying to print the above message.
>
> Clearly I have CONFIG_DEBUG_SPINLOCK_SLEEP set (as my config is
> based on Fedora's), and I suppose I could just try unsetting it to
> make the message go away.  That wouldn't make the underlying bug go
> away, though.  If it makes any difference, loop and all the crypto
> algorithms are compiled as modules.
>
> I don't understand why it's an invalid context.  I also don't understand
> why the traceback stops at loop_set_status_old given that it must have
> been called from lo_ioctl.  (But maybe the answer to the latter would
> explain the former.)
>
> I may try just moving the copy_from_user() out to the beginning of
> lo_ioctl and see what happens.  Any other suggestions?  In case it's
> not obvious by now, I'm not really a kernel hacker.
>
> imc

I guess you are trying to do a copy_from_user() with a spin-lock
being held or the interrupts otherwise disabled. You can hold
a semaphore, to prevent somebody else from interfering with
you, but you cannot hold a spin-lock during copy/to/from/user().


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
