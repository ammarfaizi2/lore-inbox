Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVCCWtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVCCWtS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 17:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbVCCWpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 17:45:55 -0500
Received: from rusty.kulnet.kuleuven.ac.be ([134.58.240.42]:57008 "EHLO
	rusty.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S262678AbVCCWnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 17:43:10 -0500
Message-ID: <4227928B.7030004@mech.kuleuven.ac.be>
Date: Thu, 03 Mar 2005 23:41:15 +0100
From: Panagiotis Issaris <panagiotis.issaris@mech.kuleuven.ac.be>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jody McIntyre <scjody@modernduck.com>
Cc: dtor_core@ameritech.net, Anton Altaparmakov <aia21@cam.ac.uk>,
       lkml <linux-kernel@vger.kernel.org>,
       linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH] raw1394 missing failure handling
References: <d120d500050302062451cc2af3@mail.gmail.com> <4225CDEF.4070501@mech.kuleuven.ac.be> <20050303214843.GQ1111@conscoop.ottawa.on.ca>
In-Reply-To: <20050303214843.GQ1111@conscoop.ottawa.on.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Jody McIntyre wrote:

>I'll apply this to the 1394 tree and send it to Linus after testing if
>you add a Signed-off-by: line per Documentation/SubmittingPatches .
>Also, please cc linux1394-devel@lists.sourceforge.net with ieee1394
>changes.
>
Sure! Thanks!


Adds the missing failure handling for a __copy_to_user call.


Signed-off-by: Panagiotis Issaris <takis@gna.org>

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



-- 
  K.U.Leuven, Mechanical Eng.,  Mechatronics & Robotics Research Group
  http://people.mech.kuleuven.ac.be/~pissaris/

