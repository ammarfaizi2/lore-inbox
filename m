Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbTI1Vve (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 17:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbTI1Vvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 17:51:33 -0400
Received: from fed1mtao08.cox.net ([68.6.19.123]:48014 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S262768AbTI1Vvc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 17:51:32 -0400
Message-ID: <3F7757E0.7030906@backtobasicsmgmt.com>
Date: Sun, 28 Sep 2003 14:51:28 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] make O=foo does not fail if foo does not exist
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simple enough... I mistyped the path to the object directory, and the 
build continued in the source directory anyway. This patch causes the 
build to stop, although with a non-obvious error message. A better fix 
would actually check KBUILD_OUTPUT after the cd && pwd test, but I'll 
leave that to you if you're so inclined.

--- linux-2.6/Makefile~	Sat Sep 27 19:26:01 2003
+++ linux-2.6/Makefile	Sun Sep 28 14:46:05 2003
@@ -81,7 +81,7 @@

  ifneq ($(KBUILD_OUTPUT),)
  # Invoke a second make in the output directory, passing relevant 
variables
-	KBUILD_OUTPUT := $(shell cd $(KBUILD_OUTPUT); /bin/pwd)
+	KBUILD_OUTPUT := $(shell cd $(KBUILD_OUTPUT) && /bin/pwd)

  .PHONY: $(MAKECMDGOALS) all


