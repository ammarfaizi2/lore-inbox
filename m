Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317121AbSFFTg2>; Thu, 6 Jun 2002 15:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317115AbSFFTg1>; Thu, 6 Jun 2002 15:36:27 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:21006 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S317121AbSFFTgW>;
	Thu, 6 Jun 2002 15:36:22 -0400
Date: Thu, 6 Jun 2002 21:39:34 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fixdep fails to use all components in config entry
Message-ID: <20020606213934.A16062@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Kai.

fixdep, when adding dependencies to config entires fails to take into account
the last part of a config entry, if it contains more than one underscore.
Example:
CONFIG_PROC_FS generates
$(wildcard include/config/proc.h)
but should generate
$(wildcard include/config/proc/fs.h)

Attached patch fixes this.

	Sam

--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fixdep-fullpath.patch"

--- scripts/fixdep.c.orig	Thu Jun  6 21:31:52 2002
+++ scripts/fixdep.c	Thu Jun  6 21:31:29 2002
@@ -239,7 +239,7 @@
 		if (memcmp(p, "CONFIG_", 7))
 			continue;
 		for (q = p + 7; q < map + len; q++) {
-			if (!(isalnum(*q)))
+			if (!(isalnum(*q) || *q == '_'))
 				goto found;
 		}
 		continue;

--fUYQa+Pmc3FrFX/N--
