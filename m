Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbWIOBiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbWIOBiv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 21:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWIOBiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 21:38:50 -0400
Received: from smtp-out.google.com ([216.239.45.12]:36994 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751425AbWIOBit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 21:38:49 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:content-type:
	organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=KcvFonIIQVBLPk3XBqJvbpkOdadHpMoWkrfALNDvQdBikso/mZRrCEPin/Jb1tsXq
	aMrydY4bPiPRyeN9Cia3Q==
Subject: [Patch 01/05]- Containers: Documentation on using containers
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Andrew Morton <akpm@osdl.org>
Cc: devel@openvz.org, CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Google Inc
Date: Thu, 14 Sep 2006 18:38:33 -0700
Message-Id: <1158284314.5408.146.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the Documentation for using containers.

Signed-off-by: Rohit Seth <rohitseth@google.com>
 
 Documentation/containers.txt |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+)

--- linux-2.6.18-rc6-mm2.org/Documentation/containers.txt	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.18-rc6-mm2.ctn/Documentation/containers.txt	2006-09-14 17:13:48.000000000 -0700
@@ -0,0 +1,42 @@
+This file contains information about how to use containers.  Configfs support 
+is needed in kernel as the container's user interface is through configfs. So
+first enable CONFIG_CONFIGFS_FS and CONFIG_CONTAINERS and recompile the kernel.
+
+1- Mount a configfs (for example):
+	mount -t configfs none /mnt/configfs
+   This will create a /mnt/configfs mount point.
+
+2- As the support of containers is built into kernel, so the mount point
+   /mnt/configfs will automatically contain a directory "containers"
+
+3- Create a container by name test_container
+	cd /mnt/configfs/containers
+	mkdir test_container
+
+All the current implemented attributes in the kernel will show up in the
+directory /configfs/containers/test_container
+
+4- Add a task to container
+	cd /mnt/configfs/cotnainers/test_container
+	echo <pid> > addtask
+
+Now the <pid> and its subsequently forked children will belong to container
+test_container.
+
+5- Remove a task from container
+	echo <pid> rmtask
+
+6- Set a page limit for the container
+	echo some_number_of_pages > page_limit
+
+7- Read the id for the container
+	cat id
+
+8- Get the statistics for this container
+	cat num* (will print active pages, anon_pages, file_pages, num_files, 
+			and num_task)
+	cat *hits (will print page_limit_hits and task_limit_hits: the number
+		of times container has gone over page_limit and task_limit)
+9- Freeing a container
+	cd /mnt/configfs/containers/
+	rmdir test_container


