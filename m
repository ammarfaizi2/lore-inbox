Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131324AbRCSBtR>; Sun, 18 Mar 2001 20:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131327AbRCSBtG>; Sun, 18 Mar 2001 20:49:06 -0500
Received: from zrtps06s.nortelnetworks.com ([47.140.48.50]:54176 "EHLO
	zrtps06s.us.nortel.com") by vger.kernel.org with ESMTP
	id <S131324AbRCSBsw>; Sun, 18 Mar 2001 20:48:52 -0500
Message-ID: <3AB56376.FDFC5E23@asiapacificm01.nt.com>
Date: Mon, 19 Mar 2001 01:40:06 +0000
From: "Andrew Morton" <morton@nortelnetworks.com>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.4.2-ac19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: BERECZ Szabolcs <szabi@inf.elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BUG] kernel BUG at printk.c:458! -- 2.4.2-ac20
In-Reply-To: <Pine.A41.4.31.0103190047360.115440-100000@pandora.inf.elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <morton@asiapacificm01.nt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BERECZ Szabolcs wrote:
> 
> kernel BUG at printk.c:458!
> 

--- drivers/char/console.c.orig	Mon Mar 19 12:38:27 2001
+++ drivers/char/console.c	Mon Mar 19 12:38:49 2001
@@ -2305,6 +2305,9 @@
 {
 	struct vt_struct *vt = (struct vt_struct *)tty->driver_data;
 
+	if (in_interrupt())
+		return;
+
 	pm_access(pm_con);
 	acquire_console_sem();
 	set_cursor(vt->vc_num);
