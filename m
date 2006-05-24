Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932661AbWEXRnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932661AbWEXRnF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 13:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932736AbWEXRnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 13:43:04 -0400
Received: from web50102.mail.yahoo.com ([206.190.38.30]:15983 "HELO
	web50102.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932661AbWEXRnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 13:43:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=F/2aeX9VHhuemahkR7u4apq4EFxwNCJGVStkdOazyZGgw/T8fgyQVDi8P5tkcmpBjjeu2iOJ1AauyZJ7aalVEs8r1XBjBOO1lGkSdgQECyIs5OYSX/ouIb/7+nPdl1Vc5bYqH3fwVJ0m2vMbw9ruXKmch2rS3oU1pfKxwGD8DrA=  ;
Message-ID: <20060524174303.2323.qmail@web50102.mail.yahoo.com>
Date: Wed, 24 May 2006 10:43:03 -0700 (PDT)
From: Doug Thompson <norsk5@yahoo.com>
Subject: [PATCH 0/6]  EDAC Patch Set
To: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set applies to kernel 2.6.17-rc4 fine and to 2.6.17-rc4-mm1 with slight
fuzz in the MAINTAINERs file.

The following set of patches to EDAC provide various cleanups of the EDAC core and
memory controller drivers.  Most of which came from Dave Peterson and from others.

edac-pci_dep.patch
Change MC drivers from using CVS revisions strings for their version number,
Now each driver has its own local string.

Remove some PCI dependencies from the core EDAC module.  Most of the code
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
This is part 2 of a 2-part patch set.

Modify the xxx_probe1() functions so they call the lower-level functions
created by the first patch in the set.

edac-maintainers.patch
--------
Removed Dave Peterson as per his request as maintainer.
Add Mark Gross as maintainer for E752X MC driver

Signed-off-by:  doug thompson <norsk5@xmission.com>

 drivers/edac/amd76x_edac.c                   |   97 ++++---
 drivers/edac/e752x_edac.c                    |  345 ++++++++++++++-------------
 drivers/edac/e7xxx_edac.c                    |  184 +++++++-------
 drivers/edac/edac_mc.c                       |   56 ++--
 drivers/edac/edac_mc.h                       |   20 +
 drivers/edac/i82860_edac.c                   |  132 +++++-----
 drivers/edac/i82875p_edac.c                  |  254 +++++++++++--------
 drivers/edac/r82600_edac.c                   |  139 +++++-----
 linux-2.6.17-rc3/drivers/edac/edac_mc.c      |   43 ---
 linux-2.6.17-rc4/MAINTAINERS                 |   14 -
 linux-2.6.17-rc4/drivers/edac/amd76x_edac.c  |    5 
 linux-2.6.17-rc4/drivers/edac/e752x_edac.c   |    5 
 linux-2.6.17-rc4/drivers/edac/e7xxx_edac.c   |    5 
 linux-2.6.17-rc4/drivers/edac/edac_mc.c      |   46 +++
 linux-2.6.17-rc4/drivers/edac/edac_mc.h      |    2 
 linux-2.6.17-rc4/drivers/edac/i82860_edac.c  |    5 
 linux-2.6.17-rc4/drivers/edac/i82875p_edac.c |    5 
 linux-2.6.17-rc4/drivers/edac/r82600_edac.c  |    5 
 18 files changed, 755 insertions(+), 607 deletions(-)

