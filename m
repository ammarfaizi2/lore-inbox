Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263091AbUCMNUw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 08:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263092AbUCMNUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 08:20:52 -0500
Received: from iwoars.net ([217.160.110.113]:22281 "HELO iwoars.net")
	by vger.kernel.org with SMTP id S263091AbUCMNUt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 08:20:49 -0500
Date: Sat, 13 Mar 2004 14:20:50 +0100
From: Thomas Themel <themel@iwoars.net>
To: linux-kernel@vger.kernel.org
Subject: [themel@iwoars.net: PDC202XX_OLD regression between 2.6 and 2.4]
Message-ID: <20040313132050.GW19928@iwoars.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Jabber-ID: themel0r@jabber.at
X-ICQ-UIN: 8774749
X-Postal: Hauptplatz 8/4, 9500 Villach, Austria
X-Phone: +43 676 846623 13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[Repost, I tried on linux-ide first, but the list seems to be somewhat dead
(no traffic for the past three days other than someone who has similar
problems), so here we go again. Also, it seems linux-ide is not archived
anywhere.]

I'm currently trying to set up a system that contains a Promise 20267
controller, and it seems that DMA on that controller causes problems in
2.6. 

My test case consists of simply creating an empty ext3 file system and
running bonnie++ on it. In 2.4.25, this works as expected. In 2.6.3-rc4,
however, it breaks after a few seconds:

Mar 11 17:27:19 sophokles kernel: hdg: dma_timer_expiry: dma status == 0x60
Mar 11 17:27:19 sophokles kernel: hdg: DMA timeout retry
Mar 11 17:27:19 sophokles kernel: PDC202XX: Secondary channel reset.
Mar 11 17:27:19 sophokles kernel: PDC202XX: Primary channel reset.
Mar 11 17:27:19 sophokles kernel: hdg: timeout waiting for DMA
Mar 11 17:27:40 sophokles kernel: hdg: dma_timer_expiry: dma status == 0x60
Mar 11 17:27:40 sophokles kernel: hdg: DMA timeout retry
Mar 11 17:27:40 sophokles kernel: PDC202XX: Secondary channel reset.
Mar 11 17:27:40 sophokles kernel: PDC202XX: Primary channel reset.
Mar 11 17:27:40 sophokles kernel: hdg: timeout waiting for DMA
Mar 11 17:28:02 sophokles kernel: hdg: dma_timer_expiry: dma status == 0x60
Mar 11 17:28:02 sophokles kernel: hdg: DMA timeout retry
Mar 11 17:28:02 sophokles kernel: PDC202XX: Secondary channel reset.
Mar 11 17:28:02 sophokles kernel: PDC202XX: Primary channel reset.
Mar 11 17:28:02 sophokles kernel: hdg: timeout waiting for DMA
Mar 11 17:28:22 sophokles kernel: hdg: dma_timer_expiry: dma status == 0x60
Mar 11 17:28:22 sophokles kernel: hdg: DMA timeout retry
Mar 11 17:28:22 sophokles kernel: PDC202XX: Secondary channel reset.
Mar 11 17:28:22 sophokles kernel: PDC202XX: Primary channel reset.
Mar 11 17:28:22 sophokles kernel: hdg: timeout waiting for DMA

Other information:

hdparm output is slightly different between 2.4 and 2.6 (hda is an
identical drive on a vt8233a controller on the motherboard) - 

sophokles:~# diff -Nrua 2.4.25/ 2.6.4-rc3/
diff -Nrua 2.4.25/hda 2.6.4-rc3/hda
--- 2.4.25/hda  2004-03-11 19:48:29.000000000 +0100
+++ 2.6.4-rc3/hda       2004-03-11 19:52:28.000000000 +0100
@@ -6,5 +6,5 @@
  using_dma    =  1 (on)
  keepsettings =  0 (off)
  readonly     =  0 (off)
- readahead    =  8 (on)
- geometry     = 14593/255/63, sectors = 234441648, start = 0
+ readahead    = 256 (on)
+ geometry     = 16383/255/63, sectors = 234441648, start = 0
diff -Nrua 2.4.25/hdg 2.6.4-rc3/hdg
--- 2.4.25/hdg  2004-03-11 19:48:32.000000000 +0100
+++ 2.6.4-rc3/hdg       2004-03-11 19:52:31.000000000 +0100
@@ -6,5 +6,5 @@
  using_dma    =  1 (on)
  keepsettings =  0 (off)
  readonly     =  0 (off)
- readahead    =  8 (on)
- geometry     = 14593/255/63, sectors = 234441648, start = 0
+ readahead    = 256 (on)
+ geometry     = 16383/255/63, sectors = 234441648, start = 0

I am a bit confused by the geometry changes, but they can hardly
cause the problem since hda works nicely under 2.6.

Can I do anything to narrow this down, is there a way to get more
debugging output? 

ciao,
-- 
[*Thomas  Themel*]  While differing widely in the various little bits we know,
[extended contact]  in our infinite ignorance we are all equal. 
[info provided in]
[*message header*]      - Karl Popper
