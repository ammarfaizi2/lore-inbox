Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262447AbVCRWfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262447AbVCRWfj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 17:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262437AbVCRWco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 17:32:44 -0500
Received: from zeus.kernel.org ([204.152.189.113]:25292 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262091AbVCRWab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 17:30:31 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Ed L. Cashin" <ecashin@coraid.com>
Subject: [PATCH 2.6.11] aoe [4/12]: handle distros that have a udev rules
 file instead of dir
Date: Fri, 18 Mar 2005 15:14:33 -0500
Message-ID: <874qf8ognq.fsf@coraid.com>
References: <87mztbi79d.fsf@coraid.com> <20050317234641.GA7091@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
Cc: Greg K-H <greg@kroah.com>
X-Gmane-NNTP-Posting-Host: adsl-34-234-30.asm.bellsouth.net
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:qZnuVtqhrUmKsSRDQI4UAOjUFdI=
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
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

