Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbVDDGQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVDDGQM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 02:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVDDGOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 02:14:19 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:42844 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261435AbVDDGOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 02:14:03 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 2/4] ALPS resume fix
Date: Mon, 4 Apr 2005 01:11:49 -0500
User-Agent: KMail/1.8
Cc: LKML <linux-kernel@vger.kernel.org>,
       InputML <linux-input@atrey.karlin.mff.cuni.cz>,
       Andrew Morton <akpm@osdl.org>
References: <200504040110.13315.dtor_core@ameritech.net> <200504040111.11814.dtor_core@ameritech.net>
In-Reply-To: <200504040111.11814.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504040111.49402.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================

Input: ALPS needs to be reset for detection to work reliably when
       reconnecting.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 alps.c |    2 ++
 1 files changed, 2 insertions(+)

Index: dtor/drivers/input/mouse/alps.c
===================================================================
--- dtor.orig/drivers/input/mouse/alps.c
+++ dtor/drivers/input/mouse/alps.c
@@ -341,6 +341,8 @@ static int alps_reconnect(struct psmouse
 	unsigned char param[4];
 	int version;
 
+	psmouse_reset(psmouse);
+
 	if (!(priv->i = alps_get_model(psmouse, &version)))
 		return -1;
 
