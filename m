Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265696AbRGCR4H>; Tue, 3 Jul 2001 13:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265701AbRGCRz6>; Tue, 3 Jul 2001 13:55:58 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:24491 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S265696AbRGCRzr>;
	Tue, 3 Jul 2001 13:55:47 -0400
Message-ID: <3B42071F.BD5C8A21@mandrakesoft.com>
Date: Tue, 03 Jul 2001 13:55:43 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "Grover, Andrew" <andrew.grover@intel.com>
Subject: ACPI fundamental locking problems
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I used to be pretty excited about ACPI, until today.

I was reading through the ACPI spec, to see what was required to obtain
the IRQ routing table from AML.  Continued reading... until I hit a
section talking about the ACPI global lock.

events/evxface.c:610:acpi_acquire_global_lock ->
events/evmisc.c:337:acpi_ev_acquire_global_lock ->
include/platform/acgcc.h:52:ACPI_ACQUIRE_GLOBAL_LOCK

My immediate objections are,
(a) acgcc.h is re-implementing spinlocks in a non-standard,
non-portable, and expensive way, and (b) this entire code path is
incredibly expensive.

But my fundamental objection is,
we are depending on vendors to get locking right in their ACPI tables. 
And assume by some magic or design that said locking works with whatever
unrelated kernel locking is going on.

It is my initial belief that a smaller info query interface that can
parse useful ACPI would be more effective.  For times like
suspend/resume where we would want to execute control methods, well,
there's always the disasm -> write-small-driver cycle.  Who knows if
this is a realistics proposed solution.  But it really scares me to
depend on vendors to get locking right.

We'll see what 2.5 will bring...

</soapbox>

-- 
Jeff Garzik      | "I respect faith, but doubt is
Building 1024    |  what gives you an education."
MandrakeSoft     |           -- Wilson Mizner
