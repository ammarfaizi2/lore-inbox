Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263769AbUFBRvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbUFBRvv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 13:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263756AbUFBRvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 13:51:51 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:54976 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S263769AbUFBRuL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 13:50:11 -0400
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serio.c: dynamically control serio ports bindings via procfs
References: <xb74qpt6ffv.fsf_-_@savona.informatik.uni-freiburg.de> <xb7d64i5lxb.fsf@savona.informatik.uni-freiburg.de>
	<200406020733.22737.dtor_core@ameritech.net>
In-Reply-To: <xb74qpt6ffv.fsf_-_@savona.informatik.uni-freiburg.de>
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 02 Jun 2004 19:49:44 +0200
Message-ID: <xb7zn7l4zpj.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The name fix  on serio devices is as simply  as the following example,
which can be applied to the  'atkbd' module.  We just need to add back
the  .name field  to the  'struct serio_dev'.   My previous  patch can
detect this and use the meaningful name immediately!



--- linux-2.6.7-rc1/drivers/input/keyboard/atkbd.c	2004/06/01 07:45:00	1.2
+++ linux-2.6.7-rc1.name-fix/drivers/input/keyboard/atkbd.c	2004/06/02 17:44:47
@@ -818,20 +818,21 @@
 		atkbd_enable(atkbd);
 
 		if (atkbd_command(atkbd, param, ATKBD_CMD_SETLEDS))
 			return -1;
 	}
 
 	return 0;
 }
 
 static struct serio_dev atkbd_dev = {
+	.name = "atkbd",
 	.interrupt =	atkbd_interrupt,
 	.connect =	atkbd_connect,
 	.reconnect = 	atkbd_reconnect,
 	.disconnect =	atkbd_disconnect,
 	.cleanup =	atkbd_cleanup,
 };
 
 int __init atkbd_init(void)
 {
 	serio_register_device(&atkbd_dev);




-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

