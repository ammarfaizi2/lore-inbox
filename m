Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265902AbRGCSzf>; Tue, 3 Jul 2001 14:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265894AbRGCSzZ>; Tue, 3 Jul 2001 14:55:25 -0400
Received: from hypnos.cps.intel.com ([192.198.165.17]:2268 "EHLO
	hypnos.cps.intel.com") by vger.kernel.org with ESMTP
	id <S265917AbRGCSzN>; Tue, 3 Jul 2001 14:55:13 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E89006CDDF2B@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Jeff Garzik'" <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "Acpi-linux (E-mail)" <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: RE: ACPI fundamental locking problems
Date: Tue, 3 Jul 2001 11:54:39 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jeff Garzik [mailto:jgarzik@mandrakesoft.com]
> events/evxface.c:610:acpi_acquire_global_lock ->
> events/evmisc.c:337:acpi_ev_acquire_global_lock ->
> include/platform/acgcc.h:52:ACPI_ACQUIRE_GLOBAL_LOCK
> 
> My immediate objections are,
> (a) acgcc.h is re-implementing spinlocks in a non-standard,
> non-portable, and expensive way, and (b) this entire code path is
> incredibly expensive.

Well, when I look at other Linux code, I assume that if it does something
weird, it does it for a reason.

That is the case here. The Global Lock is for synchronizing accesses between
the OS (that's us) and the firmware (SMI). Normal spinlocks are for intra-OS
locking. Here, we're synchronizing access with the BIOS. It's different.

All this code has been working for as long as I can remember.

You mention twice that it is "expensive". Keeping in mind the 80-20 rule, in
what way do you find this code costly?

> But my fundamental objection is,
> we are depending on vendors to get locking right in their 
> ACPI tables. 
> And assume by some magic or design that said locking works 
> with whatever
> unrelated kernel locking is going on.

By design, it works. We get to slipstream Windows a little here in that
vendors need to have a working Global Lock interface to pass WHQL.

> It is my initial belief that a smaller info query interface that can
> parse useful ACPI would be more effective.  For times like
> suspend/resume where we would want to execute control methods, well,
> there's always the disasm -> write-small-driver cycle.  Who knows if
> this is a realistics proposed solution.  But it really scares me to
> depend on vendors to get locking right.

We're depending on vendors (aka the BIOS) for all the ACPI tables, as well
as every other piece of a priori data we need to boot the OS.

Could I please ask that you at least show me a system where this is a
problem before throwing out all the work we've done on ACPI because of this
technical nit?

Thanks -- Regards -- Andy

