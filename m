Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262945AbTEVSC1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 14:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262964AbTEVSC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 14:02:27 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:57297 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S262945AbTEVSCX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 14:02:23 -0400
Date: Thu, 22 May 2003 20:15:14 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Simon Kelley <simon@thekelleys.org.uk>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, jt@hpl.hp.com,
       Pavel Roskin <proski@gnu.org>, Oliver Neukum <oliver@neukum.org>,
       David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Re: request_firmware() hotplug interface, third round and a halve
Message-ID: <20030522181514.GA20203@ranty.ddts.net>
Reply-To: ranty@debian.org
References: <20030517221921.GA28077@ranty.ddts.net> <20030521072318.GA12973@kroah.com> <20030521185212.GC12677@ranty.ddts.net> <20030521200736.GA2606@kroah.com> <20030522153154.GD13224@ranty.ddts.net> <3ECD0F8A.5080409@thekelleys.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <3ECD0F8A.5080409@thekelleys.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 22, 2003 at 06:57:30PM +0100, Simon Kelley wrote:
> Works great for me now.
> 
> It's noisy: I'd remove/disable the printks in firmware_data_read and 
> firmware_data_write
> before it goes in.

 I'd rather not resend it all again.
 
 Attached goes an incremental patch just in case, but I don't mind
 resending it later, once the bulk of it goes in.

 Have a nice day

 	Manuel

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.

--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="revised-noise.diff"

--- drivers/base/firmware_class.c	2003/05/22 14:49:44	1.14
+++ drivers/base/firmware_class.c	2003/05/22 18:07:38
@@ -152,8 +152,6 @@
 	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
 	struct firmware *fw = fw_priv->fw;
 
-	printk("%s: count:%d offset:%lld\n", __FUNCTION__, count, offset);
-
 	if (offset > fw->size)
 		return 0;
 	if (offset + count > fw->size)
@@ -204,12 +202,9 @@
 	struct firmware *fw = fw_priv->fw;
 	int retval;
 
-	printk("%s: count:%d offset:%lld\n", __FUNCTION__, count, offset);
 	retval = fw_realloc_buffer(fw_priv, offset + count);
-	if (retval) {
-		printk("%s: retval:%d\n", __FUNCTION__, retval);
+	if (retval)
 		return retval;
-	}
 
 	memcpy(fw->data + offset, buffer, count);
 

--OgqxwSJOaUobr8KG--
