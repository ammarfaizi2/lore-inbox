Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031905AbWLGJkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031905AbWLGJkx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 04:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031907AbWLGJkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 04:40:53 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:49035 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031905AbWLGJkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 04:40:52 -0500
X-Originating-Ip: 74.102.209.62
Date: Thu, 7 Dec 2006 04:36:25 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: The drivers Kconfig structure:  oddities and exceptions
Message-ID: <Pine.LNX.4.64.0612070405510.15805@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  as a followup to my previous patch (and before i build on top of
that), perhaps someone can clarify some of these bits of curiosity:

1) although "Sound" is listed in the Device Drivers menu, its actual
source directory is at the top level of the kernel source tree, and
it's the *only* entry in Device Drivers that requires sourcing from
the top-level directory.  any reason for this?  it just kind of stands
out as a weird exception to the rule.


2) in any of these driver submenu Kconfig files, you normally see that
*all* of the Kconfig entries depend on that "parent" menu selection.
but in drivers/scsi/Kconfig, you read:

=========================================================
menu "SCSI device support"

config RAID_ATTRS                            ???
        tristate "RAID Transport Class"
        default n
        depends on BLOCK
        ---help---
          Provides RAID

config SCSI
        tristate "SCSI device support"
        depends on BLOCK
        ---help---
          ... snip ...

config SCSI_TGT
        tristate "SCSI target support"
        depends on SCSI && EXPERIMENTAL
        ---help---
          ... snip ...

config SCSI_NETLINK                           ???
        bool
        default n
        select NET
...
==========================================================

  one would think that, if RAID_ATTRS depends only on BLOCK, it
properly belongs under the "Block devices" menu, just as SCSI_NETLINK
might belong under NET, or perhaps it should have a SCSI dependency as
well to make it consistent.  thoughts?

rday
