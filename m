Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280761AbRKYIzB>; Sun, 25 Nov 2001 03:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280762AbRKYIyv>; Sun, 25 Nov 2001 03:54:51 -0500
Received: from [202.73.165.14] ([202.73.165.14]:17536 "EHLO
	maravillo.q-linux.com") by vger.kernel.org with ESMTP
	id <S280761AbRKYIyg>; Sun, 25 Nov 2001 03:54:36 -0500
Date: Sun, 25 Nov 2001 16:53:52 +0800
From: Mike Maravillo <mike.maravillo@q-linux.com>
To: Alex Davis <alex14641@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: change to fs/proc/inode.c breaks ALSA drivers
Message-ID: <20011125165352.A2784@maravillo.q-linux.com>
In-Reply-To: <20011125032447.4327.qmail@web9204.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011125032447.4327.qmail@web9204.mail.yahoo.com>; from alex14641@yahoo.com on Sat, Nov 24, 2001 at 07:24:47PM -0800
Organization: Q Linux Solutions, Inc.
X-Accepted-File-Formats: ASCII .rtf .ps - *NO* MS Office files please
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2001 at 07:24:47PM -0800, Alex Davis wrote:
> 
> Somewhere between 2.4.15pre6 and 2.4.15 final, fs/proc/inode.c
> was modified. The change causes all the devices files that ALSA
> creates in /proc/asound/dev to have a major and minor number of
> zero. I'm sending a patch to revert the file back to what it
> was in 2.4.15pre5.

This change present on alsa-driver cvs fixed the problem on mine,
at least.

diff -urN --exclude=CVS alsa-driver-0.5.12/kernel/info.c alsa-driver/kernel/info.c
--- alsa-driver-0.5.12/kernel/info.c	Wed Jun 28 02:02:03 2000
+++ alsa-driver/kernel/info.c	Wed Nov 21 23:28:35 2001
@@ -897,7 +897,9 @@
 	if (p) {
 		snd_info_device_entry_prepare(p, entry);
 #ifdef LINUX_2_3
-		p->proc_fops = &snd_fops;
+		/* we should not set this - at least * on 2.4.14 or later it causes
+		   problems! */
+		/* p->proc_fops = &snd_fops; */
 #else
 		p->ops = &snd_info_device_inode_operations;
 #endif

-- 
 .--.  Michael J. Maravillo                   office://+63.2.894.3592/
( () ) Q Linux Solutions, Inc.              mobile://+63.917.897.0919/
 `--\\ A Philippine Open Source Solutions Co.  http://www.q-linux.com/
