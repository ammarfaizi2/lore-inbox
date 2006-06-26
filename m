Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933085AbWFZWPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933085AbWFZWPS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933087AbWFZWPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:15:18 -0400
Received: from web50103.mail.yahoo.com ([206.190.38.31]:11616 "HELO
	web50103.mail.yahoo.com") by vger.kernel.org with SMTP
	id S933085AbWFZWPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:15:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=HzsdF//Gfs/NzyqnSvq9QAswA/Tnv4/I56Qown40gw+lJNF8FFOUWiRH04fDLgeNdclu7xWwG8NfYQolz+sh4SDxzw9VncfFhTei83bpVDQf+P91n3y0dDssU/x5mq2HoEO2eqBHozsEGNlyRbGLhyHcea+tyfrnELGxbm+0CEo=  ;
Message-ID: <20060626221516.62532.qmail@web50103.mail.yahoo.com>
Date: Mon, 26 Jun 2006 15:15:15 -0700 (PDT)
From: Doug Thompson <norsk5@yahoo.com>
Subject: [PATCH 0/6]  EDAC Patch Set
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Thompson <norsk5@xmission.com>

This patch set applies to kernel 2.6.17

The following set of quilt patches to EDAC provide various cleanups of the EDAC core
and memory controller drivers.  Most of which came from Dave Peterson, Dave Jiang
and from others.

edac-pci_dep.patch
Change MC drivers from using CVS revisions strings for their version number,
Now each driver has its own local string.

Remove  PCI dependencies from the core EDAC module.  Most of the code
changes here are from a patch by Dave Jiang.
It may be best to eventually move the PCI-specific code into a separate source file.

edac-mc_numbers_1_of_2.patch
This is part 1 of a 2-part patch set.  The code changes are split into two
parts to make the patches more readable.

Remove add_mc_to_global_list().  In next patch, this function will be
reimplemented with different semantics.

edac-mc_numbers_2_of_2.patch
This is part 2 of a 2-part patch set.

- Reimplement add_mc_to_global_list() with semantics that allow the caller to
  determine the ID number for a mem_ctl_info structure.  Then modify
  edac_mc_add_mc() so that the caller specifies the ID number for the new
  mem_ctl_info structure.  Platform-specific code should be able to assign the
  ID numbers in a platform-specific manner.  For instance, on Opteron it makes
  sense to have the ID of the mem_ctl_info structure match the ID of the node
  that the memory controller belongs to.

- Modify callers of edac_mc_add_mc() so they use the new semantics.

edac-probe1_cleanup_1_of_2.patch
This is part 1 of a 2-part patch set.  The code changes are split into two
parts to make the patches more readable.

Add lower-level functions that handle various parts of the initialization done
by the xxx_probe1() functions.  Some of the xxx_probe1() functions are much
too long and complicated (see "Chapter 5: Functions" in
Documentation/CodingStyle).

edac-probe1_cleanup_2_of_2.patch
This is part 2 of a 2-part patch set.

Modify the xxx_probe1() functions so they call the lower-level functions
created by the first patch in the set.

edac-maintainers.patch
Removed Dave Peterson as per his request as maintainer.
Add Mark Gross as maintainer for E752X MC driver

Signed-off-by:  doug thompson <norsk5@xmission.com>
Signed-off-by:	  Dave Peterson <dsp@llnl.gov>



