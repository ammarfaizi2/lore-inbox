Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWBFUcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWBFUcd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbWBFUbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:31:10 -0500
Received: from mail.kroah.org ([69.55.234.183]:29629 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964798AbWBFU3i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:29:38 -0500
Cc: benh@kernel.crashing.org
Subject: [PATCH] Fix uevent buffer overflow in input layer
In-Reply-To: <11392577581679@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 6 Feb 2006 12:29:18 -0800
Message-Id: <11392577583071@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Fix uevent buffer overflow in input layer

The buffer used for kobject uevent is too small for some of the events generated
by the input layer. Bump it to 2k.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit d87499ed1a3ba0f6dbcff8d91c96ef132c115d08
tree 5baebb0e2b8b821940acc943227b18782c342bac
parent 9c1da3cb46316e40bac766ce45556dc4fd8df3ca
author Benjamin Herrenschmidt <benh@kernel.crashing.org> Wed, 25 Jan 2006 10:21:32 +1100
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 06 Feb 2006 12:17:18 -0800

 lib/kobject_uevent.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index f56e27a..1b1985c 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -22,7 +22,7 @@
 #include <linux/kobject.h>
 #include <net/sock.h>
 
-#define BUFFER_SIZE	1024	/* buffer for the variables */
+#define BUFFER_SIZE	2048	/* buffer for the variables */
 #define NUM_ENVP	32	/* number of env pointers */
 
 #if defined(CONFIG_HOTPLUG) && defined(CONFIG_NET)

