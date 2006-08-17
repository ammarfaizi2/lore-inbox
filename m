Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030275AbWHQW1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbWHQW1D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 18:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbWHQW1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 18:27:02 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:39804 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030275AbWHQW1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 18:27:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=aLigiVnD4FeRY8R4g2zouCA+FLlOfisGxxdpghfvnV1agbkLlSOcruwk5M4+Yq3B9r+Jm3mdyKJ1O3VTZUphT8ridPjBy92iaLqZdBcrjfDhVZIsUksPaEu8J47FdmS4JIo4qSDeiBUpTggbOSntLugZZKu+0HOkLSMOnkldlIU=
Date: Fri, 18 Aug 2006 02:26:52 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix docs for fs.suid_dumpable (#6145)
Message-ID: <20060817222652.GE5205@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Vlasov noticed that there is not kernel.suid_dumpable,
but fs.suid_dumpable.

How KERN_SETUID_DUMPABLE ended up in fs_table[]? Hell knows...

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 Documentation/sysctl/fs.txt     |   20 ++++++++++++++++++++
 Documentation/sysctl/kernel.txt |   20 --------------------
 2 files changed, 20 insertions(+), 20 deletions(-)

--- a/Documentation/sysctl/fs.txt
+++ b/Documentation/sysctl/fs.txt
@@ -25,6 +25,7 @@ Currently, these files are in /proc/sys/
 - inode-state
 - overflowuid
 - overflowgid
+- suid_dumpable
 - super-max
 - super-nr
 
@@ -131,6 +132,25 @@ The default is 65534.
 
 ==============================================================
 
+suid_dumpable:
+
+This value can be used to query and set the core dump mode for setuid
+or otherwise protected/tainted binaries. The modes are
+
+0 - (default) - traditional behaviour. Any process which has changed
+	privilege levels or is execute only will not be dumped
+1 - (debug) - all processes dump core when possible. The core dump is
+	owned by the current user and no security is applied. This is
+	intended for system debugging situations only. Ptrace is unchecked.
+2 - (suidsafe) - any binary which normally would not be dumped is dumped
+	readable by root only. This allows the end user to remove
+	such a dump but not access it directly. For security reasons
+	core dumps in this mode will not overwrite one another or
+	other files. This mode is appropriate when adminstrators are
+	attempting to debug problems in a normal environment.
+
+==============================================================
+
 super-max & super-nr:
 
 These numbers control the maximum number of superblocks, and
--- a/Documentation/sysctl/kernel.txt
+++ b/Documentation/sysctl/kernel.txt
@@ -50,7 +50,6 @@ show up in /proc/sys/kernel:
 - shmmax                      [ sysv ipc ]
 - shmmni
 - stop-a                      [ SPARC only ]
-- suid_dumpable
 - sysrq                       ==> Documentation/sysrq.txt
 - tainted
 - threads-max
@@ -310,25 +309,6 @@ kernel.  This value defaults to SHMMAX.
 
 ==============================================================
 
-suid_dumpable:
-
-This value can be used to query and set the core dump mode for setuid
-or otherwise protected/tainted binaries. The modes are
-
-0 - (default) - traditional behaviour. Any process which has changed
-	privilege levels or is execute only will not be dumped
-1 - (debug) - all processes dump core when possible. The core dump is
-	owned by the current user and no security is applied. This is
-	intended for system debugging situations only. Ptrace is unchecked.
-2 - (suidsafe) - any binary which normally would not be dumped is dumped
-	readable by root only. This allows the end user to remove
-	such a dump but not access it directly. For security reasons
-	core dumps in this mode will not overwrite one another or
-	other files. This mode is appropriate when adminstrators are
-	attempting to debug problems in a normal environment.
-
-==============================================================
-
 tainted: 
 
 Non-zero if the kernel has been tainted.  Numeric values, which

