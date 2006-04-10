Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWDJMG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWDJMG2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 08:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWDJMG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 08:06:28 -0400
Received: from uproxy.gmail.com ([66.249.92.172]:9969 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751146AbWDJMG1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 08:06:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nF8I5Nac6Yf3YLptxZUdXsNjTUziUzkf8yFHSmMJ2a6hIbK9nXxOC6H14Y31WC1W6tCudzKQ3DnG1//Xe9zI9qGXWO5RQsV/PHonv2qCU3lfn4v2PhLAvzQTAoo1RkR5HuAvTfXN1GttiGrpV+lqSIaYvAk6LkXP66jibSmSu6U=
Message-ID: <40cb3b290604100506xcf1d00cr34a64bc076b3c88f@mail.gmail.com>
Date: Mon, 10 Apr 2006 14:06:26 +0200
From: "Charles Majola" <chmj@rootcore.co.za>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] NFS_FS needs to depend on PROC_FS for proc_*_iostats
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NFS_FS inode.c need stats.c

from net/sunrpc/Makefile :
<snip>
sunrpc-$(CONFIG_PROC_FS) += stats.o
<snip>


diff --git a/fs/Kconfig b/fs/Kconfig
index e207be6..e7362b9 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -1325,7 +1325,7 @@ menu "Network File Systems"

 config NFS_FS
        tristate "NFS file system support"
-       depends on INET
+       depends on INET && PROC_FS
        select LOCKD
        select SUNRPC
        select NFS_ACL_SUPPORT if NFS_V3_ACL
