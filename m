Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292229AbSDEAlF>; Thu, 4 Apr 2002 19:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292588AbSDEAkz>; Thu, 4 Apr 2002 19:40:55 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:21134 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S292229AbSDEAks>; Thu, 4 Apr 2002 19:40:48 -0500
Message-ID: <3CACF1FF.2000508@us.ibm.com>
Date: Thu, 04 Apr 2002 16:38:23 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Romain Lievin <roms@lpg.ticalc.org>, Julien BLACHE <jb@technologeek.org>
CC: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: BKL in tiglusb release function
Content-Type: multipart/mixed;
 boundary="------------030707070207000702040005"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030707070207000702040005
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Is there a reason for the BKL to be used in tiglusb_release()?  Are you 
worried about a race between open and release, or were you just 
following examples from other code?

I'm sure we can remove it safely.  We might need another lock, but it 
won't be much.

-- 
Dave Hansen
haveblue@us.ibm.com

--------------030707070207000702040005
Content-Type: text/plain;
 name="tiglusb-bkl_remove-2.5.8-pre1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tiglusb-bkl_remove-2.5.8-pre1.patch"

--- linux-2.5.8-pre1-clean/drivers/usb/tiglusb.c	Thu Apr  4 08:58:26 2002
+++ linux/drivers/usb/tiglusb.c	Thu Apr  4 16:29:31 2002
@@ -128,7 +128,6 @@
 {
 	ptiglusb_t s = (ptiglusb_t) file->private_data;
 
-	lock_kernel ();
 	down (&s->mutex);
 	s->state = _stopped;
 	up (&s->mutex);
@@ -139,7 +138,6 @@
 		wake_up (&s->remove_ok);
 
 	s->opened = 0;
-	unlock_kernel ();
 
 	return 0;
 }

--------------030707070207000702040005--

