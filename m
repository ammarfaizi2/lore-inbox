Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbUCPObA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbUCPOaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:30:20 -0500
Received: from styx.suse.cz ([82.208.2.94]:3202 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261950AbUCPOTt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:49 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <1079446778395@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 34/44] Fix a memory leak in ns558.c
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:38 +0100
In-Reply-To: <1079446778365@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1608.78.8, 2004-03-08 12:51:07+01:00, sebek64@post.cz
  input: Fix a memory leak in ns558.c


 ns558.c |    1 +
 1 files changed, 1 insertion(+)

===================================================================

diff -Nru a/drivers/input/gameport/ns558.c b/drivers/input/gameport/ns558.c
--- a/drivers/input/gameport/ns558.c	Tue Mar 16 13:18:00 2004
+++ b/drivers/input/gameport/ns558.c	Tue Mar 16 13:18:00 2004
@@ -289,6 +289,7 @@
 #endif
 			case NS558_ISA:
 				release_region(port->gameport.io & ~(port->size - 1), port->size);
+				kfree(port);
 				break;
 		
 			default:

