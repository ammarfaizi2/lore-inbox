Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269464AbUJLFcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269464AbUJLFcZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 01:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269466AbUJLFcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 01:32:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:58526 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269464AbUJLFcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 01:32:22 -0400
Message-ID: <416B6BA1.1030606@osdl.org>
Date: Mon, 11 Oct 2004 22:29:05 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       rmk@arm.linux.org.uk
Subject: [PATCH] cyber2000: fix init/exit section confusion
Content-Type: multipart/mixed;
 boundary="------------030103010109000700010605"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030103010109000700010605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

(attached)


--------------030103010109000700010605
Content-Type: text/x-patch;
 name="cyber_init_exit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cyber_init_exit.patch"


a. cyberpro_free_fb_info() is called by both __devinit & __devexit
code, so it cannot be __devinit.

b. igs_regs[] is used by resume code (indirectly), so it cannot
be discardable.

This leaves one reference in cyber2000fb that 'make buildcheck'
complains about, but I believe that it's OK, that being ".probe"
here:
static struct pci_driver cyberpro_driver = {
	.name		= "CyberPro",
	.probe		= cyberpro_pci_probe,

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>


diffstat:=
 drivers/video/cyber2000fb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -Naurp ./drivers/video/cyber2000fb.c~cyber_init_exit ./drivers/video/cyber2000fb.c
--- ./drivers/video/cyber2000fb.c~cyber_init_exit	2004-10-11 21:10:06.930781000 -0700
+++ ./drivers/video/cyber2000fb.c	2004-10-11 22:13:16.504678864 -0700
@@ -1166,7 +1166,7 @@ static struct fb_videomode __devinitdata
 	.vmode		= FB_VMODE_NONINTERLACED
 };
 
-static char igs_regs[] __devinitdata = {
+static char igs_regs[] = {
 	EXT_CRT_IRQ,		0,
 	EXT_CRT_TEST,		0,
 	EXT_SYNC_CTL,		0,
@@ -1289,7 +1289,7 @@ cyberpro_alloc_fb_info(unsigned int id, 
 	return cfb;
 }
 
-static void __devinit
+static void
 cyberpro_free_fb_info(struct cfb_info *cfb)
 {
 	if (cfb) {


--------------030103010109000700010605--
