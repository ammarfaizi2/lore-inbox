Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311026AbSC1Afo>; Wed, 27 Mar 2002 19:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311092AbSC1Afe>; Wed, 27 Mar 2002 19:35:34 -0500
Received: from ANice-101-1-2-10.abo.wanadoo.fr ([193.251.81.10]:30727 "EHLO
	bluebloup.ath.cx") by vger.kernel.org with ESMTP id <S311026AbSC1Af1>;
	Wed, 27 Mar 2002 19:35:27 -0500
Date: Thu, 28 Mar 2002 01:35:15 +0100
From: Benoit Timbert <Benoit.TIMBERT@free.fr>
To: linux-kernel@vger.kernel.org
Cc: security@isec.pl
Subject: [PATCH] d_path()
Message-ID: <20020328013515.A1636@bluebloup.bloup.uv>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have found this advisory on BUGTRAQ about d_path() :
http://online.securityfocus.com/archive/1/264117


I have made the following modifications in the d_path() of
Linux 2.2.20 : d_path() return an empty string when the path is
too large.

--- /usr/src/linux/fs/dcache.c.orig	Fri Nov  2 17:39:08 2001
+++ /usr/src/linux/fs/dcache.c	Wed Mar 27 23:30:32 2002
@@ -794,8 +794,11 @@
 			break;
 		namelen = dentry->d_name.len;
 		buflen -= namelen + 1;
-		if (buflen < 0)
+		if (buflen < 0) {
+			/* FIXME : buffer overflow -> no return */
+			retval = buffer+buflen;
 			break;
+		}
 		end -= namelen;
 		memcpy(end, dentry->d_name.name, namelen);
 		*--end = '/';

---

I don't know, if it really fixes well the problem, but i tested the
proposed exploit on my patched kernel and getcwd() does return an error.

It is probable that you have already fixed this, in a better way.

Benoît Timbert
