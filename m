Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265180AbSKJVRR>; Sun, 10 Nov 2002 16:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265181AbSKJVRR>; Sun, 10 Nov 2002 16:17:17 -0500
Received: from zlatibor.yubc.net ([212.124.160.6]:65242 "EHLO
	zlatibor.yubc.net") by vger.kernel.org with ESMTP
	id <S265180AbSKJVRQ>; Sun, 10 Nov 2002 16:17:16 -0500
Message-Id: <200211102123.WAA08573@avala.yubc.net>
From: "Igor Levicki" <levicki@yubc.net>
To: "torvalds@transmeta.com" <torvalds@transmeta.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Sun, 10 Nov 2002 22:23:36 +0100
Reply-To: "Igor Levicki" <levicki@yubc.net>
X-Mailer: PMMail 2000 Professional (2.20.2660) For Windows 2000 (5.1.2600;1)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: Using %cr2 to reference "current"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

>I could well imagine a x86-compatible chip where %cr2 isn't even
>writable.  In fact, reading the intel documentation, I see _nowhere_ a
>mention of %cr2 being writable at all - it all just says "contains the
>fault address". 

>From Intel System Programmers Guide:

"The control registers can be read and loaded (or modified) using the
move-to-or-from-controlregisters
forms of the MOV instruction. In protected mode, the MOV instructions
allow the
control registers to be read or loaded (at privilege level 0 only).
This restriction means that application
programs or operating-system procedures (running at privilege levels 1,
2, or 3) are
prevented from reading or loading the control registers.
When loading the control register, reserved bits should always be set
to the values previously
read."

>(I don't know what the effect of the P4 half-cacheline
>thing is, I don't know if the CPU can have just a 64-byte block coherent,
>or what..

Cache sector size is 64 bytes on Pentium 4. When CPU reads from memory
it reads 2 sectors x 64 bytes = 128 byte cache line. Hardware
prefetcher fetches 2 x 128 byte cache line = 256 bytes of memory. On
write CPU writes 64 bytes always.
Now if you read 16 bytes from some address and then for example add
something to them and write them back to the same address you will have
a penalty when you read next 16 bytes from that address because you
have just trashed the 64 byte sector and you have to wait for
back-propagation.
Hope this helps.

Regards,
Igor Levicki
levicki@yubc.net


