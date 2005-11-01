Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964960AbVKAIOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbVKAIOx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965018AbVKAIOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:14:41 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:10897 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S964960AbVKAIOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:14:15 -0500
Message-ID: <436723AB.1060400@m1k.net>
Date: Tue, 01 Nov 2005 03:13:31 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 11/37] dvb: fix sparse warnings
Content-Type: multipart/mixed;
 boundary="------------000604070909080507050906"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000604070909080507050906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------000604070909080507050906
Content-Type: text/x-patch;
 name="2374.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2374.patch"

From: Peter Hagervall <hager@cs.umu.se>

Sparse warnings
 - remove address space related warnings

Signed-off-by: Peter Hagervall <hager@cs.umu.se>
Signed-off-by: Manu Abraham <manu@linuxtv.org>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>

 drivers/media/dvb/bt8xx/dst_ca.c |   27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

--- linux-2.6.14-git3.orig/drivers/media/dvb/bt8xx/dst_ca.c
+++ linux-2.6.14-git3/drivers/media/dvb/bt8xx/dst_ca.c
@@ -166,7 +166,7 @@
 	return 0;
 }
 
-static int ca_get_slot_caps(struct dst_state *state, struct ca_caps *p_ca_caps, void *arg)
+static int ca_get_slot_caps(struct dst_state *state, struct ca_caps *p_ca_caps, void __user *arg)
 {
 	int i;
 	u8 slot_cap[256];
@@ -192,20 +192,20 @@
 	p_ca_caps->descr_num = slot_cap[7];
 	p_ca_caps->descr_type = 1;
 
-	if (copy_to_user((struct ca_caps *)arg, p_ca_caps, sizeof (struct ca_caps)))
+	if (copy_to_user(arg, p_ca_caps, sizeof (struct ca_caps)))
 		return -EFAULT;
 
 	return 0;
 }
 
 /*	Need some more work	*/
-static int ca_get_slot_descr(struct dst_state *state, struct ca_msg *p_ca_message, void *arg)
+static int ca_get_slot_descr(struct dst_state *state, struct ca_msg *p_ca_message, void __user *arg)
 {
 	return -EOPNOTSUPP;
 }
 
 
-static int ca_get_slot_info(struct dst_state *state, struct ca_slot_info *p_ca_slot_info, void *arg)
+static int ca_get_slot_info(struct dst_state *state, struct ca_slot_info *p_ca_slot_info, void __user *arg)
 {
 	int i;
 	static u8 slot_command[8] = {0x00, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff};
@@ -238,19 +238,19 @@
 	} else
 		p_ca_slot_info->flags = 0;
 
-	if (copy_to_user((struct ca_slot_info *)arg, p_ca_slot_info, sizeof (struct ca_slot_info)))
+	if (copy_to_user(arg, p_ca_slot_info, sizeof (struct ca_slot_info)))
 		return -EFAULT;
 
 	return 0;
 }
 
 
-static int ca_get_message(struct dst_state *state, struct ca_msg *p_ca_message, void *arg)
+static int ca_get_message(struct dst_state *state, struct ca_msg *p_ca_message, void __user *arg)
 {
 	u8 i = 0;
 	u32 command = 0;
 
-	if (copy_from_user(p_ca_message, (void *)arg, sizeof (struct ca_msg)))
+	if (copy_from_user(p_ca_message, arg, sizeof (struct ca_msg)))
 		return -EFAULT;
 
 	if (p_ca_message->msg) {
@@ -266,7 +266,7 @@
 		switch (command) {
 		case CA_APP_INFO:
 			memcpy(p_ca_message->msg, state->messages, 128);
-			if (copy_to_user((void *)arg, p_ca_message, sizeof (struct ca_msg)) )
+			if (copy_to_user(arg, p_ca_message, sizeof (struct ca_msg)) )
 				return -EFAULT;
 			break;
 		}
@@ -315,7 +315,7 @@
 	return 0;
 }
 
-u32 asn_1_decode(u8 *asn_1_array)
+static u32 asn_1_decode(u8 *asn_1_array)
 {
 	u8 length_field = 0, word_count = 0, count = 0;
 	u32 length = 0;
@@ -400,7 +400,7 @@
 	return 0;
 }
 
-static int ca_send_message(struct dst_state *state, struct ca_msg *p_ca_message, void *arg)
+static int ca_send_message(struct dst_state *state, struct ca_msg *p_ca_message, void __user *arg)
 {
 	int i = 0;
 	unsigned int ca_message_header_len;
@@ -414,7 +414,7 @@
 	}
 	dprintk(verbose, DST_CA_DEBUG, 1, " ");
 
-	if (copy_from_user(p_ca_message, (void *)arg, sizeof (struct ca_msg)))
+	if (copy_from_user(p_ca_message, arg, sizeof (struct ca_msg)))
 		return -EFAULT;
 
 	if (p_ca_message->msg) {
@@ -461,13 +461,14 @@
 	return 0;
 }
 
-static int dst_ca_ioctl(struct inode *inode, struct file *file, unsigned int cmd, void *arg)
+static int dst_ca_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long ioctl_arg)
 {
 	struct dvb_device* dvbdev = (struct dvb_device*) file->private_data;
 	struct dst_state* state = (struct dst_state*) dvbdev->priv;
 	struct ca_slot_info *p_ca_slot_info;
 	struct ca_caps *p_ca_caps;
 	struct ca_msg *p_ca_message;
+	void __user *arg = (void __user *)ioctl_arg;
 
 	if ((p_ca_message = (struct ca_msg *) kmalloc(sizeof (struct ca_msg), GFP_KERNEL)) == NULL) {
 		dprintk(verbose, DST_CA_ERROR, 1, " Memory allocation failure");
@@ -583,7 +584,7 @@
 
 static struct file_operations dst_ca_fops = {
 	.owner = THIS_MODULE,
-	.ioctl = (void *)dst_ca_ioctl,
+	.ioctl = dst_ca_ioctl,
 	.open = dst_ca_open,
 	.release = dst_ca_release,
 	.read = dst_ca_read,


--------------000604070909080507050906--
