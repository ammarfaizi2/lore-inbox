Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135600AbRAGCri>; Sat, 6 Jan 2001 21:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135605AbRAGCrR>; Sat, 6 Jan 2001 21:47:17 -0500
Received: from 209.102.21.2 ([209.102.21.2]:20229 "EHLO dragnet.seagull.net")
	by vger.kernel.org with ESMTP id <S135600AbRAGCrL>;
	Sat, 6 Jan 2001 21:47:11 -0500
Message-ID: <3A57A83B.702CEC98@goingware.com>
Date: Sat, 06 Jan 2001 23:20:27 +0000
From: "Michael D. Crawford" <crawford@goingware.com>
Organization: GoingWare Inc. - Expert Software Development and Consulting
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, newbie@xfree86.org
Subject: DRI doesn't work on 2.4.0 but does on prerelease-ac5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was testing the 2.4.0 kernel by running "make exec" in the Mesa-3.4 sources,
which builds and runs a bunch of demos, and was suprised to see one of the tests
emit a message that said DRI wasn't available.  It had been working before.

Just to make sure I then booted off of 2.4.0-prerelease-ac5 and it was working
again.

This is with XFree86 4.0.1 on Slackware 7.1.  I have an ATI Rage Millenium card
on a machine with a 667 MHz Pentium III and 128 MB of 133 MHz RAM.  The
motherboard is an ASUS P3V4X.  It has an ACPI bios but ACPI is disabled in the
config.

Could XFree86 4.0.2 fix this?  I had been waiting until the binary packages were
available from ftp.slackware.com because Patrick Volkerding lays out the
directories in a slightly different manner that he argues pretty convincingly is
preferable, but it would be a drag for me to reproduce by building it myself.
 
AGP, VIA support, DRM, and r128 DRM are all compiled in statically rather than
as modules.

In the /var/log/XFree86.0.log file I see the following under 2.4.0 final
release:

(EE) r128(0): R128DRIScreenInit failed (DRM version = 2.1.2, expected 1.0.x). 
Disabling DRI.
(0): [drm] failed to remove DRM signal handler
(0): failed to destroy server context
(0): [drm] removed 1 reserved context for kernel
(0): [drm] unmapping 4096 bytes of SAREA 0xc5bb3000 at 0x40014000

in the corresponding point of the same file under 2.4.0-prerelease-ac5 I have:

(II) r128(0): [agp] Mode 0x1f000203 [AGP 0x1106/0x0691; Card 0x1002/0x5246]
(II) r128(0): [agp] 8192 kB allocated with handle 0xcc82b000
(II) r128(0): [agp] ring handle = 0xe4000000
(II) r128(0): [agp] Ring mapped at 0x421d9000
(II) r128(0): [agp] ring read ptr handle = 0xe4101000
(II) r128(0): [agp] Ring read ptr mapped at 0x40015000
(II) r128(0): [agp] vertex buffers handle = 0xe4102000
(II) r128(0): [agp] Vertex buffers mapped at 0x422da000
(II) r128(0): [agp] indirect buffers handle = 0xe4202000
(II) r128(0): [agp] Indirect buffers mapped at 0x423da000
(II) r128(0): [agp] AGP texture map handle = 0xe4302000
(II) r128(0): [agp] AGP Texture map mapped at 0x424da000
(II) r128(0): [drm] register handle = 0xdd000000
(II) r128(0): [drm] Added 64 16384 byte vertex buffers
(II) r128(0): [drm] Mapped 64 vertex buffers

The relevant parts of my .config file are as follows (and are identical between
the two kernel versions, I used "make oldconfig" and didn't change any options):

CONFIG_AGP=y
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_I810 is not set
CONFIG_AGP_VIA=y
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
CONFIG_DRM_R128=y
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_MGA is not set

If you want my whole .config file I could mail it in or post it on my website.

Mike

-- 
Michael D. Crawford
GoingWare Inc. - Expert Software Development and Consulting
http://www.goingware.com/
crawford@goingware.com

   Tilting at Windmills for a Better Tomorrow.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
