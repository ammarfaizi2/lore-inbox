Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbTELUeo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 16:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbTELUen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 16:34:43 -0400
Received: from fmr04.intel.com ([143.183.121.6]:13506 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S261808AbTELUek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 16:34:40 -0400
Message-ID: <F760B14C9561B941B89469F59BA3A847E96E70@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: acpi-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: ACPI source releases updated (20030509)
Date: Mon, 12 May 2003 13:47:14 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all. Updated Linux patches are available at
http://sf.net/projects/acpi . Non-Linux releases will be available at
http://developer.intel.com/technology/iapc/acpi/downloads.htm soon.

Regards -- Andy

----------------------------
09 May 2003.  Summary of changes for version 20030509.


1) Linux:

Allow ":" in OS override string (Ducrot Bruno)

Kobject fix (Greg KH)

2) ACPI CA Core Subsystem:

Changed the subsystem initialization sequence to hold off installation
of address space handlers until the hardware has been initialized and
the system has entered ACPI mode.  This is because the installation of
space handlers can cause _REG methods to be run.  Previously, the _REG
methods could potentially be run before ACPI mode was enabled.

Fixed some memory leak issues related to address space handler and
notify handler installation.  There were some problems with the
reference count mechanism caused by the fact that the handler objects
are shared across several namespace objects.

Fixed a reported problem where reference counts within the namespace
were not properly updated when named objects created by method execution
were deleted.

Fixed a reported problem where multiple SSDTs caused a deletion issue
during subsystem termination.  Restructured the table data structures to
simplify the linked lists and the related code.

Fixed a problem where the table ID associated with secondary tables
(SSDTs) was not being propagated into the namespace objects created by
those tables.  This would only present a problem for tables that are
unloaded at run-time, however.

Updated AcpiOsReadable and AcpiOsWritable to use the ACPI_SIZE type as
the length parameter (instead of UINT32).

Solved a long-standing problem where an ALREADY_EXISTS error appears on
various systems.  This problem could happen when there are multiple
PCI_Config operation regions under a single PCI root bus.  This doesn't
happen very frequently, but there are some systems that do this in the
ASL.

Fixed a reported problem where the internal DeleteNode function was
incorrectly handling the case where a namespace node was the first in
the parent's child list, and had additional peers (not the only child,
but first in the list of children.)

3 iASL Compiler/Disassembler:

Fixed a problem in the generation of the C source code files (AML is
emitted in C source statements for BIOS inclusion) where the Ascii dump
that appears within a C comment at the end of each line could cause a
compile time error if the AML sequence happens to have an open comment
or close comment sequence embedded.



-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover@intel.com

