Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbTJDHXK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 03:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbTJDHXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 03:23:10 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:36009 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261929AbTJDHXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 03:23:07 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] input: do not suppress 0 value relative events
Date: Sat, 4 Oct 2003 02:22:57 -0500
User-Agent: KMail/1.5.4
Cc: Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310040223.01664.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Input: input susbsystem should not drop 0 value relative events,
         otherwise unsuspecting programs will loose transitions from
         non-zero to 0 deltas. We should not require userland authors
         to consult with kernel implementation details all the time,
         but follow the principle of least surprise and report
         everything.


 input.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/input/input.c b/drivers/input/input.c
--- a/drivers/input/input.c	Sat Oct  4 02:20:18 2003
+++ b/drivers/input/input.c	Sat Oct  4 02:20:18 2003
@@ -134,7 +134,7 @@
 
 		case EV_REL:
 
-			if (code > REL_MAX || !test_bit(code, dev->relbit) || (value == 0))
+			if (code > REL_MAX || !test_bit(code, dev->relbit))
 				return;
 
 			break;



