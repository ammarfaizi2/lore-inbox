Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbVCXPQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVCXPQr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 10:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbVCXPQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 10:16:46 -0500
Received: from geode.he.net ([216.218.230.98]:57102 "HELO noserose.net")
	by vger.kernel.org with SMTP id S261514AbVCXPPP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 10:15:15 -0500
From: ecashin@noserose.net
Message-Id: <1111677313.27478@geode.he.net>
Date: Thu, 24 Mar 2005 07:15:13 -0800
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.11] aoe [4/12]: handle distros that have a udev rules file instead of dir
References: <87mztbi79d.fsf@coraid.com> <20050317234641.GA7091@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


handle distros that have a udev rules file instead of dir

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>

diff -uprN a/Documentation/aoe/udev-install.sh b/Documentation/aoe/udev-install.sh
--- a/Documentation/aoe/udev-install.sh	2005-03-10 11:59:55.000000000 -0500
+++ b/Documentation/aoe/udev-install.sh	2005-03-10 12:19:18.000000000 -0500
@@ -23,4 +23,8 @@ fi
 # /etc/udev/rules.d
 #
 rules_d="`sed -n '/^udev_rules=/{ s!udev_rules=!!; s!\"!!g; p; }' $conf`"
-test "$rules_d" && sh -xc "cp `dirname $0`/udev.txt $rules_d/60-aoe.rules"
+if test -z "$rules_d" || test ! -d "$rules_d"; then
+	echo "$me Error: cannot find udev rules directory" 1>&2
+	exit 1
+fi
+sh -xc "cp `dirname $0`/udev.txt $rules_d/60-aoe.rules"


-- 
  Ed L. Cashin <ecashin@coraid.com>
