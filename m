Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262222AbVBQFvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbVBQFvI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 00:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbVBQFvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 00:51:08 -0500
Received: from fmr15.intel.com ([192.55.52.69]:2477 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S262222AbVBQFuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 00:50:52 -0500
Subject: [BKPATCH] ACPI for 2.6.11
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Content-Type: text/plain
Organization: 
Message-Id: <1108619425.2096.397.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 17 Feb 2005 00:50:37 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please do a 

	bk pull bk://linux-acpi.bkbits.net/to-linus

	This fixes two regressions in 2.6.11 vs 2.6.10
	in the ACPI interpreter.

thanks,
-Len

ps. a plain patch is also available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.11/acpi-20050211-2.6.11-rc4.diff.gz

This will update the following files:

 drivers/acpi/dispatcher/dswexec.c |    7 +
 drivers/acpi/executer/exoparg6.c  |  133 +++++++++++++++++---------
 drivers/acpi/executer/exresop.c   |    2 
 drivers/acpi/executer/exstoren.c  |   20 ++-
 drivers/acpi/executer/exstorob.c  |   12 +-
 drivers/acpi/namespace/nsxfname.c |   51 +++++----
 drivers/acpi/parser/psopcode.c    |    2 
 drivers/acpi/tables/tbconvrt.c    |    4 
 include/acpi/acconfig.h           |    2 
 include/acpi/acinterp.h           |    5 
 include/acpi/platform/aclinux.h   |    2 
 11 files changed, 159 insertions(+), 81 deletions(-)

through these ChangeSets:

<len.brown@intel.com> (05/02/15 1.1938.498.13)
   [ACPI] ACPICA 20050211 from Bob Moore
   
   Implemented ACPI 3.0 support for implicit conversion within
   the Match() operator. match_obj can now be of type
   integer, buffer, or string instead of just type integer.
   Package elements are implicitly converted to the type
   of the match_obj. This change aligns the behavior of
   Match() with the behavior of the other logical operators
   (LLess(), etc.)  It also requires an errata change to the
   ACPI specification as this support was intended for ACPI
   3.0, but was inadvertently omitted.
   
   Fixed a problem with the internal implicit "to buffer"
   conversion.  Strings that are converted to buffers will
   cause buffer truncation if the string is smaller than the
   target buffer. Integers that are converted to buffers will
   not cause buffer truncation, only zero extension (both as
   per the ACPI spec.) The problem was introduced when code
   was added to truncate the buffer, but this should not be
   performed in all cases, only the string case.
   
   Fixed a problem with the Buffer and Package operators
   where the interpreter would get confused if two such
   operators were used as operands to an ASL operator (such
   as LLess(Buffer(1){0},Buffer(1){1}).  The internal result
   stack was not being popped after the execution of these
   operators, resulting in an AE_NO_RETURN_VALUE exception.
   
   Fixed a problem with constructs of the form
   Store(Index(...),...). The reference object returned from
   Index was inadvertently resolved to an actual value. This
   problem was introduced in version 20050114 when the
   behavior of Store() was modified to restrict the object
   types that can be used as the source operand (to match
   the ACPI specification.)
   
   Reduced stack use in acpi_get_object_info().




