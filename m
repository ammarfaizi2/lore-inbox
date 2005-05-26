Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVEZFaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVEZFaw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 01:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVEZFaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 01:30:52 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:1261 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261214AbVEZF3h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 01:29:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=n2ssQMJM9eFT1665yTr8BRbS1/2wiT8QgrOcj/60feONxzmJhCZ+l10pZT7/Nn7ttwQGp+euwEQAk5V0r4nrQfyH1VwE+qPAWmIoOUI4g3m8MAsaHYtMKfxD/T1VOWB7vFATGtdrWicLAnWgal5hrOzZ4CydiLwsLSIxUYWWRfM=
Message-ID: <2538186705052522294fd2324f@mail.gmail.com>
Date: Thu, 26 May 2005 01:29:37 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc5-mm1
Cc: Brice Goglin <Brice.Goglin@ens-lyon.org>, linux-kernel@vger.kernel.org
In-Reply-To: <4294F4EB.7010903@ens-lyon.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_24_13624929.1117085377333"
References: <20050525134933.5c22234a.akpm@osdl.org>
	 <4294F4EB.7010903@ens-lyon.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_24_13624929.1117085377333
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Andrew,

This patch updates all the device attribute callbacks that weren't
updated with the new parameter, I guess because they weren't in Greg's
tree (including drivers/pcmcia/ds.c). Without the patch these
callbacks are probably broken (and generate a warning along the lines
of "assignment from incompatible pointer type").

Please see http://lkml.org/lkml/2005/5/19/40 for the scripts I used to
update the attributes automatically.

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

Thanks,
Yani
=20
  char/tpm/tpm.c         |    2 +-
  char/tpm/tpm.h         |    8 ++++----
  message/i2o/bus-osm.c  |    2 +-
  message/i2o/exec-osm.c |    4 ++--
  pcmcia/ds.c            |    2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

------=_Part_24_13624929.1117085377333
Content-Type: text/x-patch; 
	name=patch-linux-2.6.12-rc5-mm1-devattrupdate.diff; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-linux-2.6.12-rc5-mm1-devattrupdate.diff"

diff -uprN -X dontdiff linux-2.6.12-rc5-mm1/drivers/char/tpm/tpm.c linux-2.6.12-rc5-mm1-update/drivers/char/tpm/tpm.c
--- linux-2.6.12-rc5-mm1/drivers/char/tpm/tpm.c	2005-05-26 01:13:02.000000000 -0400
+++ linux-2.6.12-rc5-mm1-update/drivers/char/tpm/tpm.c	2005-05-26 01:17:58.000000000 -0400
@@ -299,7 +299,7 @@ ssize_t show_caps(struct device *dev, st
 
 EXPORT_SYMBOL_GPL(tpm_show_caps);
 
-ssize_t tpm_store_cancel(struct device * dev, const char *buf,
+ssize_t tpm_store_cancel(struct device * dev, struct device_attribute *attr, const char *buf,
 			 size_t count)
 {
 	struct tpm_chip *chip = dev_get_drvdata(dev);
diff -uprN -X dontdiff linux-2.6.12-rc5-mm1/drivers/char/tpm/tpm.h linux-2.6.12-rc5-mm1-update/drivers/char/tpm/tpm.h
--- linux-2.6.12-rc5-mm1/drivers/char/tpm/tpm.h	2005-05-26 01:13:02.000000000 -0400
+++ linux-2.6.12-rc5-mm1-update/drivers/char/tpm/tpm.h	2005-05-26 01:17:58.000000000 -0400
@@ -35,10 +35,10 @@ enum tpm_addr {
 	TPM_DATA = 0x4F
 };
 
-extern ssize_t tpm_show_pubek(struct device *, char *);
-extern ssize_t tpm_show_pcrs(struct device *, char *);
-extern ssize_t tpm_show_caps(struct device *, char *);
-extern ssize_t tpm_store_cancel(struct device *, const char *, size_t);
+extern ssize_t tpm_show_pubek(struct device *, struct device_attribute *attr, char *);
+extern ssize_t tpm_show_pcrs(struct device *, struct device_attribute *attr, char *);
+extern ssize_t tpm_show_caps(struct device *, struct device_attribute *attr, char *);
+extern ssize_t tpm_store_cancel(struct device *, struct device_attribute *attr, const char *, size_t);
 
 
 struct tpm_chip;
diff -uprN -X dontdiff linux-2.6.12-rc5-mm1/drivers/message/i2o/bus-osm.c linux-2.6.12-rc5-mm1-update/drivers/message/i2o/bus-osm.c
--- linux-2.6.12-rc5-mm1/drivers/message/i2o/bus-osm.c	2005-05-26 01:13:13.000000000 -0400
+++ linux-2.6.12-rc5-mm1-update/drivers/message/i2o/bus-osm.c	2005-05-26 01:18:14.000000000 -0400
@@ -59,7 +59,7 @@ static int i2o_bus_scan(struct i2o_devic
  *
  *	Returns count.
  */
-static ssize_t i2o_bus_store_scan(struct device *d, const char *buf,
+static ssize_t i2o_bus_store_scan(struct device *d, struct device_attribute *attr, const char *buf,
 				  size_t count)
 {
 	struct i2o_device *i2o_dev = to_i2o_device(d);
diff -uprN -X dontdiff linux-2.6.12-rc5-mm1/drivers/message/i2o/exec-osm.c linux-2.6.12-rc5-mm1-update/drivers/message/i2o/exec-osm.c
--- linux-2.6.12-rc5-mm1/drivers/message/i2o/exec-osm.c	2005-05-26 01:13:13.000000000 -0400
+++ linux-2.6.12-rc5-mm1-update/drivers/message/i2o/exec-osm.c	2005-05-26 01:18:14.000000000 -0400
@@ -261,7 +261,7 @@ static int i2o_msg_post_wait_complete(st
  *
  *	Returns number of bytes printed into buffer.
  */
-static ssize_t i2o_exec_show_vendor_id(struct device *d, char *buf)
+static ssize_t i2o_exec_show_vendor_id(struct device *d, struct device_attribute *attr, char *buf)
 {
 	struct i2o_device *dev = to_i2o_device(d);
 	u16 id;
@@ -281,7 +281,7 @@ static ssize_t i2o_exec_show_vendor_id(s
  *
  *	Returns number of bytes printed into buffer.
  */
-static ssize_t i2o_exec_show_product_id(struct device *d, char *buf)
+static ssize_t i2o_exec_show_product_id(struct device *d, struct device_attribute *attr, char *buf)
 {
 	struct i2o_device *dev = to_i2o_device(d);
 	u16 id;
diff -uprN -X dontdiff linux-2.6.12-rc5-mm1/drivers/pcmcia/ds.c linux-2.6.12-rc5-mm1-update/drivers/pcmcia/ds.c
--- linux-2.6.12-rc5-mm1/drivers/pcmcia/ds.c	2005-05-26 01:13:13.000000000 -0400
+++ linux-2.6.12-rc5-mm1-update/drivers/pcmcia/ds.c	2005-05-26 01:18:15.000000000 -0400
@@ -848,7 +848,7 @@ pcmcia_device_stringattr(prod_id3, prod_
 pcmcia_device_stringattr(prod_id4, prod_id[3]);
 
 
-static ssize_t pcmcia_store_allow_func_id_match (struct device * dev, const char * buf, size_t count)
+static ssize_t pcmcia_store_allow_func_id_match (struct device * dev, struct device_attribute *attr, const char * buf, size_t count)
 {
 	struct pcmcia_device *p_dev = to_pcmcia_dev(dev);
         if (!count)

------=_Part_24_13624929.1117085377333--
