Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965275AbWFATCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965275AbWFATCh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 15:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965278AbWFATCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 15:02:37 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:48456 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965275AbWFATCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 15:02:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type;
        b=KmVBKNJ4l7oOIMNdOZe5cJ+blFwzipcnO6DgfhkJDMrSPxJO0Sn+TIry+alaWJr7riZLAy/G0reJ2Ltz4rhGUp94RKMfAd8XNAt2X6nF9Pg/KOIIOnuMCsBsjLbInmedP5TRVuTDyDag9msIiOwshGo8f/BqO4X2ghngnLu2kJc=
Message-ID: <447F39C6.6050203@gmail.com>
Date: Thu, 01 Jun 2006 22:02:30 +0300
From: Anssi Hannula <anssi.hannula@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6-7.5.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dtor_core@ameritech.net
CC: "Randy.Dunlap" <rdunlap@xenotime.net>,
       linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: input: return -ENOSYS for registering functions when ff is disabled
References: <20060530105705.157014000@gmail.com>	<20060530110131.136225000@gmail.com> <20060530222122.069da389.rdunlap@xenotime.net>
In-Reply-To: <20060530222122.069da389.rdunlap@xenotime.net>
Content-Type: multipart/mixed;
 boundary="------------050305080604010805080108"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050305080604010805080108
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Return -ENOSYS instead of -EPERM for input_ff_allocate() and
input_ff_register() when INPUT_FF_EFFECTS is disabled.

Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>

---

--------------050305080604010805080108
Content-Type: text/x-patch;
 name="ff-refactoring-new-interface-eperm-to-enosys.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ff-refactoring-new-interface-eperm-to-enosys.diff"

---
 include/linux/input.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.17-rc4-git12/include/linux/input.h
===================================================================
--- linux-2.6.17-rc4-git12.orig/include/linux/input.h	2006-06-01 18:45:58.000000000 +0300
+++ linux-2.6.17-rc4-git12/include/linux/input.h	2006-06-01 18:51:06.000000000 +0300
@@ -1059,12 +1059,12 @@ int input_ff_event(struct input_dev *dev
 #else
 static inline int input_ff_allocate(struct input_dev *dev)
 {
-	return -EPERM;
+	return -ENOSYS;
 }
 static inline int input_ff_register(struct input_dev *dev,
 				    struct ff_driver *driver)
 {
-	return -EPERM;
+	return -ENOSYS;
 }
 static inline int input_ff_upload(struct input_dev *dev,
 				  struct ff_effect *effect, struct file *file)

--------------050305080604010805080108--
