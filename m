Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVEYV6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVEYV6P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 17:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVEYV6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 17:58:15 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:35218 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261291AbVEYV6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 17:58:09 -0400
Message-ID: <4294F4EB.7010903@ens-lyon.org>
Date: Wed, 25 May 2005 23:58:03 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc5-mm1
References: <20050525134933.5c22234a.akpm@osdl.org>
In-Reply-To: <20050525134933.5c22234a.akpm@osdl.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------010307030701070300090805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010307030701070300090805
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Andrew Morton a écrit :
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc5/2.6.12-rc5-mm1/

Hi Andrew,

drivers/pcmcia/ds.c defines pcmcia_store_allow_func_id_match
without the new "struct device_attribute *attr" argument.
The attached patch fixes this.

Signed-off-by: Brice Goglin <Brice.Goglin@ens-lyon.org>

Regards,
Brice

--------------010307030701070300090805
Content-Type: text/x-patch;
 name="fix-pcmcia-ds-device-attribute.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-pcmcia-ds-device-attribute.patch"

--- linux-mm/drivers/pcmcia/ds.c.old	2005-05-25 23:54:03.000000000 +0200
+++ linux-mm/drivers/pcmcia/ds.c	2005-05-25 23:54:25.000000000 +0200
@@ -848,7 +848,8 @@ pcmcia_device_stringattr(prod_id3, prod_
 pcmcia_device_stringattr(prod_id4, prod_id[3]);
 
 
-static ssize_t pcmcia_store_allow_func_id_match (struct device * dev, const char * buf, size_t count)
+static ssize_t pcmcia_store_allow_func_id_match (struct device * dev, struct device_attribute *attr,
+						 const char * buf, size_t count)
 {
 	struct pcmcia_device *p_dev = to_pcmcia_dev(dev);
         if (!count)

--------------010307030701070300090805--
