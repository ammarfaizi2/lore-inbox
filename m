Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWG0Hzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWG0Hzv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 03:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWG0Hzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 03:55:51 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:38873 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750726AbWG0Hzb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 03:55:31 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 3/3] Allow cifsd to suspend if connection is lost
Date: Thu, 27 Jul 2006 09:46:49 +0200
User-Agent: KMail/1.9.3
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>
References: <200607270914.08774.rjw@sisk.pl>
In-Reply-To: <200607270914.08774.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200607270946.49478.rjw@sisk.pl>
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make cifsd allow us to suspend if it has lost the connection with the server.

Ref. http://bugzilla.kernel.org/show_bug.cgi?id=6811

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 fs/cifs/connect.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6.18-rc2/fs/cifs/connect.c
===================================================================
--- linux-2.6.18-rc2.orig/fs/cifs/connect.c
+++ linux-2.6.18-rc2/fs/cifs/connect.c
@@ -182,6 +182,7 @@ cifs_reconnect(struct TCP_Server_Info *s
 
 	while ((server->tcpStatus != CifsExiting) && (server->tcpStatus != CifsGood))
 	{
+		try_to_freeze();
 		if(server->protocolType == IPV6) {
 			rc = ipv6_connect(&server->addr.sockAddr6,&server->ssocket);
 		} else {

