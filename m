Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267186AbUJTAxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267186AbUJTAxa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 20:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266896AbUJTAwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 20:52:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:7860 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267186AbUJTATa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 20:19:30 -0400
Subject: Re: [PATCH] I2C update for 2.6.9
In-Reply-To: <10982315033970@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 19 Oct 2004 17:18:23 -0700
Message-Id: <10982315034183@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1832.73.2, 2004/09/08 12:34:06-07:00, castet.matthieu@free.fr

[PATCH] use of MODULE_DEVICE_TABLE in i2c busses driver

hello,
since you say your are interested of using MODULE_DEVICE_TABLE in
http://bugzilla.kernel.org/show_bug.cgi?id=3091 I did a patch (attach).

Also I notice that some pci_device_id are marked __devinitdata that seem a bug
if I read Linux 2.6.0-test3 changelog.
To find them do a "grep pci_device_id  /usr/src/linux/drivers/i2c/busses/* |
grep __devinitdata"


Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/i2c-ali1535.c   |    2 ++
 drivers/i2c/busses/i2c-ali1563.c   |    2 ++
 drivers/i2c/busses/i2c-ali15x3.c   |    2 ++
 drivers/i2c/busses/i2c-amd756.c    |    2 ++
 drivers/i2c/busses/i2c-amd8111.c   |    2 ++
 drivers/i2c/busses/i2c-hydra.c     |    2 ++
 drivers/i2c/busses/i2c-i801.c      |    2 ++
 drivers/i2c/busses/i2c-i810.c      |    2 ++
 drivers/i2c/busses/i2c-nforce2.c   |    3 +++
 drivers/i2c/busses/i2c-piix4.c     |    2 ++
 drivers/i2c/busses/i2c-prosavage.c |    2 ++
 drivers/i2c/busses/i2c-savage4.c   |    2 ++
 drivers/i2c/busses/i2c-sis5595.c   |    2 ++
 drivers/i2c/busses/i2c-sis630.c    |    2 ++
 drivers/i2c/busses/i2c-sis96x.c    |    2 ++
 drivers/i2c/busses/i2c-via.c       |    2 ++
 drivers/i2c/busses/i2c-viapro.c    |    2 ++
 drivers/i2c/busses/i2c-voodoo3.c   |    2 ++
 18 files changed, 37 insertions(+)


diff -Nru a/drivers/i2c/busses/i2c-ali1535.c b/drivers/i2c/busses/i2c-ali1535.c
--- a/drivers/i2c/busses/i2c-ali1535.c	2004-10-19 16:55:57 -07:00
+++ b/drivers/i2c/busses/i2c-ali1535.c	2004-10-19 16:55:57 -07:00
@@ -496,6 +496,8 @@
 	{ },
 };
 
+MODULE_DEVICE_TABLE (pci, ali1535_ids);
+
 static int __devinit ali1535_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	if (ali1535_setup(dev)) {
diff -Nru a/drivers/i2c/busses/i2c-ali1563.c b/drivers/i2c/busses/i2c-ali1563.c
--- a/drivers/i2c/busses/i2c-ali1563.c	2004-10-19 16:55:57 -07:00
+++ b/drivers/i2c/busses/i2c-ali1563.c	2004-10-19 16:55:57 -07:00
@@ -394,6 +394,8 @@
 	{},
 };
 
+MODULE_DEVICE_TABLE (pci, ali1563_id_table);
+
 static struct pci_driver ali1563_pci_driver = {
  	.name		= "ali1563_i2c",
 	.id_table	= ali1563_id_table,
diff -Nru a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
--- a/drivers/i2c/busses/i2c-ali15x3.c	2004-10-19 16:55:57 -07:00
+++ b/drivers/i2c/busses/i2c-ali15x3.c	2004-10-19 16:55:57 -07:00
@@ -486,6 +486,8 @@
 	{ 0, }
 };
 
+MODULE_DEVICE_TABLE (pci, ali15x3_ids);
+
 static int __devinit ali15x3_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	if (ali15x3_setup(dev)) {
diff -Nru a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
--- a/drivers/i2c/busses/i2c-amd756.c	2004-10-19 16:55:57 -07:00
+++ b/drivers/i2c/busses/i2c-amd756.c	2004-10-19 16:55:57 -07:00
@@ -320,6 +320,8 @@
 	{ 0, }
 };
 
+MODULE_DEVICE_TABLE (pci, amd756_ids);
+
 static int __devinit amd756_probe(struct pci_dev *pdev,
 				  const struct pci_device_id *id)
 {
diff -Nru a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
--- a/drivers/i2c/busses/i2c-amd8111.c	2004-10-19 16:55:57 -07:00
+++ b/drivers/i2c/busses/i2c-amd8111.c	2004-10-19 16:55:57 -07:00
@@ -336,6 +336,8 @@
 	{ 0, }
 };
 
+MODULE_DEVICE_TABLE (pci, amd8111_ids);
+
 static int __devinit amd8111_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct amd_smbus *smbus;
diff -Nru a/drivers/i2c/busses/i2c-hydra.c b/drivers/i2c/busses/i2c-hydra.c
--- a/drivers/i2c/busses/i2c-hydra.c	2004-10-19 16:55:57 -07:00
+++ b/drivers/i2c/busses/i2c-hydra.c	2004-10-19 16:55:57 -07:00
@@ -120,6 +120,8 @@
 	{ 0, }
 };
 
+MODULE_DEVICE_TABLE (pci, hydra_ids);
+
 static int __devinit hydra_probe(struct pci_dev *dev,
 				 const struct pci_device_id *id)
 {
diff -Nru a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
--- a/drivers/i2c/busses/i2c-i801.c	2004-10-19 16:55:57 -07:00
+++ b/drivers/i2c/busses/i2c-i801.c	2004-10-19 16:55:57 -07:00
@@ -599,6 +599,8 @@
 	{ 0, }
 };
 
+MODULE_DEVICE_TABLE (pci, i801_ids);
+
 static int __devinit i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 
diff -Nru a/drivers/i2c/busses/i2c-i810.c b/drivers/i2c/busses/i2c-i810.c
--- a/drivers/i2c/busses/i2c-i810.c	2004-10-19 16:55:57 -07:00
+++ b/drivers/i2c/busses/i2c-i810.c	2004-10-19 16:55:57 -07:00
@@ -201,6 +201,8 @@
 	{ 0, },
 };
 
+MODULE_DEVICE_TABLE (pci, i810_ids);
+
 static int __devinit i810_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	int retval;
diff -Nru a/drivers/i2c/busses/i2c-nforce2.c b/drivers/i2c/busses/i2c-nforce2.c
--- a/drivers/i2c/busses/i2c-nforce2.c	2004-10-19 16:55:57 -07:00
+++ b/drivers/i2c/busses/i2c-nforce2.c	2004-10-19 16:55:57 -07:00
@@ -298,6 +298,9 @@
 };
 
 
+MODULE_DEVICE_TABLE (pci, nforce2_ids);
+
+
 static int __devinit nforce2_probe_smb (struct pci_dev *dev, int reg,
 	struct nforce2_smbus *smbus, char *name)
 {
diff -Nru a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	2004-10-19 16:55:57 -07:00
+++ b/drivers/i2c/busses/i2c-piix4.c	2004-10-19 16:55:57 -07:00
@@ -459,6 +459,8 @@
 	{ 0, }
 };
 
+MODULE_DEVICE_TABLE (pci, piix4_ids);
+
 static int __devinit piix4_probe(struct pci_dev *dev,
 				const struct pci_device_id *id)
 {
diff -Nru a/drivers/i2c/busses/i2c-prosavage.c b/drivers/i2c/busses/i2c-prosavage.c
--- a/drivers/i2c/busses/i2c-prosavage.c	2004-10-19 16:55:57 -07:00
+++ b/drivers/i2c/busses/i2c-prosavage.c	2004-10-19 16:55:57 -07:00
@@ -313,6 +313,8 @@
 	{ 0, },
 };
 
+MODULE_DEVICE_TABLE (pci, prosavage_pci_tbl);
+
 static struct pci_driver prosavage_driver = {
 	.name		=	"prosavage_smbus",
 	.id_table	=	prosavage_pci_tbl,
diff -Nru a/drivers/i2c/busses/i2c-savage4.c b/drivers/i2c/busses/i2c-savage4.c
--- a/drivers/i2c/busses/i2c-savage4.c	2004-10-19 16:55:57 -07:00
+++ b/drivers/i2c/busses/i2c-savage4.c	2004-10-19 16:55:57 -07:00
@@ -157,6 +157,8 @@
 	{ 0, }
 };
 
+MODULE_DEVICE_TABLE (pci, savage4_ids);
+
 static int __devinit savage4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	int retval;
diff -Nru a/drivers/i2c/busses/i2c-sis5595.c b/drivers/i2c/busses/i2c-sis5595.c
--- a/drivers/i2c/busses/i2c-sis5595.c	2004-10-19 16:55:57 -07:00
+++ b/drivers/i2c/busses/i2c-sis5595.c	2004-10-19 16:55:57 -07:00
@@ -371,6 +371,8 @@
 	{ 0, }
 };
 
+MODULE_DEVICE_TABLE (pci, sis5595_ids);
+
 static int __devinit sis5595_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	if (sis5595_setup(dev)) {
diff -Nru a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-sis630.c
--- a/drivers/i2c/busses/i2c-sis630.c	2004-10-19 16:55:57 -07:00
+++ b/drivers/i2c/busses/i2c-sis630.c	2004-10-19 16:55:57 -07:00
@@ -468,6 +468,8 @@
 	{ 0, }
 };
 
+MODULE_DEVICE_TABLE (pci, sis630_ids);
+
 static int __devinit sis630_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	if (sis630_setup(dev)) {
diff -Nru a/drivers/i2c/busses/i2c-sis96x.c b/drivers/i2c/busses/i2c-sis96x.c
--- a/drivers/i2c/busses/i2c-sis96x.c	2004-10-19 16:55:57 -07:00
+++ b/drivers/i2c/busses/i2c-sis96x.c	2004-10-19 16:55:57 -07:00
@@ -278,6 +278,8 @@
 	{ 0, }
 };
 
+MODULE_DEVICE_TABLE (pci, sis96x_ids);
+
 static int __devinit sis96x_probe(struct pci_dev *dev,
 				const struct pci_device_id *id)
 {
diff -Nru a/drivers/i2c/busses/i2c-via.c b/drivers/i2c/busses/i2c-via.c
--- a/drivers/i2c/busses/i2c-via.c	2004-10-19 16:55:57 -07:00
+++ b/drivers/i2c/busses/i2c-via.c	2004-10-19 16:55:57 -07:00
@@ -99,6 +99,8 @@
 	{ 0, }
 };
 
+MODULE_DEVICE_TABLE (pci, vt586b_ids);
+
 static int __devinit vt586b_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	u16 base;
diff -Nru a/drivers/i2c/busses/i2c-viapro.c b/drivers/i2c/busses/i2c-viapro.c
--- a/drivers/i2c/busses/i2c-viapro.c	2004-10-19 16:55:57 -07:00
+++ b/drivers/i2c/busses/i2c-viapro.c	2004-10-19 16:55:57 -07:00
@@ -454,6 +454,8 @@
 	{ 0, }
 };
 
+MODULE_DEVICE_TABLE (pci, vt596_ids);
+
 static struct pci_driver vt596_driver = {
 	.name		= "vt596_smbus",
 	.id_table	= vt596_ids,
diff -Nru a/drivers/i2c/busses/i2c-voodoo3.c b/drivers/i2c/busses/i2c-voodoo3.c
--- a/drivers/i2c/busses/i2c-voodoo3.c	2004-10-19 16:55:57 -07:00
+++ b/drivers/i2c/busses/i2c-voodoo3.c	2004-10-19 16:55:57 -07:00
@@ -195,6 +195,8 @@
 	{ 0, }
 };
 
+MODULE_DEVICE_TABLE (pci, voodoo3_ids);
+
 static int __devinit voodoo3_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	int retval;

