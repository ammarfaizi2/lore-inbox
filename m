Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751910AbWHNHC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbWHNHC3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 03:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751912AbWHNHC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 03:02:29 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:62890 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1751910AbWHNHC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 03:02:28 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH][BUILD] Fix "mkdir -p" usage in scripts/package/mkspec
Date: Mon, 14 Aug 2006 08:16:47 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608140816.48030.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"mkdir -p" does not only mean not to complain if the directory already
exists, but also to create the parent directories if needed. This patch
removes "lib" from the list of directories to create as we will also create
"lib/modules".

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

---
commit 288a3f1fd00365669ed9ad725b15ff67004cee0a
tree 5352b0426d399ac9f0a0f795c7dab1c487c63e82
parent cc4a7b5dfee25083a6a5741b5b640ae2a1d3aa12
author Rolf Eike Beer <eike-kernel@sf-tec.de> Mon, 14 Aug 2006 08:12:56 +0200
committer Rolf Eike Beer <beer@siso-eb-i34d.silicon-software.de> Mon, 14 Aug 2006 08:12:56 +0200

 scripts/package/mkspec |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index df89284..ffd61fe 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -63,9 +63,9 @@ fi
 
 echo "%install"
 echo "%ifarch ia64"
-echo 'mkdir -p $RPM_BUILD_ROOT/boot/efi $RPM_BUILD_ROOT/lib $RPM_BUILD_ROOT/lib/modules'
+echo 'mkdir -p $RPM_BUILD_ROOT/boot/efi $RPM_BUILD_ROOT/lib/modules'
 echo "%else"
-echo 'mkdir -p $RPM_BUILD_ROOT/boot $RPM_BUILD_ROOT/lib $RPM_BUILD_ROOT/lib/modules'
+echo 'mkdir -p $RPM_BUILD_ROOT/boot $RPM_BUILD_ROOT/lib/modules'
 echo "%endif"
 
 echo 'INSTALL_MOD_PATH=$RPM_BUILD_ROOT make %{_smp_mflags} modules_install'
