Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbWE2OAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWE2OAe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 10:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbWE2OAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 10:00:34 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:18058 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1750854AbWE2OAe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 10:00:34 -0400
Message-ID: <447AFE7A.3070401@drzeus.cx>
Date: Mon, 29 May 2006 16:00:26 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: 2GB MMC/SD cards
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell!

Not sure when you'll be back from your trip, but I'll leave this hanging
in your inbox until then. :)

I've been getting several complaints about the issue with sector sizes
and large MMC/SD cards. I seem to recall we discussed this earlier, but
I cannot find those mail and I don't remember our conclusions.

I do, however, have the following in both the SD and MMC card specs I
have (both sandisk though):

WRITE_BL_PARTIAL — defines whether partial block sizes can be used
                   in block write commands.

Table 3-25
  WRITE_BL_PARTIAL                                  Definition
            0       Only the WRITE_BL_LEN block size, and its partial
                    derivatives in
                    resolution of units of 512 blocks, can be used for
                    block oriented data
                    write.
            1       Smaller blocks can be used as well. The minimum
                    block size is one
                    byte.

So perhaps we should remove all the funky logic that's in mmc_block.c
right now and just always select a block size of 512 bytes? People have
been reporting that their Palms, cameras and USB readers will not accept
anything else.

Rgds
Pierre
