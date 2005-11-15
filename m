Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932540AbVKOP3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbVKOP3g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 10:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbVKOP3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 10:29:36 -0500
Received: from fmr22.intel.com ([143.183.121.14]:3013 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S932540AbVKOP3f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 10:29:35 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: + perfmon2-reserve-system-calls.patch added to -mm tree
Date: Tue, 15 Nov 2005 07:28:35 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F04F630BF@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: + perfmon2-reserve-system-calls.patch added to -mm tree
Thread-Index: AcXp6iK3RuByl3gRT/aWyBxj8ddeKwADSL5g
From: "Luck, Tony" <tony.luck@intel.com>
To: "Andi Kleen" <ak@muc.de>, "Arjan van de Ven" <arjan@infradead.org>
Cc: <eranian@hpl.hp.com>, "Andrew Morton" <akpm@osdl.org>,
       "Arnd Bergmann" <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
       <benh@kernel.crashing.org>, <paulus@samba.org>,
       <stephane.eranian@hp.com>
X-OriginalArrivalTime: 15 Nov 2005 15:28:40.0483 (UTC) FILETIME=[417DF730:01C5E9F9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> ... which is a binary only, proprietary application.
>
>The IA32 emulation part of it is actually shipped in source. 
>Somehow they manage to link a binary only object to it though.

There are two parts to the ia32 emulation ... the part that handles
all the Linux syscall emulation is open (LGPL I think).  The part
that handles translation of x86 instructions into ia64 instructions
is the binary only part ... a shared library that gets attached by
the Linux layer ... this same binary blob is used on all operating
systems.

>> Either way, either the emulation is in the kernel or it's not. If it's
>> there (like it is now) it deserves maintenance. If it's not, it should
>> be removed from the tree, since the only thing it's otherwise good for
>> is potential security holes.
>
>I suppose it's still useful for all current IA64 users (Montecito
>is not shipping yet and older CPUs support x86 in hardware) who don't like 
>binary only software.

I was planning on asking who still depends on the emulation code
a while after Montecito is shipping.  Until then I'll try to do
what makes sense in keeping the ia32 emulation system call table
up to date.

The perfmon syscalls would be an example of something that should
*NOT* go into the ia32 emulation syscall table.  It makes no sense
whatever to put them there.  I don't believe that the h/w emulation
provides any performance counter emulation, and even if it did a
user who cared about the performance of their application would do
far better to re-compile it as native ia64 than to mess around
trying to optimize their x86 binary.

-Tony
