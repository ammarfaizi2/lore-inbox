Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264361AbRGDMg5>; Wed, 4 Jul 2001 08:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264375AbRGDMgr>; Wed, 4 Jul 2001 08:36:47 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:26131 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S264361AbRGDMgk>; Wed, 4 Jul 2001 08:36:40 -0400
Date: Wed, 4 Jul 2001 13:36:34 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: parport_pc tries to load parport_serial automatically
Message-ID: <20010704133634.F5254@redhat.com>
In-Reply-To: <20010626162102.F7663@redhat.com> <Pine.LNX.4.21.0106270732160.1331-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0106270732160.1331-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Wed, Jun 27, 2001 at 07:32:42AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2001 at 07:32:42AM -0300, Marcelo Tosatti wrote:

> Could you remove the request_module() from parport_pc ? 

Yes.

Here is a patch against 2.4.5-ac24.

Tim.
*/

2001-07-04  Tim Waugh  <twaugh@redhat.com>

	* drivers/parport/parport_pc.c: Don't load parport_serial.
	* drivers/parport/ChangeLog: Updated.

--- linux/drivers/parport/parport_pc.c.orig	Wed Jul  4 13:30:01 2001
+++ linux/drivers/parport/parport_pc.c	Wed Jul  4 13:30:26 2001
@@ -2931,11 +2931,6 @@
 	if (ret && registered_parport)
 		pci_unregister_driver (&parport_pc_pci_driver);
 
-#ifdef CONFIG_PARPORT_SERIAL_MODULE
-	if (!ret)
-		request_module ("parport_serial");
-#endif
-
 	return ret;
 }
 
--- linux/drivers/parport/ChangeLog.orig	Wed Jul  4 13:30:32 2001
+++ linux/drivers/parport/ChangeLog	Wed Jul  4 13:32:01 2001
@@ -0,0 +1,6 @@
+2001-07-04  Tim Waugh  <twaugh@redhat.com>
+
+	* parport_pc.c (init_module): Don't try to load parport_serial.
+	This means that the user needs to load it (or a hardware detection
+	program on their behalf) if necessary.
+
