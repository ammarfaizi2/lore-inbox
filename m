Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262284AbVCBMdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbVCBMdV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 07:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbVCBMdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 07:33:21 -0500
Received: from spoetnik.kulnet.kuleuven.ac.be ([134.58.240.46]:10178 "EHLO
	spoetnik.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S262284AbVCBMdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 07:33:14 -0500
Message-ID: <4225B167.3030903@mech.kuleuven.ac.be>
Date: Wed, 02 Mar 2005 13:28:23 +0100
From: Panagiotis Issaris <panagiotis.issaris@mech.kuleuven.ac.be>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] raw1394 missing failure handling
References: <42259F3A.8000206@mech.kuleuven.ac.be> <1109763232.12379.6.camel@imp.csi.cam.ac.uk>
In-Reply-To: <1109763232.12379.6.camel@imp.csi.cam.ac.uk>
Content-Type: multipart/mixed;
 boundary="------------090608090607080004000202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090608090607080004000202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Anton Altaparmakov wrote:

>On Wed, 2005-03-02 at 12:10 +0100, Panagiotis Issaris wrote:
>  
>
>>In the raw1394 driver the failure handling for
>>a __copy_to_user call is missing.
>>    
>>
>
>Your patch is obviously incorrect as it doesn't free the request before
>it returns.
>  
>
Oops. Thanks for replying! Any more problems with the updated
patch?

With friendly regards,
Takis

-- 
  K.U.Leuven, Mechanical Eng.,  Mechatronics & Robotics Research Group
  http://people.mech.kuleuven.ac.be/~pissaris/


--------------090608090607080004000202
Content-Type: text/x-patch;
 name="pi-20050302T131628-linux_2_6_11-1394_copy_to_user_failure_handling.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pi-20050302T131628-linux_2_6_11-1394_copy_to_user_failure_handling.diff"

diff -pruN linux-2.6.11/drivers/ieee1394/raw1394.c linux-2.6.11-pi/drivers/ieee1394/raw1394.c
--- linux-2.6.11/drivers/ieee1394/raw1394.c	2005-03-02 11:44:26.000000000 +0100
+++ linux-2.6.11-pi/drivers/ieee1394/raw1394.c	2005-03-02 13:15:58.000000000 +0100
@@ -443,7 +443,11 @@ static ssize_t raw1394_read(struct file 
                         req->req.error = RAW1394_ERROR_MEMFAULT;
                 }
         }
-        __copy_to_user(buffer, &req->req, sizeof(req->req));
+        if (__copy_to_user(buffer, &req->req, sizeof(req->req)))
+        {
+                free_pending_request(req);
+                return -EFAULT;
+        }
 
         free_pending_request(req);
         return sizeof(struct raw1394_request);

--------------090608090607080004000202--
