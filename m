Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313508AbSDLK30>; Fri, 12 Apr 2002 06:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313509AbSDLK3Z>; Fri, 12 Apr 2002 06:29:25 -0400
Received: from wet.kiss.uni-lj.si ([193.2.98.10]:29457 "EHLO
	wet.kiss.uni-lj.si") by vger.kernel.org with ESMTP
	id <S313508AbSDLK3W>; Fri, 12 Apr 2002 06:29:22 -0400
Content-Type: text/plain;
  charset="iso-8859-2"
From: Rok =?iso-8859-2?q?Pape=BE?= <rok.papez@lugos.si>
Reply-To: rok.papez@lugos.si
To: linux-kernel@vger.kernel.org
Subject: Patch: Num/Caps_lock state - ioctl flags mixed up
Date: Fri, 12 Apr 2002 12:28:53 +0200
X-Mailer: KMail [version 1.2]
Cc: alan@redhat.com
MIME-Version: 1.0
Message-Id: <02041212285302.02754@strader.home>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

It look like the flags for setting the state of caps lock and num lock in kd.h
are mixed up. For setting just the LEDs (but not the state) they work OK.

-------------------- patch --------------------------------

--- 2.4.18/include/linux/kd.h	Thu Nov 22 20:47:07 2001
+++ 2.4.18-k_fix/include/linux/kd.h	Fri Apr 12 11:47:44 2002
@@ -26,8 +26,8 @@
 #define KDGETLED	0x4B31	/* return current led state */
 #define KDSETLED	0x4B32	/* set led state [lights, not flags] */
 #define 	LED_SCR		0x01	/* scroll lock led */
-#define 	LED_CAP		0x04	/* caps lock led */
 #define 	LED_NUM		0x02	/* num lock led */
+#define 	LED_CAP		0x04	/* caps lock led */
 
 #define KDGKBTYPE	0x4B33	/* get keyboard type */
 #define 	KB_84		0x01
@@ -89,8 +89,8 @@
 #define KDSKBMETA	0x4B63	/* sets meta key handling mode */
 
 #define		K_SCROLLLOCK	0x01
-#define		K_CAPSLOCK	0x02
-#define		K_NUMLOCK	0x04
+#define		K_NUMLOCK	0x02
+#define		K_CAPSLOCK	0x04
 #define	KDGKBLED	0x4B64	/* get led flags (not lights) */
 #define KDSKBLED	0x4B65	/* set led flags (not lights) */

-------------------- test app --------------------------------

#include <sys/ioctl.h>
#include <unistd.h>
#include <linux/kd.h>
#include <errno.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int param = 0;
  int rc;

  if(argc>1)
    param = atoi(argv[1]);

  switch(param) {
  case 1:
      param = K_CAPSLOCK;
      break;

  case 2:
      param = K_NUMLOCK;
      break;

  default:
      printf("parameter should be:\n\t- 1 for K_CAPSLOCK\n\t- 2 for K_NUMLOCK\n");
      return -1;
  } //~switch

  rc = ioctl(STDIN_FILENO, KDSKBLED, param);
  if(rc)
    printf("%s\n", strerror(errno));

  return 0;
}

-- 
best regards,
Rok Pape¾.
