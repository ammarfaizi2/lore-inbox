Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTJCTvs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 15:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261152AbTJCTvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 15:51:48 -0400
Received: from hqemgate00.nvidia.com ([216.228.112.144]:57348 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S261151AbTJCTvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 15:51:47 -0400
Message-ID: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F704@mail-sc-6.nvidia.com>
From: Allen Martin <AMartin@nvidia.com>
To: "'Bartlomiej Zolnierkiewicz'" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: RE: [PATCH][IDE] small cleanup for AMD/nVidia IDE driver
Date: Fri, 3 Oct 2003 12:51:33 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've seen 2.4.x patches from Allen Martin@nVidia on lkml.
> In UDMA133 patch he mentioned that UDMA should be programmed by mode,
> not UDMA cycle timing on nVidia chipsets (probably the same 
> applies to AMD).
> Can you comment on this?

Yes, these controllers have a 1:1 mapping between UDMA mode and
AMD_UDMA_TIMING value.  Trying to map UDMA mode to cycle time and then map
back to UDMA mode is error prone, and cause for some of the ugly workarounds
in the current driver.  My patch to add Ultra133 support just expands this
ugliness, but works.

The mapping is as follows:

UDMA2 0
UDMA1 1
UDMA0 2
UDMA3 4
UDMA4 5
UDMA5 6
UDMA6 7

Other ACPI aware OS'es use an ACPI method to change IDE timing, so this is
hidden from the OS.

-Allen
