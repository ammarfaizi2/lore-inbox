Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288950AbSAITRD>; Wed, 9 Jan 2002 14:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287743AbSAITQx>; Wed, 9 Jan 2002 14:16:53 -0500
Received: from h00009405ee48.ne.mediaone.net ([24.91.224.30]:8267 "EHLO
	epiphany") by vger.kernel.org with ESMTP id <S288950AbSAITQj>;
	Wed, 9 Jan 2002 14:16:39 -0500
Subject: MINOR(inode->i_rdev) vs. minor(inode->i_rdev)
From: Brendan Burns <bburns@genet.cs.umass.edu>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-D8ZNKKfDR/0f8cZdL4/H"
X-Mailer: Evolution/1.0 (Preview Release)
Date: 09 Jan 2002 14:20:23 -0500
Message-Id: <1010604024.2904.0.camel@epiphany>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-D8ZNKKfDR/0f8cZdL4/H
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,
In the process of compiling ALSA for my new 2.5.2pre10 kernel I noticed
that MINOR(inode->i_rdev) causes compile errors and should be replaced
with minor(inode->i_rdev) Looking at a number of the OSS sound drivers
in the kernel I noticed that they to would not compile in 2.5.2pre10 (eg
Turtle Beach Pinnacle)  I fixed all of these modules and a patch is
attached.  However, looking further I noticed that there were similar
problems in a number of other drivers.  Before I undertook cleaning all
of them I thought I would check in and make sure I was doing the right
thing.  Namely that every instance of MINOR(inode->i_rdev) or
MINOR(i_rdev) should be replaced with minor(inode->i_rdev) or
minor(i_rdev).

Please CC me on any replies since I am not subscribed to the list.
Thanks,
Brendan




--=-D8ZNKKfDR/0f8cZdL4/H
Content-Disposition: attachment; filename=sound-patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; charset=ISO-8859-1

diff -uNr linux/drivers/sound/btaudio.c linux.new/drivers/sound/btaudio.c
--- linux/drivers/sound/btaudio.c	Wed Oct 17 17:19:20 2001
+++ linux.new/drivers/sound/btaudio.c	Wed Jan  9 13:57:09 2002
@@ -300,7 +300,7 @@
=20
 static int btaudio_mixer_open(struct inode *inode, struct file *file)
 {
-	int minor =3D MINOR(inode->i_rdev);
+	int minor =3D minor(inode->i_rdev);
 	struct btaudio *bta;
=20
 	for (bta =3D btaudios; bta !=3D NULL; bta =3D bta->next)
@@ -459,7 +459,7 @@
=20
 static int btaudio_dsp_open_digital(struct inode *inode, struct file *file=
)
 {
-	int minor =3D MINOR(inode->i_rdev);
+	int minor =3D minor(inode->i_rdev);
 	struct btaudio *bta;
=20
 	for (bta =3D btaudios; bta !=3D NULL; bta =3D bta->next)
@@ -475,7 +475,7 @@
=20
 static int btaudio_dsp_open_analog(struct inode *inode, struct file *file)
 {
-	int minor =3D MINOR(inode->i_rdev);
+	int minor =3D minor(inode->i_rdev);
 	struct btaudio *bta;
=20
 	for (bta =3D btaudios; bta !=3D NULL; bta =3D bta->next)
diff -uNr linux/drivers/sound/cmpci.c linux.new/drivers/sound/cmpci.c
--- linux/drivers/sound/cmpci.c	Sun Nov 25 13:17:47 2001
+++ linux.new/drivers/sound/cmpci.c	Wed Jan  9 13:54:59 2002
@@ -1440,7 +1440,7 @@
=20
 static int cm_open_mixdev(struct inode *inode, struct file *file)
 {
-	int minor =3D MINOR(inode->i_rdev);
+	int minor =3D minor(inode->i_rdev);
 	struct cm_state *s =3D devs;
=20
 	while (s && s->dev_mixer !=3D minor)
@@ -2190,7 +2190,7 @@
=20
 static int cm_open(struct inode *inode, struct file *file)
 {
-	int minor =3D MINOR(inode->i_rdev);
+	int minor =3D minor(inode->i_rdev);
 	struct cm_state *s =3D devs;
 	unsigned char fmtm =3D ~0, fmts =3D 0;
=20
@@ -2445,7 +2445,7 @@
=20
 static int cm_midi_open(struct inode *inode, struct file *file)
 {
-	int minor =3D MINOR(inode->i_rdev);
+	int minor =3D minor(inode->i_rdev);
 	struct cm_state *s =3D devs;
 	unsigned long flags;
=20
@@ -2662,7 +2662,7 @@
=20
 static int cm_dmfm_open(struct inode *inode, struct file *file)
 {
-	int minor =3D MINOR(inode->i_rdev);
+	int minor =3D minor(inode->i_rdev);
 	struct cm_state *s =3D devs;
=20
 	while (s && s->dev_dmfm !=3D minor)
diff -uNr linux/drivers/sound/ite8172.c linux.new/drivers/sound/ite8172.c
--- linux/drivers/sound/ite8172.c	Thu Oct 25 16:53:52 2001
+++ linux.new/drivers/sound/ite8172.c	Wed Jan  9 13:57:22 2002
@@ -832,7 +832,7 @@
=20
 static int it8172_open_mixdev(struct inode *inode, struct file *file)
 {
-    int minor =3D MINOR(inode->i_rdev);
+    int minor =3D minor(inode->i_rdev);
     struct list_head *list;
     struct it8172_state *s;
=20
@@ -1543,7 +1543,7 @@
=20
 static int it8172_open(struct inode *inode, struct file *file)
 {
-    int minor =3D MINOR(inode->i_rdev);
+    int minor =3D minor(inode->i_rdev);
     DECLARE_WAITQUEUE(wait, current);
     unsigned long flags;
     struct list_head *list;
diff -uNr linux/drivers/sound/msnd_pinnacle.c linux.new/drivers/sound/msnd_=
pinnacle.c
--- linux/drivers/sound/msnd_pinnacle.c	Sun Sep 30 15:26:08 2001
+++ linux.new/drivers/sound/msnd_pinnacle.c	Wed Jan  9 13:54:12 2002
@@ -641,7 +641,7 @@
=20
 static int dev_ioctl(struct inode *inode, struct file *file, unsigned int =
cmd, unsigned long arg)
 {
-	int minor =3D MINOR(inode->i_rdev);
+	int minor =3D minor(inode->i_rdev);
=20
 	if (cmd =3D=3D OSS_GETVERSION) {
 		int sound_version =3D SOUND_VERSION;
@@ -753,7 +753,7 @@
=20
 static int dev_open(struct inode *inode, struct file *file)
 {
-	int minor =3D MINOR(inode->i_rdev);
+	int minor =3D minor(inode->i_rdev);
 	int err =3D 0;
=20
 	if (minor =3D=3D dev.dsp_minor) {
@@ -788,7 +788,7 @@
=20
 static int dev_release(struct inode *inode, struct file *file)
 {
-	int minor =3D MINOR(inode->i_rdev);
+	int minor =3D minor(inode->i_rdev);
 	int err =3D 0;
=20
 	lock_kernel();
@@ -978,7 +978,7 @@
=20
 static ssize_t dev_read(struct file *file, char *buf, size_t count, loff_t=
 *off)
 {
-	int minor =3D MINOR(file->f_dentry->d_inode->i_rdev);
+	int minor =3D minor(file->f_dentry->d_inode->i_rdev);
 	if (minor =3D=3D dev.dsp_minor)
 		return dsp_read(buf, count);
 	else
@@ -987,7 +987,7 @@
=20
 static ssize_t dev_write(struct file *file, const char *buf, size_t count,=
 loff_t *off)
 {
-	int minor =3D MINOR(file->f_dentry->d_inode->i_rdev);
+	int minor =3D minor(file->f_dentry->d_inode->i_rdev);
 	if (minor =3D=3D dev.dsp_minor)
 		return dsp_write(buf, count);
 	else
diff -uNr linux/drivers/sound/nec_vrc5477.c linux.new/drivers/sound/nec_vrc=
5477.c
--- linux/drivers/sound/nec_vrc5477.c	Thu Oct 25 16:53:52 2001
+++ linux.new/drivers/sound/nec_vrc5477.c	Wed Jan  9 13:57:32 2002
@@ -813,7 +813,7 @@
=20
 static int vrc5477_ac97_open_mixdev(struct inode *inode, struct file *file=
)
 {
-	int minor =3D MINOR(inode->i_rdev);
+	int minor =3D minor(inode->i_rdev);
 	struct list_head *list;
 	struct vrc5477_ac97_state *s;
=20
@@ -1529,7 +1529,7 @@
=20
 static int vrc5477_ac97_open(struct inode *inode, struct file *file)
 {
-	int minor =3D MINOR(inode->i_rdev);
+	int minor =3D minor(inode->i_rdev);
 	DECLARE_WAITQUEUE(wait, current);
 	unsigned long flags;
 	struct list_head *list;
diff -uNr linux/drivers/sound/rme96xx.c linux.new/drivers/sound/rme96xx.c
--- linux/drivers/sound/rme96xx.c	Thu Oct 25 16:53:52 2001
+++ linux.new/drivers/sound/rme96xx.c	Wed Jan  9 13:56:13 2002
@@ -1162,7 +1162,7 @@
=20
 static int rme96xx_open(struct inode *in, struct file *f)
 {
-	int minor =3D MINOR(in->i_rdev);
+	int minor =3D minor(in->i_rdev);
 	struct list_head *list;
 	int devnum =3D ((minor-3)/16) % devices; /* default =3D 0 */
 	rme96xx_info *s;
@@ -1490,7 +1490,7 @@
=20
 static int rme96xx_mixer_open(struct inode *inode, struct file *file)
 {
-	int minor =3D MINOR(inode->i_rdev);
+	int minor =3D minor(inode->i_rdev);
 	struct list_head *list;
 	rme96xx_info *s;
=20
diff -uNr linux/drivers/sound/sonicvibes.c linux.new/drivers/sound/sonicvib=
es.c
--- linux/drivers/sound/sonicvibes.c	Sun Sep 30 15:26:08 2001
+++ linux.new/drivers/sound/sonicvibes.c	Wed Jan  9 13:54:36 2002
@@ -1235,7 +1235,7 @@
=20
 static int sv_open_mixdev(struct inode *inode, struct file *file)
 {
-	int minor =3D MINOR(inode->i_rdev);
+	int minor =3D minor(inode->i_rdev);
 	struct list_head *list;
 	struct sv_state *s;
=20
@@ -1893,7 +1893,7 @@
=20
 static int sv_open(struct inode *inode, struct file *file)
 {
-	int minor =3D MINOR(inode->i_rdev);
+	int minor =3D minor(inode->i_rdev);
 	DECLARE_WAITQUEUE(wait, current);
 	unsigned char fmtm =3D ~0, fmts =3D 0;
 	struct list_head *list;
@@ -2142,7 +2142,7 @@
=20
 static int sv_midi_open(struct inode *inode, struct file *file)
 {
-	int minor =3D MINOR(inode->i_rdev);
+	int minor =3D minor(inode->i_rdev);
 	DECLARE_WAITQUEUE(wait, current);
 	unsigned long flags;
 	struct list_head *list;
@@ -2364,7 +2364,7 @@
=20
 static int sv_dmfm_open(struct inode *inode, struct file *file)
 {
-	int minor =3D MINOR(inode->i_rdev);
+	int minor =3D minor(inode->i_rdev);
 	DECLARE_WAITQUEUE(wait, current);
 	struct list_head *list;
 	struct sv_state *s;
diff -uNr linux/drivers/sound/trident.c linux.new/drivers/sound/trident.c
--- linux/drivers/sound/trident.c	Tue Nov 13 12:19:41 2001
+++ linux.new/drivers/sound/trident.c	Wed Jan  9 13:55:47 2002
@@ -2555,7 +2555,7 @@
 static int trident_open(struct inode *inode, struct file *file)
 {
 	int i =3D 0;
-	int minor =3D MINOR(inode->i_rdev);
+	int minor =3D minor(inode->i_rdev);
 	struct trident_card *card =3D devs;
 	struct trident_state *state =3D NULL;
 	struct dmabuf *dmabuf =3D NULL;
@@ -3750,7 +3750,7 @@
 static int trident_open_mixdev(struct inode *inode, struct file *file)
 {
 	int i =3D 0;
-	int minor =3D MINOR(inode->i_rdev);
+	int minor =3D minor(inode->i_rdev);
 	struct trident_card *card =3D devs;
=20
 	for (card =3D devs; card !=3D NULL; card =3D card->next)
diff -uNr linux/drivers/sound/via82cxxx_audio.c linux.new/drivers/sound/via=
82cxxx_audio.c
--- linux/drivers/sound/via82cxxx_audio.c	Mon Dec 10 13:39:20 2001
+++ linux.new/drivers/sound/via82cxxx_audio.c	Wed Jan  9 13:53:44 2002
@@ -1358,7 +1358,7 @@
=20
 static int via_mixer_open (struct inode *inode, struct file *file)
 {
-	int minor =3D MINOR(inode->i_rdev);
+	int minor =3D minor(inode->i_rdev);
 	struct via_info *card;
 	struct pci_dev *pdev;
 	struct pci_driver *drvr;
@@ -2974,7 +2974,7 @@
=20
 static int via_dsp_open (struct inode *inode, struct file *file)
 {
-	int minor =3D MINOR(inode->i_rdev);
+	int minor =3D minor(inode->i_rdev);
 	struct via_info *card;
 	struct pci_dev *pdev;
 	struct via_channel *chan;
diff -uNr linux/drivers/sound/vwsnd.c linux.new/drivers/sound/vwsnd.c
--- linux/drivers/sound/vwsnd.c	Fri Nov  9 17:07:41 2001
+++ linux.new/drivers/sound/vwsnd.c	Wed Jan  9 13:57:43 2002
@@ -2907,7 +2907,7 @@
 static int vwsnd_audio_open(struct inode *inode, struct file *file)
 {
 	vwsnd_dev_t *devc;
-	dev_t minor =3D MINOR(inode->i_rdev);
+	dev_t minor =3D minor(inode->i_rdev);
 	int sw_samplefmt;
=20
 	DBGE("(inode=3D0x%p, file=3D0x%p)\n", inode, file);
@@ -3054,7 +3054,7 @@
=20
 	INC_USE_COUNT;
 	for (devc =3D vwsnd_dev_list; devc; devc =3D devc->next_dev)
-		if (devc->mixer_minor =3D=3D MINOR(inode->i_rdev))
+		if (devc->mixer_minor =3D=3D minor(inode->i_rdev))
 			break;
=20
 	if (devc =3D=3D NULL) {

--=-D8ZNKKfDR/0f8cZdL4/H--

