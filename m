Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267866AbTBRQzF>; Tue, 18 Feb 2003 11:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267867AbTBRQzF>; Tue, 18 Feb 2003 11:55:05 -0500
Received: from franka.aracnet.com ([216.99.193.44]:23702 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267866AbTBRQzE>; Tue, 18 Feb 2003 11:55:04 -0500
Date: Tue, 18 Feb 2003 09:04:57 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 375] New: M5451 (OSS trident.c) did not come out of reset 
Message-ID: <5790000.1045587897@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=375

           Summary: M5451 (OSS trident.c) did not come out of reset
    Kernel Version: 2.5.62
            Status: NEW
          Severity: low
             Owner: mulix@mulix.org
         Submitter: mulix@mulix.org


Last time I booted 2.5, I noticed that my sound card no longer
works. The card is:

00:06.0 Multimedia audio controller: Acer Laboratories Inc. [ALi]
M5451 PCI AC-Link Controller Audio Device (rev 01)

And the computer is a thinkpad R30. It turns out that this patch, from
Alan Cox on 01/11/2002, broke it for me, by failing ali_reset_5451 if
the card doesn't come out of reset:

# --------------------------------------------
# 02/11/01      alan@lxorguk.ukuu.org.uk        1.786.161.45
# [PATCH] some trident needs longer delays to power up codecs
# --------------------------------------------

The 2.4 behaviour is to continue as usual even if the card doesn't
come out of reset, because it's a non fatal error on at least some
cards. This patch reverts the behaviour to the 2.4 behaviour, which
works for me. If anyone knows how to tell for a given card whether
this is a fatal error or not, please let me know and I'll update the
patch.


