Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262354AbSLFSzI>; Fri, 6 Dec 2002 13:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265513AbSLFSzH>; Fri, 6 Dec 2002 13:55:07 -0500
Received: from fmr01.intel.com ([192.55.52.18]:55535 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S262354AbSLFSzG>;
	Fri, 6 Dec 2002 13:55:06 -0500
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A57A@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: acpi-devel@sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: ACPI patches updated (20021205)
Date: Fri, 6 Dec 2002 11:02:27 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

New ACPI patches against 2.4.20 and 2.5.50 are now available at
http://sf.net/projects/acpi . Non-Linux releases will be available tonight,
from http://developer.intel.com/technology/iapc/acpi/downloads.htm .

Regards -- Andy

----------------------------------------
05 December 2002.  Summary of changes for version 20021205.

1) Linux

Fix check of schedule_work()'s return value (Ducrot Bruno)

Never return a value from the PCI device's Interrupt Line field if
it might be bogus -- return 0 instead.

Eliminate spurious unused variables warning w.r.t. ACPI_MODULE_NAME

2) ACPI CA Core Subsystem:

Fixed a problem where a store to a String or Buffer object
could cause corruption of the DSDT if the object type being
stored was the same as the target object type and the length
of the object being stored was equal to or smaller than the
original (existing) target object.  This was seen to cause
corruption of battery _BIF buffers if the _BIF method modified
the buffer on the fly.

Fixed a problem where an internal error was generated if a
control method invocation was used in an OperationRegion,
Buffer, or Package declaration.  This was caused by the
deferred parsing of the control method and thus the deferred
creation of the internal method object.  The solution to this
problem was to create the internal method object at the moment
the method is encountered in the first pass - so that
subsequent references to the method will able to obtain the
required parameter count and thus properly parse the method
invocation.  This problem presented itself as an
AE_AML_INTERNAL during the pass 1 parse phase during table
load.

Fixed a problem where the internal String object copy routine
did not always allocate sufficient memory for the target
String object and caused memory corruption.  This problem was
seen to cause "Allocation already present in list!" errors as
memory allocation became corrupted.

Implemented a new function for the evaluation of namespace
objects that allows the specification of the allowable return
object types.  This simplifies a lot of code that checks for a
return object of one or more specific objects returned from
the evaluation (such as _STA, etc.)  This may become and
external function if it would be useful to ACPI-related
drivers.

Completed another round of prefixing #defines with "ACPI_" for
clarity.

Completed additional code restructuring to allow more modular
linking for iASL compiler and AcpiExec.  Several files were
split creating new files.  New files:  nsparse.c dsinit.c
evgpe.c

Implemented an abort mechanism to terminate an executing
control method via the AML debugger.  This feature is useful
for debugging control methods that depend (wait) for specific
hardware responses.

-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover@intel.com

