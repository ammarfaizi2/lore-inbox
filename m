Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266793AbUIVTU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266793AbUIVTU3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 15:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266786AbUIVTU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 15:20:29 -0400
Received: from pointblue.com.pl ([81.219.144.6]:24585 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S266758AbUIVTUN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 15:20:13 -0400
Message-ID: <4151D03D.4030506@pointblue.com.pl>
Date: Wed, 22 Sep 2004 21:19:25 +0200
From: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] compilation fixes for gcc 4.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc 4.0 doesn't treat this extension as valid anymore.

one of the gcc guys said to me:
" For that matter, they could neatly avoid the whole issue by writing ANSI/ISO-compliant code instead of
             using GCC extensions."
That should be sufficient for explanation.

In all these cases, I see no reason to declare prototype inside body of function. 
It makes code less readable.

I am sure it's present in few more places, but that's the only place where I can spot it.
Please apply.


Signed-off-by: Grzegorz Jaskiewicz <gj at pointblue.com.pl>


--- drivers/input/joystick/grip_mp.c    2004-08-14 07:37:42 +0200
+++ /tmp/grip_mp.c      2004-09-22 20:58:40 +0200
@@ -107,6 +107,8 @@

 static int axis_map[] = { 5, 9, 1, 5, 6, 10, 2, 6, 4, 8, 0, 4, 5, 9, 1, 
5 };

+static void register_slot(int i, struct grip_mp *grip);
+
 /*
  * Returns whether an odd or even number of bits are on in pkt.
  */
@@ -355,7 +357,6 @@
        u32 packet;
        int joytype = 0;
        int slot = 0;
-       static void register_slot(int i, struct grip_mp *grip);

        /* Get a packet and check for validity */

