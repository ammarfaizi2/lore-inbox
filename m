Return-Path: <linux-kernel-owner+w=401wt.eu-S932748AbXAATw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932748AbXAATw5 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 14:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932791AbXAATw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 14:52:57 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:52681 "EHLO
	saraswathi.solana.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754688AbXAATwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 14:52:36 -0500
Message-Id: <200701011947.l01JlAMo020761@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 4/8] UML - audio driver formatting
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 01 Jan 2007 14:47:10 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whitespace and style fixes.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/drivers/hostaudio_kern.c |  160 +++++++++++++++++----------------------
 1 file changed, 73 insertions(+), 87 deletions(-)

Index: linux-2.6.18-mm/arch/um/drivers/hostaudio_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/hostaudio_kern.c	2006-12-29 21:13:41.000000000 -0500
+++ linux-2.6.18-mm/arch/um/drivers/hostaudio_kern.c	2006-12-29 21:13:42.000000000 -0500
@@ -15,11 +15,11 @@
 #include "os.h"
 
 struct hostaudio_state {
-  int fd;
+	int fd;
 };
 
 struct hostmixer_state {
-  int fd;
+	int fd;
 };
 
 #define HOSTAUDIO_DEV_DSP "/dev/sound/dsp"
@@ -72,12 +72,12 @@ MODULE_PARM_DESC(mixer, MIXER_HELP);
 static ssize_t hostaudio_read(struct file *file, char __user *buffer,
 			      size_t count, loff_t *ppos)
 {
-        struct hostaudio_state *state = file->private_data;
+	struct hostaudio_state *state = file->private_data;
 	void *kbuf;
 	int err;
 
 #ifdef DEBUG
-        printk("hostaudio: read called, count = %d\n", count);
+	printk("hostaudio: read called, count = %d\n", count);
 #endif
 
 	kbuf = kmalloc(count, GFP_KERNEL);
@@ -91,7 +91,7 @@ static ssize_t hostaudio_read(struct fil
 	if(copy_to_user(buffer, kbuf, err))
 		err = -EFAULT;
 
- out:
+out:
 	kfree(kbuf);
 	return(err);
 }
@@ -99,12 +99,12 @@ static ssize_t hostaudio_read(struct fil
 static ssize_t hostaudio_write(struct file *file, const char __user *buffer,
 			       size_t count, loff_t *ppos)
 {
-        struct hostaudio_state *state = file->private_data;
+	struct hostaudio_state *state = file->private_data;
 	void *kbuf;
 	int err;
 
 #ifdef DEBUG
-        printk("hostaudio: write called, count = %d\n", count);
+	printk("hostaudio: write called, count = %d\n", count);
 #endif
 
 	kbuf = kmalloc(count, GFP_KERNEL);
@@ -128,24 +128,24 @@ static ssize_t hostaudio_write(struct fi
 static unsigned int hostaudio_poll(struct file *file, 
 				   struct poll_table_struct *wait)
 {
-        unsigned int mask = 0;
+	unsigned int mask = 0;
 
 #ifdef DEBUG
-        printk("hostaudio: poll called (unimplemented)\n");
+	printk("hostaudio: poll called (unimplemented)\n");
 #endif
 
-        return(mask);
+	return(mask);
 }
 
 static int hostaudio_ioctl(struct inode *inode, struct file *file, 
 			   unsigned int cmd, unsigned long arg)
 {
-        struct hostaudio_state *state = file->private_data;
+	struct hostaudio_state *state = file->private_data;
 	unsigned long data = 0;
 	int err;
 
 #ifdef DEBUG
-        printk("hostaudio: ioctl called, cmd = %u\n", cmd);
+	printk("hostaudio: ioctl called, cmd = %u\n", cmd);
 #endif
 	switch(cmd){
 	case SNDCTL_DSP_SPEED:
@@ -182,42 +182,40 @@ static int hostaudio_ioctl(struct inode 
 
 static int hostaudio_open(struct inode *inode, struct file *file)
 {
-        struct hostaudio_state *state;
-        int r = 0, w = 0;
-        int ret;
+	struct hostaudio_state *state;
+	int r = 0, w = 0;
+	int ret;
 
 #ifdef DEBUG
-        printk("hostaudio: open called (host: %s)\n", dsp);
+	printk("hostaudio: open called (host: %s)\n", dsp);
 #endif
 
-        state = kmalloc(sizeof(struct hostaudio_state), GFP_KERNEL);
-        if(state == NULL)
+	state = kmalloc(sizeof(struct hostaudio_state), GFP_KERNEL);
+	if(state == NULL)
 		return(-ENOMEM);
 
-        if(file->f_mode & FMODE_READ) r = 1;
-        if(file->f_mode & FMODE_WRITE) w = 1;
+	if(file->f_mode & FMODE_READ) r = 1;
+	if(file->f_mode & FMODE_WRITE) w = 1;
 
 	ret = os_open_file(dsp, of_set_rw(OPENFLAGS(), r, w), 0);
-        if(ret < 0){
+	if(ret < 0){
 		kfree(state);
 		return(ret);
-        }
-
+	}
 	state->fd = ret;
-        file->private_data = state;
-        return(0);
+	file->private_data = state;
+	return(0);
 }
 
 static int hostaudio_release(struct inode *inode, struct file *file)
 {
-        struct hostaudio_state *state = file->private_data;
+	struct hostaudio_state *state = file->private_data;
 
 #ifdef DEBUG
-        printk("hostaudio: release called\n");
+	printk("hostaudio: release called\n");
 #endif
-
-		os_close_file(state->fd);
-        kfree(state);
+	os_close_file(state->fd);
+	kfree(state);
 
 	return(0);
 }
@@ -227,10 +225,10 @@ static int hostaudio_release(struct inod
 static int hostmixer_ioctl_mixdev(struct inode *inode, struct file *file, 
 				  unsigned int cmd, unsigned long arg)
 {
-        struct hostmixer_state *state = file->private_data;
+	struct hostmixer_state *state = file->private_data;
 
 #ifdef DEBUG
-        printk("hostmixer: ioctl called\n");
+	printk("hostmixer: ioctl called\n");
 #endif
 
 	return(os_ioctl_generic(state->fd, cmd, arg));
@@ -238,68 +236,67 @@ static int hostmixer_ioctl_mixdev(struct
 
 static int hostmixer_open_mixdev(struct inode *inode, struct file *file)
 {
-        struct hostmixer_state *state;
-        int r = 0, w = 0;
-        int ret;
+	struct hostmixer_state *state;
+	int r = 0, w = 0;
+	int ret;
 
 #ifdef DEBUG
-        printk("hostmixer: open called (host: %s)\n", mixer);
+	printk("hostmixer: open called (host: %s)\n", mixer);
 #endif
 
-        state = kmalloc(sizeof(struct hostmixer_state), GFP_KERNEL);
-        if(state == NULL) return(-ENOMEM);
+	state = kmalloc(sizeof(struct hostmixer_state), GFP_KERNEL);
+	if(state == NULL) return(-ENOMEM);
 
-        if(file->f_mode & FMODE_READ) r = 1;
-        if(file->f_mode & FMODE_WRITE) w = 1;
+	if(file->f_mode & FMODE_READ) r = 1;
+	if(file->f_mode & FMODE_WRITE) w = 1;
 
 	ret = os_open_file(mixer, of_set_rw(OPENFLAGS(), r, w), 0);
         
-        if(ret < 0){
+	if(ret < 0){
 		printk("hostaudio_open_mixdev failed to open '%s', err = %d\n",
 		       dsp, -ret);
 		kfree(state);
 		return(ret);
-        }
+	}
 
-        file->private_data = state;
-        return(0);
+	file->private_data = state;
+	return(0);
 }
 
 static int hostmixer_release(struct inode *inode, struct file *file)
 {
-        struct hostmixer_state *state = file->private_data;
+	struct hostmixer_state *state = file->private_data;
 
 #ifdef DEBUG
-        printk("hostmixer: release called\n");
+	printk("hostmixer: release called\n");
 #endif
 
-		os_close_file(state->fd);
-        kfree(state);
+	os_close_file(state->fd);
+	kfree(state);
 
 	return(0);
 }
 
-
 /* kernel module operations */
 
 static const struct file_operations hostaudio_fops = {
-        .owner          = THIS_MODULE,
-        .llseek         = no_llseek,
-        .read           = hostaudio_read,
-        .write          = hostaudio_write,
-        .poll           = hostaudio_poll,
-        .ioctl          = hostaudio_ioctl,
-        .mmap           = NULL,
-        .open           = hostaudio_open,
-        .release        = hostaudio_release,
+	.owner          = THIS_MODULE,
+	.llseek         = no_llseek,
+	.read           = hostaudio_read,
+	.write          = hostaudio_write,
+	.poll           = hostaudio_poll,
+	.ioctl          = hostaudio_ioctl,
+	.mmap           = NULL,
+	.open           = hostaudio_open,
+	.release        = hostaudio_release,
 };
 
 static const struct file_operations hostmixer_fops = {
-        .owner          = THIS_MODULE,
-        .llseek         = no_llseek,
-        .ioctl          = hostmixer_ioctl_mixdev,
-        .open           = hostmixer_open_mixdev,
-        .release        = hostmixer_release,
+	.owner          = THIS_MODULE,
+	.llseek         = no_llseek,
+	.ioctl          = hostmixer_ioctl_mixdev,
+	.open           = hostmixer_open_mixdev,
+	.release        = hostmixer_release,
 };
 
 struct {
@@ -313,42 +310,31 @@ MODULE_LICENSE("GPL");
 
 static int __init hostaudio_init_module(void)
 {
-        printk(KERN_INFO "UML Audio Relay (host dsp = %s, host mixer = %s)\n",
+	printk(KERN_INFO "UML Audio Relay (host dsp = %s, host mixer = %s)\n",
 	       dsp, mixer);
 
 	module_data.dev_audio = register_sound_dsp(&hostaudio_fops, -1);
-        if(module_data.dev_audio < 0){
-                printk(KERN_ERR "hostaudio: couldn't register DSP device!\n");
-                return -ENODEV;
-        }
+	if(module_data.dev_audio < 0){
+		printk(KERN_ERR "hostaudio: couldn't register DSP device!\n");
+		return -ENODEV;
+	}
 
 	module_data.dev_mixer = register_sound_mixer(&hostmixer_fops, -1);
-        if(module_data.dev_mixer < 0){
-                printk(KERN_ERR "hostmixer: couldn't register mixer "
+	if(module_data.dev_mixer < 0){
+		printk(KERN_ERR "hostmixer: couldn't register mixer "
 		       "device!\n");
-                unregister_sound_dsp(module_data.dev_audio);
-                return -ENODEV;
-        }
+		unregister_sound_dsp(module_data.dev_audio);
+		return -ENODEV;
+	}
 
-        return 0;
+	return 0;
 }
 
 static void __exit hostaudio_cleanup_module (void)
 {
-       unregister_sound_mixer(module_data.dev_mixer);
-       unregister_sound_dsp(module_data.dev_audio);
+	unregister_sound_mixer(module_data.dev_mixer);
+	unregister_sound_dsp(module_data.dev_audio);
 }
 
 module_init(hostaudio_init_module);
 module_exit(hostaudio_cleanup_module);
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */

