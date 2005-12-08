Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbVLHQRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbVLHQRk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 11:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbVLHQRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 11:17:40 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:27148 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932193AbVLHQRj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 11:17:39 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <1134058209.24458.10.camel@noti>
X-OriginalArrivalTime: 08 Dec 2005 16:17:37.0837 (UTC) FILETIME=[E7CADDD0:01C5FC12]
Content-class: urn:content-classes:message
Subject: Re: Problem with using spinlocks when kernel is compiled withoutsmp-support
Date: Thu, 8 Dec 2005 11:17:37 -0500
Message-ID: <Pine.LNX.4.61.0512081114380.14141@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problem with using spinlocks when kernel is compiled withoutsmp-support
Thread-Index: AcX8EufS3hlLc4ISRtWUDyTwNoFYjA==
References: <1134058209.24458.10.camel@noti>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Dirk Henning Gerdes" <mail@dirk-gerdes.de>
Cc: "Andrew Morton" <akpm@osdl.org>, "LKML" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 Dec 2005, Dirk Henning Gerdes wrote:

> Hello Andrew!
>
> I have the following problem on 2.6.15-rc5-mm1
>
> When compiling a module using spinlocks I get the following
> error-message, when SMP is disabled in my Kernel-config:
>
>
>
>
> In file included from /home/dirk/Masterarbeit/mynoop/test/mynoop.c:7:
> include/asm/spinlock.h:21:1: warning: "__raw_spin_is_locked" redefined
> In file included from include/linux/spinlock.h:90,
>                 from include/linux/kobject.h:23,
>                 from include/linux/device.h:16,
>                 from include/linux/genhd.h:15,
>                 from include/linux/blkdev.h:6,
>                 from /home/dirk/Masterarbeit/mynoop/test/mynoop.c:1:
> include/linux/spinlock_up.h:61:1: warning: this is the location of the
> previous definition
> In file included from /home/dirk/Masterarbeit/mynoop/test/mynoop.c:7:
> include/asm/spinlock.h:51: error: syntax error before 'do'
> include/asm/spinlock.h: In function '__raw_spin_lock_flags':
> include/asm/spinlock.h:62: error: 'struct <anonymous>' has no member
> named 'slock'
> include/asm/spinlock.h:60: error: invalid lvalue in asm output 0
> include/asm/spinlock.h: At top level:
> include/asm/spinlock.h:65: error: syntax error before '{' token
> include/asm/spinlock.h:89: error: syntax error before 'do'
> In file included from /home/dirk/Masterarbeit/mynoop/test/mynoop.c:7:
> include/asm/spinlock.h:114:1: warning: "__raw_spin_unlock_wait"
> redefined
> In file included from include/linux/spinlock.h:90,
>                 from include/linux/kobject.h:23,
>                 from include/linux/device.h:16,
>                 from include/linux/genhd.h:15,
>                 from include/linux/blkdev.h:6,
>                 from /home/dirk/Masterarbeit/mynoop/test/mynoop.c:1:
> include/linux/spinlock_up.h:71:1: warning: this is the location of the
> previous definition
> In file included from /home/dirk/Masterarbeit/mynoop/test/mynoop.c:7:
> include/asm/spinlock.h:142:1: warning: "__raw_read_can_lock" redefined
> In file included from include/linux/spinlock.h:90,
>                 from include/linux/kobject.h:23,
>                 from include/linux/device.h:16,
>                 from include/linux/genhd.h:15,
>                 from include/linux/blkdev.h:6,
>                 from /home/dirk/Masterarbeit/mynoop/test/mynoop.c:1:
> include/linux/spinlock_up.h:68:1: warning: this is the location of the
> previous definition
> In file included from /home/dirk/Masterarbeit/mynoop/test/mynoop.c:7:
> include/asm/spinlock.h:148:1: warning: "__raw_write_can_lock" redefined
> In file included from include/linux/spinlock.h:90,
>                 from include/linux/kobject.h:23,
>                 from include/linux/device.h:16,
>                 from include/linux/genhd.h:15,
>                 from include/linux/blkdev.h:6,
>                 from /home/dirk/Masterarbeit/mynoop/test/mynoop.c:1:
> include/linux/spinlock_up.h:69:1: warning: this is the location of the
> previous definition
> include/asm/spinlock.h: In function '__raw_read_unlock':
> include/asm/spinlock.h:181: error: 'struct <anonymous>' has no member
> named 'lock'
> include/asm/spinlock.h:181: error: invalid lvalue in asm output 0
> include/asm/spinlock.h: In function '__raw_write_unlock':
> include/asm/spinlock.h:187: error: 'struct <anonymous>' has no member
> named 'lock'
> include/asm/spinlock.h:186: error: invalid lvalue in asm output 0
>
>
>
> shouldn't it be possible to use spinlocks in my code even if I don't
> support SMP for compatiblity ?
>
>
> Dirk

Yes. And it used to be true. Certainly one should never use
cli() and sti() so all you have to protect critical sections
from interrupts are spin-locks. This has been broken for some
time so, I suggest you just enable SMP in your .config and
live with it for the time being.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
