Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162420AbWKQRCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162420AbWKQRCg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 12:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162433AbWKQRCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 12:02:36 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:12306 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1162420AbWKQRC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 12:02:27 -0500
Date: Fri, 17 Nov 2006 18:02:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] make sound/core/control.c:snd_ctl_new() static
Message-ID: <20061117170226.GG31879@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that everyone uses snd_ctl_new1() and noone is using snd_ctl_new() 
anymore, we can make it static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl |   10 ----------
 include/sound/control.h                                      |    1 -
 sound/core/control.c                                         |    5 ++---
 3 files changed, 2 insertions(+), 14 deletions(-)

--- linux-2.6.19-rc5-mm2/Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl.old	2006-11-17 16:48:12.000000000 +0100
+++ linux-2.6.19-rc5-mm2/Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl	2006-11-17 16:48:22.000000000 +0100
@@ -3691,16 +3691,6 @@
         </para>
 
         <para>
-          Here, the chip instance is retrieved via
-        <function>snd_kcontrol_chip()</function> macro.  This macro
-        just accesses to kcontrol-&gt;private_data. The
-        kcontrol-&gt;private_data field is 
-        given as the argument of <function>snd_ctl_new()</function>
-        (see the later subsection
-        <link linkend="control-interface-constructor"><citetitle>Constructor</citetitle></link>).
-        </para>
-
-        <para>
 	The <structfield>value</structfield> field is depending on
         the type of control as well as on info callback.  For example,
 	the sb driver uses this field to store the register offset,
--- linux-2.6.19-rc5-mm2/include/sound/control.h.old	2006-11-17 16:48:35.000000000 +0100
+++ linux-2.6.19-rc5-mm2/include/sound/control.h	2006-11-17 16:48:39.000000000 +0100
@@ -108,7 +108,6 @@
 
 void snd_ctl_notify(struct snd_card * card, unsigned int mask, struct snd_ctl_elem_id * id);
 
-struct snd_kcontrol *snd_ctl_new(struct snd_kcontrol * kcontrol, unsigned int access);
 struct snd_kcontrol *snd_ctl_new1(const struct snd_kcontrol_new * kcontrolnew, void * private_data);
 void snd_ctl_free_one(struct snd_kcontrol * kcontrol);
 int snd_ctl_add(struct snd_card * card, struct snd_kcontrol * kcontrol);
--- linux-2.6.19-rc5-mm2/sound/core/control.c.old	2006-11-17 16:48:46.000000000 +0100
+++ linux-2.6.19-rc5-mm2/sound/core/control.c	2006-11-17 16:49:39.000000000 +0100
@@ -183,7 +183,8 @@
  *
  * Returns the pointer of the new instance, or NULL on failure.
  */
-struct snd_kcontrol *snd_ctl_new(struct snd_kcontrol *control, unsigned int access)
+static struct snd_kcontrol *snd_ctl_new(struct snd_kcontrol *control,
+					unsigned int access)
 {
 	struct snd_kcontrol *kctl;
 	unsigned int idx;
@@ -201,8 +202,6 @@
 	return kctl;
 }
 
-EXPORT_SYMBOL(snd_ctl_new);
-
 /**
  * snd_ctl_new1 - create a control instance from the template
  * @ncontrol: the initialization record

