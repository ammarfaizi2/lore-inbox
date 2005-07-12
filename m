Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbVGLJHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVGLJHW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 05:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbVGLJHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 05:07:21 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:65484 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261273AbVGLJFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 05:05:23 -0400
Date: Tue, 12 Jul 2005 11:05:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] suspend: update documentation
Message-ID: <20050712090510.GG1854@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update suspend documentation.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 8972d0ff145879e53416ac77c4cd096fd3cfe227
tree f901592e816f4cfae7383f443b21a13f67a644f8
parent a6500a8820a9b271105fe92e5d3013f7c2875b44
author <pavel@amd.(none)> Tue, 12 Jul 2005 11:04:31 +0200
committer <pavel@amd.(none)> Tue, 12 Jul 2005 11:04:31 +0200

 Documentation/power/swsusp.txt |    7 +++++++
 Documentation/power/video.txt  |    9 ++++++++-
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/Documentation/power/swsusp.txt b/Documentation/power/swsusp.txt
--- a/Documentation/power/swsusp.txt
+++ b/Documentation/power/swsusp.txt
@@ -318,3 +318,10 @@ As a rule of thumb use encrypted swap to
 system is shut down or suspended. Additionally use the encrypted
 suspend image to prevent sensitive data from being stolen after
 resume.
+
+Q: Why we cannot suspend to a swap file?
+
+A: Because accessing swap file needs the filesystem mounted, and
+filesystem might do something wrong (like replaying the journal)
+during mount. [Probably could be solved by modifying every filesystem
+to support some kind of "really read-only!" option. Patches welcome.]
diff --git a/Documentation/power/video.txt b/Documentation/power/video.txt
--- a/Documentation/power/video.txt
+++ b/Documentation/power/video.txt
@@ -46,6 +46,12 @@ There are a few types of systems where v
   POSTing bios works. Ole Rohne has patch to do just that at
   http://dev.gentoo.org/~marineam/patch-radeonfb-2.6.11-rc2-mm2.
 
+(8) on some systems, you can use the video_post utility mentioned here:
+  http://bugzilla.kernel.org/show_bug.cgi?id=3670. Do echo 3 > /sys/power/state
+  && /usr/sbin/video_post - which will initialize the display in console mode.
+  If  you are in X, you can switch to a virtual terminal and back to X using
+  CTRL+ALT+F1 - CTRL+ALT+F7 to get the display working in graphical mode again.
+
 Now, if you pass acpi_sleep=something, and it does not work with your
 bios, you'll get a hard crash during resume. Be careful. Also it is
 safest to do your experiments with plain old VGA console. The vesafb
@@ -64,7 +70,8 @@ Model                           hack (or
 ------------------------------------------------------------------------------
 Acer Aspire 1406LC		ole's late BIOS init (7), turn off DRI
 Acer TM 242FX			vbetool (6)
-Acer TM C300                    vga=normal (only suspend on console, not in X), vbetool (6)
+Acer TM C110			video_post (8)
+Acer TM C300                    vga=normal (only suspend on console, not in X), vbetool (6) or video_post (8)
 Acer TM 4052LCi		        s3_bios (2)
 Acer TM 636Lci			s3_bios vga=normal (2)
 Acer TM 650 (Radeon M7)		vga=normal plus boot-radeon (5) gets text console back

