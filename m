Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbVB1AnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbVB1AnL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 19:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVB1AnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 19:43:10 -0500
Received: from fire.osdl.org ([65.172.181.4]:4587 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261524AbVB1Amv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 19:42:51 -0500
Date: Sun, 27 Feb 2005 16:31:45 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: torvalds <torvalds@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] sonicvibes: fix initdata references
Message-Id: <20050227163145.6997798e.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


sonicvibes:  _devinit function was referencing __initdata (2x),
which should be __devinitdata;

Error: ./sound/oss/sonicvibes.o .text refers to 0000000000003ca7 R_X86_64_32S      .init.data+0x0000000000000080                                                Error: ./sound/oss/sonicvibes.o .text refers to 00000000000043eb R_X86_64_32S      .init.data+0x0000000000000024                                                Error: ./sound/oss/sonicvibes.o .text refers to 00000000000043f2 R_X86_64_32S      .init.data+0x0000000000000020

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 sound/oss/sonicvibes.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -Naurp ./sound/oss/sonicvibes.c~sonicvibes_sections ./sound/oss/sonicvibes.c
--- ./sound/oss/sonicvibes.c~sonicvibes_sections	2005-02-27 12:54:07.380801392 -0800
+++ ./sound/oss/sonicvibes.c	2005-02-27 16:37:45.282970208 -0800
@@ -2470,7 +2470,7 @@ MODULE_LICENSE("GPL");
 static struct initvol {
 	int mixch;
 	int vol;
-} initvol[] __initdata = {
+} initvol[] __devinitdata = {
 	{ SOUND_MIXER_WRITE_RECLEV, 0x4040 },
 	{ SOUND_MIXER_WRITE_LINE1, 0x4040 },
 	{ SOUND_MIXER_WRITE_CD, 0x4040 },
@@ -2487,7 +2487,7 @@ static struct initvol {
 
 static int __devinit sv_probe(struct pci_dev *pcidev, const struct pci_device_id *pciid)
 {
-	static char __initdata sv_ddma_name[] = "S3 Inc. SonicVibes DDMA Controller";
+	static char __devinitdata sv_ddma_name[] = "S3 Inc. SonicVibes DDMA Controller";
        	struct sv_state *s;
 	mm_segment_t fs;
 	int i, val, ret;


---
