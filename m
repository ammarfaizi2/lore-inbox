Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262302AbVCBOcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262302AbVCBOcZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 09:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262315AbVCBObv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 09:31:51 -0500
Received: from spoetnik.kulnet.kuleuven.ac.be ([134.58.240.46]:49073 "EHLO
	spoetnik.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S262322AbVCBOaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 09:30:09 -0500
Message-ID: <4225CDEF.4070501@mech.kuleuven.ac.be>
Date: Wed, 02 Mar 2005 15:30:07 +0100
From: Panagiotis Issaris <panagiotis.issaris@mech.kuleuven.ac.be>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dtor_core@ameritech.net
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] raw1394 missing failure handling
References: <42259F3A.8000206@mech.kuleuven.ac.be>	 <1109763232.12379.6.camel@imp.csi.cam.ac.uk>	 <4225B167.3030903@mech.kuleuven.ac.be> <d120d500050302062451cc2af3@mail.gmail.com>
In-Reply-To: <d120d500050302062451cc2af3@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------070707030402080702090508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070707030402080702090508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Dmitry Torokhov wrote:

>On Wed, 02 Mar 2005 13:28:23 +0100, Panagiotis Issaris
><panagiotis.issaris@mech.kuleuven.ac.be> wrote:
>  
>
>>Oops. Thanks for replying! Any more problems with the updated
>>patch?
>>    
>>
>Formatting... Opening curly brace should go on the same line with "if".
>  
>
Thanks. Here's my third try :-)

With friendly regards,
Takis

-- 
  K.U.Leuven, Mechanical Eng.,  Mechatronics & Robotics Research Group
  http://people.mech.kuleuven.ac.be/~pissaris/


--------------070707030402080702090508
Content-Type: text/x-patch;
 name="pi-20050302T152730-linux_2_6_11-1394_copy_to_user_failure_handling_3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pi-20050302T152730-linux_2_6_11-1394_copy_to_user_failure_handling_3.diff"

diff -pruN linux-2.6.11/drivers/ieee1394/raw1394.c linux-2.6.11-pi/drivers/ieee1394/raw1394.c
--- linux-2.6.11/drivers/ieee1394/raw1394.c	2005-03-02 11:44:26.000000000 +0100
+++ linux-2.6.11-pi/drivers/ieee1394/raw1394.c	2005-03-02 15:27:15.000000000 +0100
@@ -443,7 +443,10 @@ static ssize_t raw1394_read(struct file 
                         req->req.error = RAW1394_ERROR_MEMFAULT;
                 }
         }
-        __copy_to_user(buffer, &req->req, sizeof(req->req));
+        if (__copy_to_user(buffer, &req->req, sizeof(req->req))) {
+                free_pending_request(req);
+                return -EFAULT;
+        }
 
         free_pending_request(req);
         return sizeof(struct raw1394_request);

--------------070707030402080702090508--
