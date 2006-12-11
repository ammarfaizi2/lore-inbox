Return-Path: <linux-kernel-owner+w=401wt.eu-S937392AbWLKSB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937392AbWLKSB7 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 13:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937406AbWLKSB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 13:01:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44089 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937392AbWLKSB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 13:01:58 -0500
Message-ID: <457D9D14.5090006@redhat.com>
Date: Mon, 11 Dec 2006 19:01:56 +0100
From: Florian Festi <ffesti@redhat.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] input: Extend raw mode to work up to keycode 0xFF
Content-Type: multipart/mixed;
 boundary="------------010505080303060602060604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010505080303060602060604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi, [please CC me, as I am not subscribed]

currently keycodes above 240 are ignored if the tty is in raw mode. To make the key codes from 241 to 255 usable for programs in raw mode (like X11) the still unused scancodes were 
added into that range. Right know these scancodes are used in arbitrary order due the lack of a better alternative. Comments on a better way of using them are welcome.

This extension is needed for some keycodes I submited in a previous patch.

Florian

--------------010505080303060602060604
Content-Type: text/x-patch;
 name="rawmodeemulation.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rawmodeemulation.diff"

diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
index 7a6c1c0..33a1aef 100644
--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -1043,7 +1043,8 @@ static const unsigned short x86_keycodes
 	264,117,271,374,379,265,266, 93, 94, 95, 85,259,375,260, 90,116,
 	377,109,111,277,278,282,283,295,296,297,299,300,301,293,303,307,
 	308,310,313,314,315,317,318,319,320,357,322,323,324,325,276,330,
-	332,340,365,342,343,344,345,346,356,270,341,368,369,370,371,372 };
+	332,340,365,342,343,344,345,346,356,270,341,368,369,370,371,372,
+	 96, 97, 98,110,122,124,127,256,273,298,311,366,378,380,382,383 }; 
 
 #ifdef CONFIG_MAC_EMUMOUSEBTN
 extern int mac_hid_mouse_emulate_buttons(int, int, int);

--------------010505080303060602060604--
