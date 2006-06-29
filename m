Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932741AbWF2VgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932741AbWF2VgG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932721AbWF2VgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:36:06 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:29314 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932667AbWF2VgE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:36:04 -0400
Date: Thu, 29 Jun 2006 14:34:02 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       "Theodore Ts'o" <tytso@mit.edu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Justin Forbes <jmforbes@linuxtx.org>, torvalds@osdl.org,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, Nix <nix@esperi.org.uk>,
       Randy Dunlap <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>,
       Chuck Wolber <chuckw@quantumlinux.com>, Sam Ravnborg <sam@ravnborg.org>,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [stable] [PATCH 21/25] kbuild: Fix 100% initramfs bloat in 2.6.17 versus 2.6.16
Message-ID: <20060629213402.GB11588@sequoia.sous-sol.org>
References: <20060627200745.771284000@sous-sol.org> <20060627201655.873643000@sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627201655.873643000@sous-sol.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Wright (chrisw@sous-sol.org) wrote:
> -stable review patch.  If anyone has any objections, please let us know.
> ------------------
> From: Nix <nix@esperi.org.uk>
> 
> When I built 2.6.17 for the first time I was a little surprised to see
> my kernel putting on >500Kb in weight.
> 
> It didn't take long to work out that this was because my initramfs's
> contents were being included twice in the cpio image.

Sam accidentally sent the wrong patch, here's variant that went into
Linus' tree.

----------------------------------
From: Nickolay <nickolay@protei.ru>
Subject: kbuild: bugfix with initramfs

This patch fix double inclusion of ramfs-input.

Signed-off-by: Nickolay Vinogradov <nickolay@protei.ru>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 usr/Makefile |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/usr/Makefile b/usr/Makefile
index 19d74e6..e938242 100644
--- a/usr/Makefile
+++ b/usr/Makefile
@@ -21,8 +21,7 @@ ramfs-input := $(if $(filter-out "",$(CO
                     $(CONFIG_INITRAMFS_SOURCE),-d)
 ramfs-args  := \
         $(if $(CONFIG_INITRAMFS_ROOT_UID), -u $(CONFIG_INITRAMFS_ROOT_UID)) \
-        $(if $(CONFIG_INITRAMFS_ROOT_GID), -g $(CONFIG_INITRAMFS_ROOT_GID)) \
-        $(ramfs-input)
+        $(if $(CONFIG_INITRAMFS_ROOT_GID), -g $(CONFIG_INITRAMFS_ROOT_GID))
 
 # .initramfs_data.cpio.gz.d is used to identify all files included
 # in initramfs and to detect if any files are added/removed.

