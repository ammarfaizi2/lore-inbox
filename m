Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129209AbQKHRmb>; Wed, 8 Nov 2000 12:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129280AbQKHRmV>; Wed, 8 Nov 2000 12:42:21 -0500
Received: from hybrid-024-221-152-185.az.sprintbbd.net ([24.221.152.185]:21486
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S129209AbQKHRmN>; Wed, 8 Nov 2000 12:42:13 -0500
Date: Wed, 8 Nov 2000 10:37:29 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Urban Widmark <urban@svenskatest.se>
Subject: Re: test11-pre1
Message-ID: <20001108103729.A30483@opus.bloom.county>
In-Reply-To: <Pine.LNX.4.10.10011071301580.6012-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10011071301580.6012-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Nov 07, 2000 at 01:06:27PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 07, 2000 at 01:06:27PM -0800, Linus Torvalds wrote:

> Mostly driver updates.
> 
> With a few notable exceptions: two rather subtle MM race conditions that
> happened with SMP and highmem respectively. And the FXCSR and file locking
> that was already discussed on the list.

I've once again attached this very small patch for !CONFIG_INET.  Summary:
This is a very minor patch for fs/nls/Config.in, which Petr Vandrovec came up   
with.  The problem is that if CONFIG_INET is n, CONFIG_SMB_FS is never set
so fs/nls/Config.in assumes that the user wants to select some NLS options.
This fixes it and works on config/menuconfig/xconfig.  It's been ok'ed by
the SMB maintainer, so could this please go in?

This is still vs 2.4.10-test8 or so, but the file hasn't changed any, nor has
the problem, so...

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

--0OAP2g/MAC+5xKAE
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

--0OAP2g/MAC+5xKAE--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
