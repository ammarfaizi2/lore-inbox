Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266246AbUFPLen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266246AbUFPLen (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 07:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266247AbUFPLen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 07:34:43 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:58068 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S266246AbUFPLel convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 07:34:41 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: 'uinput' Oops upon select() or poll() on 2.6.7
References: <xb7ekp4cw4o.fsf@savona.informatik.uni-freiburg.de>
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 16 Jun 2004 13:34:39 +0200
Message-ID: <xb7wu27spm8.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Re-reporting this bug found 3  weeks ago, because it's still in 2.6.7.
(It was found and reported for 2.6.7-rc1.)

For details, please check the bugzilla entry

        http://bugzilla.kernel.org/show_bug.cgi?id=2786


Dmitry Torokhov has already offered a patch on 2004-05-28 12:52.

Vojtech Pavlik  said on 2004-05-28 13:59  that he has fixed  it in his
input tree.


But the bug is STILL in 2.6.7.  I don't understand.  What are the -rc*
supposed for, if bugs do not get fixed?



from Dmitry Torokhov  2004-05-28 12:52:

--- 2.6.6/drivers/input/misc/uinput.c	2004-05-11 14:57:25.793252800 -0500
+++ linux-2.6.6/drivers/input/misc/uinput.c	2004-05-28 14:42:36.922273600 -0500
@@ -279,10 +279,11 @@
 {
 	struct uinput_device *udev = file->private_data;
 
-	poll_wait(file, &udev->waitq, wait);
-
-	if (udev->head != udev->tail)
-		return POLLIN | POLLRDNORM;
+	if (test_bit(UIST_CREATED, &udev->state)) {
+		poll_wait(file, &udev->waitq, wait);
+		if (udev->head != udev->tail)
+			return POLLIN | POLLRDNORM;
+	}
 
 	return 0;
 }


-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

