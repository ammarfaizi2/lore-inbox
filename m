Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131082AbQKACVt>; Tue, 31 Oct 2000 21:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131095AbQKACVk>; Tue, 31 Oct 2000 21:21:40 -0500
Received: from hybrid-024-221-152-185.az.sprintbbd.net ([24.221.152.185]:26097
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S131082AbQKACVW>; Tue, 31 Oct 2000 21:21:22 -0500
Date: Tue, 31 Oct 2000 19:18:07 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.0-test10
Message-ID: <20001031191807.A32641@opus.bloom.county>
In-Reply-To: <Pine.LNX.4.10.10010311237430.22165-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10010311237430.22165-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Oct 31, 2000 at 12:41:55PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 31, 2000 at 12:41:55PM -0800, Linus Torvalds wrote:
 
> Ok, test10-final is out there now. This has no _known_ bugs that I
> consider show-stoppers, for what it's worth.

Sure, it's not a critical bug or anything but hey.  One more time:
This is a very minor patch for fs/nls/Config.in, which Petr Vandrovec came up
with.  The problem is that if CONFIG_INET is n, CONFIG_SMB_FS is never set
so fs/nls/Config.in assumes that the user wants to select some NLS options.
This fixes it and works on config/menuconfig/xconfig.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nls.patch"

--- fs/nls/Config.in.orig	Thu Oct 19 12:54:09 2000
+++ fs/nls/Config.in	Thu Oct 19 12:54:32 2000
@@ -2,10 +2,17 @@
 # Native language support configuration
 #
 
+# smb wants NLS
+if [ "$CONFIG_SMB_FS" = "m" -o "$CONFIG_SMB_FS" = "y" ]; then
+  define_bool CONFIG_SMB_NLS y
+else
+  define_bool CONFIG_SMB_NLS n
+fi
+
 # msdos and Joliet want NLS
 if [ "$CONFIG_JOLIET" = "y" -o "$CONFIG_FAT_FS" != "n" \
 	-o "$CONFIG_NTFS_FS" != "n" -o "$CONFIG_NCPFS_NLS" = "y" \
-	-o "$CONFIG_SMB_FS" != "n" ]; then
+	-o "$CONFIG_SMB_NLS" = "y" ]; then
   define_bool CONFIG_NLS y
 else
   define_bool CONFIG_NLS n

--7JfCtLOvnd9MIVvH--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
