Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265742AbUBJPd3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 10:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265745AbUBJPd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 10:33:29 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:4993 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S265742AbUBJPd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 10:33:27 -0500
From: Michael Frank <mhf@linuxmail.org>
Subject: Fwd: [Swsusp-devel] Kernel 2.6 pm_send_all() issues.
Date: Tue, 10 Feb 2004 23:43:06 +0800
User-Agent: KMail/1.5.4
To: linux-kernel@vger.kernel.org
Cc: Wolfgang Glas <wolfgang.glas@ev-i.at>, swsusp-devel@lists.sourceforge.net
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402102343.06896.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This question is probably better suited for LKML.

----------  Forwarded Message  ----------

Subject: [Swsusp-devel] Kernel 2.6 pm_send_all() issues.
Date: Tuesday 10 February 2004 04:06
From: Wolfgang Glas <wolfgang.glas@ev-i.at>
To: swsusp-devel@lists.sourceforge.net

Coming back to an earlier post, which states, that NVidia suspend/resume under 
2.6.x could be resurrected, if  drivers_suspend() and drivers_resume() in 
swsusp.c are tuned in a way, that pm_send_all() is called, I want to direct 
the following question to more eligible persons in this list:

  I inspected NVidia's driver and I found out, that it's implemented as a 
character device and hence does not implement the suspend/resume kernel 
driver interface, which has been introduced in linux-2.6. But nevertheless 
this driver has the ability to register its own power management handler 
through pm_register(), an interface already present in linux-2.4 and still 
used in some 20 drivers present in the linux-2.6.1 code base, most notable 
some audio driver and some irda drivers.

  Diving further into the code, I recognized, that the kernel function 
ppm_send_all(), which calls all handlers registered through pm_register() is 
never called inside of swsusp2.c

  So, what I want to ask is, whether the pm_register/pm_send/pm_send_all 
interface is simply deprecated and the NVidia driver (and other drivers, 
which use pm_register) should be reeingineered in order to use the 
resume/suspend interface of linux-2.6. Or should we try to modify swsusp2.c 
in a way, that it additionally calls  pm_send_all for these drivers?

   TIA,

      Wolfgang


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
swsusp-devel mailing list
swsusp-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/swsusp-devel



-------------------------------------------------------

