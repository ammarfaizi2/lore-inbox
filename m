Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264950AbSKSCER>; Mon, 18 Nov 2002 21:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265008AbSKSCER>; Mon, 18 Nov 2002 21:04:17 -0500
Received: from momus.sc.intel.com ([143.183.152.8]:28622 "EHLO
	momus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S264950AbSKSCEQ>; Mon, 18 Nov 2002 21:04:16 -0500
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A51C@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: acpi-devel@sourceforge.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: ACPI patches updated (20021115)
Date: Mon, 18 Nov 2002 18:09:16 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Linux patches are now available at http://sf.net/projects/acpi.
Non-Linux-specific patches should be available by tomorrow night at
http://developer.intel.com/technology/iapc/acpi/downloads.htm . For real
this time. ;-)

Regards -- Andy

----------------------------------------
15 November 2002.  Summary of changes for version 20021115.

1) Linux

Changed the implementation of the ACPI semaphores to use
down() instead of down_interruptible().  It is important that
the execution of ACPI control methods not be interrupted by
signals.  Methods must run to completion, or the system may be
left in an unknown/unstable state.

Fixed a compilation error when CONFIG_SOFTWARE_SUSPEND is not
set. (Shawn Starr)

2) ACPI CA Core Subsystem:

Fixed a memory leak problem where an error during resolution
of method arguments during a method invocation from another
method failed to cleanup properly by deleting all successfully
resolved argument objects.

Fixed a problem where the target of the Index() operator was
not correctly constructed if the source object was a package.
This problem has not been detected because the use of a target
operand with Index() is very rare.

Fixed a problem with the Index() operator where an attempt was
made to delete the operand objects twice.

Fixed a problem where an attempt was made to delete an operand
twice during execution of the CondRefOf() operator if the
target did not exist.

Implemented the first of perhaps several internal create
object functions that create and initialize a specific object
type.  This consolidates duplicated code wherever the object
is created, thus shrinking the size of the subsystem.

Implemented improved debug/error messages for errors that
occur during nested method invocations.  All executing method
pathnames are displayed (with the error) as the call stack is
unwound - thus simplifying debug.

Fixed a problem introduced in the 10/02 release that caused
premature deletion of a buffer object if a buffer was used as
an ASL operand where an integer operand is required (Thus
causing an implicit object conversion from Buffer to Integer.)
The change in the 10/02 release was attempting to fix a memory
leak (albeit incorrectly.)

3) iASL Compiler/Disassembler

Changed the default location of output files.  All output
files are now placed in the current directory by default
instead of in the directory of the source file.  This change
may affect some existing makefiles, but it brings the behavior
of the compiler in line with other similar tools.  The
location of the output files can be overridden with the -p
command line switch.

