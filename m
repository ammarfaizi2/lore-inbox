Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318010AbSFSVQP>; Wed, 19 Jun 2002 17:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318012AbSFSVQO>; Wed, 19 Jun 2002 17:16:14 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:51668 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318010AbSFSVQO>; Wed, 19 Jun 2002 17:16:14 -0400
Date: Wed, 19 Jun 2002 23:16:09 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Dave Jones <davej@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.23-dj2
In-Reply-To: <20020619205136.GA18903@suse.de>
Message-ID: <Pine.NEB.4.44.0206192311500.10290-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jun 2002, Dave Jones wrote:

> Lots of bits got thrown out this time, as Christoph Hellwig went through
> the patch and picked up on quite a few obviously wrong bits. In addition,
>...

Another obviously wrong bit seems to be the patch below that is still in
-dj2:

- it adds a function that isn't used in neither plain 2.5.23 nor by
  anything in the -dj2 patch
- it doesn't compile

cu
Adrian


--- linux-2.5.23/drivers/isdn/hardware/avm/b1.c	Wed Jun 19 03:11:52 2002
+++ linux-2.5/drivers/isdn/hardware/avm/b1.c	Sat Jun  1 00:34:35 2002
@@ -59,6 +59,21 @@

 /* ------------------------------------------------------------- */

+void b1_set_revision(struct capi_driver *driver, char *rev)
+{
+	char *p;
+
+	if ((p = strchr(rev, ':')) != 0 && p[1]) {
+		strncpy(driver->revision, p + 2, sizeof(driver->revision));
+		driver->revision[sizeof(driver->revision)-1] = 0;
+		if ((p = strchr(driver->revision, '$')) != 0 && p > driver->revision)
+			*(p-1) = 0;
+	}
+	printk(KERN_INFO "%s: revision %s\n", driver->name, driver->revision);
+}
+
+/* ------------------------------------------------------------- */
+
 avmcard *b1_alloc_card(int nr_controllers)
 {
 	avmcard *card;



