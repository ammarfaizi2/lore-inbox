Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752571AbWAFVvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571AbWAFVvr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 16:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752570AbWAFVvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 16:51:46 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:21907 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752489AbWAFVvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 16:51:33 -0500
Subject: [patch 4/4] Actually make the f_ops field const
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: aviro@redhat.com, akpm@osdl.org
In-Reply-To: <1136583937.2940.90.camel@laptopd505.fenrus.org>
References: <1136583937.2940.90.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 22:51:07 +0100
Message-Id: <1136584267.2940.101.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@infradead.org>

Mark the f_ops members of inodes as const, as well as fix the ripple-through
this causes by places that copy this f_ops and then "do stuff" with it.
(some of the "do stuff" is quite unpleasant..)
I've looked at several other alternatives for doing this but have not found one
that works well in the light that several pieces of code build their fops struct
dynamically at runtime.

Signed-off-by: Arjan van de Ven <arjan@infradead.org>
 drivers/char/drm/drm_stub.c         |    2 +-
 drivers/char/drm/i810_dma.c         |    2 +-
 drivers/char/drm/i830_dma.c         |    2 +-
 drivers/char/mem.c                  |    2 +-
 drivers/char/misc.c                 |    2 +-
 drivers/input/input.c               |    2 +-
 drivers/isdn/capi/kcapi_proc.c      |    2 +-
 drivers/media/dvb/dvb-core/dvbdev.c |    2 +-
 drivers/media/video/videodev.c      |    2 +-
 drivers/message/i2o/i2o_proc.c      |    2 +-
 drivers/oprofile/oprofilefs.c       |    6 +++---
 drivers/telephony/phonedev.c        |    2 +-
 drivers/usb/core/file.c             |    6 +++---
 fs/char_dev.c                       |    4 ++--
 fs/debugfs/inode.c                  |    2 +-
 fs/inode.c                          |    2 +-
 fs/nfsd/vfs.c                       |    2 +-
 fs/proc/generic.c                   |    2 +-
 fs/proc/internal.h                  |    2 +-
 fs/proc/proc_misc.c                 |    2 +-
 fs/select.c                         |    2 +-
 include/linux/cdev.h                |    4 ++--
 include/linux/debugfs.h             |    2 +-
 include/linux/fs.h                  |    6 +++---
 include/linux/input.h               |    2 +-
 include/linux/miscdevice.h          |    2 +-
 include/linux/oprofile.h            |    4 ++--
 include/linux/proc_fs.h             |    4 ++--
 include/linux/sound.h               |   12 ++++++------
 include/linux/sunrpc/stats.h        |    4 ++--
 include/linux/usb.h                 |    2 +-
 include/linux/videodev2.h           |    2 +-
 include/sound/core.h                |    2 +-
 net/sunrpc/rpc_pipe.c               |    2 +-
 net/sunrpc/stats.c                  |    4 ++--
 sound/core/init.c                   |    3 ++-
 sound/core/sound.c                  |    2 +-
 sound/sound_core.c                  |   22 +++++++++++-----------
 38 files changed, 66 insertions(+), 65 deletions(-)

Index: linux-2.6.15/drivers/char/drm/drm_stub.c
===================================================================
--- linux-2.6.15.orig/drivers/char/drm/drm_stub.c
+++ linux-2.6.15/drivers/char/drm/drm_stub.c
@@ -142,7 +142,7 @@ int drm_stub_open(struct inode *inode, s
 	drm_device_t *dev = NULL;
 	int minor = iminor(inode);
 	int err = -ENODEV;
-	struct file_operations *old_fops;
+	const struct file_operations *old_fops;
 
 	DRM_DEBUG("\n");
 
Index: linux-2.6.15/drivers/char/drm/i810_dma.c
===================================================================
--- linux-2.6.15.orig/drivers/char/drm/i810_dma.c
+++ linux-2.6.15/drivers/char/drm/i810_dma.c
@@ -127,7 +127,7 @@ static int i810_map_buffer(drm_buf_t * b
 	drm_device_t *dev = priv->head->dev;
 	drm_i810_buf_priv_t *buf_priv = buf->dev_private;
 	drm_i810_private_t *dev_priv = dev->dev_private;
-	struct file_operations *old_fops;
+	const struct file_operations *old_fops;
 	int retcode = 0;
 
 	if (buf_priv->currently_mapped == I810_BUF_MAPPED)
Index: linux-2.6.15/drivers/char/drm/i830_dma.c
===================================================================
--- linux-2.6.15.orig/drivers/char/drm/i830_dma.c
+++ linux-2.6.15/drivers/char/drm/i830_dma.c
@@ -129,7 +129,7 @@ static int i830_map_buffer(drm_buf_t * b
 	drm_device_t *dev = priv->head->dev;
 	drm_i830_buf_priv_t *buf_priv = buf->dev_private;
 	drm_i830_private_t *dev_priv = dev->dev_private;
-	struct file_operations *old_fops;
+	const struct file_operations *old_fops;
 	unsigned long virtual;
 	int retcode = 0;
 
Index: linux-2.6.15/drivers/char/mem.c
===================================================================
--- linux-2.6.15.orig/drivers/char/mem.c
+++ linux-2.6.15/drivers/char/mem.c
@@ -889,7 +889,7 @@ static const struct {
 	unsigned int		minor;
 	char			*name;
 	umode_t			mode;
-	struct file_operations	*fops;
+	const struct file_operations	*fops;
 } devlist[] = { /* list of minor devices */
 	{1, "mem",     S_IRUSR | S_IWUSR | S_IRGRP, &mem_fops},
 	{2, "kmem",    S_IRUSR | S_IWUSR | S_IRGRP, &kmem_fops},
Index: linux-2.6.15/drivers/char/misc.c
===================================================================
--- linux-2.6.15.orig/drivers/char/misc.c
+++ linux-2.6.15/drivers/char/misc.c
@@ -129,7 +129,7 @@ static int misc_open(struct inode * inod
 	int minor = iminor(inode);
 	struct miscdevice *c;
 	int err = -ENODEV;
-	struct file_operations *old_fops, *new_fops = NULL;
+	const struct file_operations *old_fops, *new_fops = NULL;
 	
 	down(&misc_sem);
 	
Index: linux-2.6.15/drivers/input/input.c
===================================================================
--- linux-2.6.15.orig/drivers/input/input.c
+++ linux-2.6.15/drivers/input/input.c
@@ -866,7 +866,7 @@ void input_unregister_handler(struct inp
 static int input_open_file(struct inode *inode, struct file *file)
 {
 	struct input_handler *handler = input_table[iminor(inode) >> 5];
-	struct file_operations *old_fops, *new_fops = NULL;
+	const struct file_operations *old_fops, *new_fops = NULL;
 	int err;
 
 	/* No load-on-demand here? */
Index: linux-2.6.15/drivers/isdn/capi/kcapi_proc.c
===================================================================
--- linux-2.6.15.orig/drivers/isdn/capi/kcapi_proc.c
+++ linux-2.6.15/drivers/isdn/capi/kcapi_proc.c
@@ -233,7 +233,7 @@ static struct file_operations proc_appls
 };
 
 static void
-create_seq_entry(char *name, mode_t mode, struct file_operations *f)
+create_seq_entry(char *name, mode_t mode, const struct file_operations *f)
 {
 	struct proc_dir_entry *entry;
 	entry = create_proc_entry(name, mode, NULL);
Index: linux-2.6.15/drivers/media/dvb/dvb-core/dvbdev.c
===================================================================
--- linux-2.6.15.orig/drivers/media/dvb/dvb-core/dvbdev.c
+++ linux-2.6.15/drivers/media/dvb/dvb-core/dvbdev.c
@@ -86,7 +86,7 @@ static int dvb_device_open(struct inode 
 
 	if (dvbdev && dvbdev->fops) {
 		int err = 0;
-		struct file_operations *old_fops;
+		const struct file_operations *old_fops;
 
 		file->private_data = dvbdev;
 		old_fops = file->f_op;
Index: linux-2.6.15/drivers/media/video/videodev.c
===================================================================
--- linux-2.6.15.orig/drivers/media/video/videodev.c
+++ linux-2.6.15/drivers/media/video/videodev.c
@@ -100,7 +100,7 @@ static int video_open(struct inode *inod
 	unsigned int minor = iminor(inode);
 	int err = 0;
 	struct video_device *vfl;
-	struct file_operations *old_fops;
+	const struct file_operations *old_fops;
 
 	if(minor>=VIDEO_NUM_DEVICES)
 		return -ENODEV;
Index: linux-2.6.15/drivers/message/i2o/i2o_proc.c
===================================================================
--- linux-2.6.15.orig/drivers/message/i2o/i2o_proc.c
+++ linux-2.6.15/drivers/message/i2o/i2o_proc.c
@@ -56,7 +56,7 @@
 typedef struct _i2o_proc_entry_t {
 	char *name;		/* entry name */
 	mode_t mode;		/* mode */
-	struct file_operations *fops;	/* open function */
+	const struct file_operations *fops;	/* open function */
 } i2o_proc_entry;
 
 /* global I2O /proc/i2o entry */
Index: linux-2.6.15/drivers/oprofile/oprofilefs.c
===================================================================
--- linux-2.6.15.orig/drivers/oprofile/oprofilefs.c
+++ linux-2.6.15/drivers/oprofile/oprofilefs.c
@@ -130,7 +130,7 @@ static struct file_operations ulong_ro_f
 
 
 static struct dentry * __oprofilefs_create_file(struct super_block * sb,
-	struct dentry * root, char const * name, struct file_operations * fops,
+	struct dentry * root, char const * name, const struct file_operations * fops,
 	int perm)
 {
 	struct dentry * dentry;
@@ -203,7 +203,7 @@ int oprofilefs_create_ro_atomic(struct s
 
  
 int oprofilefs_create_file(struct super_block * sb, struct dentry * root,
-	char const * name, struct file_operations * fops)
+	char const * name, const struct file_operations * fops)
 {
 	if (!__oprofilefs_create_file(sb, root, name, fops, 0644))
 		return -EFAULT;
@@ -212,7 +212,7 @@ int oprofilefs_create_file(struct super_
 
 
 int oprofilefs_create_file_perm(struct super_block * sb, struct dentry * root,
-	char const * name, struct file_operations * fops, int perm)
+	char const * name, const struct file_operations * fops, int perm)
 {
 	if (!__oprofilefs_create_file(sb, root, name, fops, perm))
 		return -EFAULT;
Index: linux-2.6.15/drivers/usb/core/file.c
===================================================================
--- linux-2.6.15.orig/drivers/usb/core/file.c
+++ linux-2.6.15/drivers/usb/core/file.c
@@ -24,15 +24,15 @@
 #include "usb.h"
 
 #define MAX_USB_MINORS	256
-static struct file_operations *usb_minors[MAX_USB_MINORS];
+static const struct file_operations *usb_minors[MAX_USB_MINORS];
 static DEFINE_SPINLOCK(minor_lock);
 
 static int usb_open(struct inode * inode, struct file * file)
 {
 	int minor = iminor(inode);
-	struct file_operations *c;
+	const struct file_operations *c;
 	int err = -ENODEV;
-	struct file_operations *old_fops, *new_fops = NULL;
+	const struct file_operations *old_fops, *new_fops = NULL;
 
 	spin_lock (&minor_lock);
 	c = usb_minors[minor];
Index: linux-2.6.15/fs/char_dev.c
===================================================================
--- linux-2.6.15.orig/fs/char_dev.c
+++ linux-2.6.15/fs/char_dev.c
@@ -201,7 +201,7 @@ int alloc_chrdev_region(dev_t *dev, unsi
 }
 
 int register_chrdev(unsigned int major, const char *name,
-		    struct file_operations *fops)
+		    const struct file_operations *fops)
 {
 	struct char_device_struct *cd;
 	struct cdev *cdev;
@@ -425,7 +425,7 @@ struct cdev *cdev_alloc(void)
 	return p;
 }
 
-void cdev_init(struct cdev *cdev, struct file_operations *fops)
+void cdev_init(struct cdev *cdev, const struct file_operations *fops)
 {
 	memset(cdev, 0, sizeof *cdev);
 	INIT_LIST_HEAD(&cdev->list);
Index: linux-2.6.15/fs/debugfs/inode.c
===================================================================
--- linux-2.6.15.orig/fs/debugfs/inode.c
+++ linux-2.6.15/fs/debugfs/inode.c
@@ -191,7 +191,7 @@ static int debugfs_create_by_name(const 
  */
 struct dentry *debugfs_create_file(const char *name, mode_t mode,
 				   struct dentry *parent, void *data,
-				   struct file_operations *fops)
+				   const struct file_operations *fops)
 {
 	struct dentry *dentry = NULL;
 	int error;
Index: linux-2.6.15/fs/inode.c
===================================================================
--- linux-2.6.15.orig/fs/inode.c
+++ linux-2.6.15/fs/inode.c
@@ -103,7 +103,7 @@ static struct inode *alloc_inode(struct 
 {
 	static struct address_space_operations empty_aops;
 	static struct inode_operations empty_iops;
-	static struct file_operations empty_fops;
+	static const struct file_operations empty_fops;
 	struct inode *inode;
 
 	if (sb->s_op->alloc_inode)
Index: linux-2.6.15/fs/nfsd/vfs.c
===================================================================
--- linux-2.6.15.orig/fs/nfsd/vfs.c
+++ linux-2.6.15/fs/nfsd/vfs.c
@@ -718,7 +718,7 @@ nfsd_close(struct file *filp)
  * after it.
  */
 static inline void nfsd_dosync(struct file *filp, struct dentry *dp,
-			       struct file_operations *fop)
+			       const struct file_operations *fop)
 {
 	struct inode *inode = dp->d_inode;
 	int (*fsync) (struct file *, struct dentry *, int);
Index: linux-2.6.15/fs/proc/generic.c
===================================================================
--- linux-2.6.15.orig/fs/proc/generic.c
+++ linux-2.6.15/fs/proc/generic.c
@@ -535,7 +535,7 @@ static void proc_kill_inodes(struct proc
 		struct file * filp = list_entry(p, struct file, f_u.fu_list);
 		struct dentry * dentry = filp->f_dentry;
 		struct inode * inode;
-		struct file_operations *fops;
+		const struct file_operations *fops;
 
 		if (dentry->d_op != &proc_dentry_operations)
 			continue;
Index: linux-2.6.15/fs/proc/internal.h
===================================================================
--- linux-2.6.15.orig/fs/proc/internal.h
+++ linux-2.6.15/fs/proc/internal.h
@@ -30,7 +30,7 @@ do {						\
 
 #endif
 
-extern void create_seq_entry(char *name, mode_t mode, struct file_operations *f);
+extern void create_seq_entry(char *name, mode_t mode, const struct file_operations *f);
 extern int proc_exe_link(struct inode *, struct dentry **, struct vfsmount **);
 extern int proc_tid_stat(struct task_struct *,  char *);
 extern int proc_tgid_stat(struct task_struct *, char *);
Index: linux-2.6.15/fs/proc/proc_misc.c
===================================================================
--- linux-2.6.15.orig/fs/proc/proc_misc.c
+++ linux-2.6.15/fs/proc/proc_misc.c
@@ -555,7 +555,7 @@ static struct file_operations proc_sysrq
 
 struct proc_dir_entry *proc_root_kcore;
 
-void create_seq_entry(char *name, mode_t mode, struct file_operations *f)
+void create_seq_entry(char *name, mode_t mode, const struct file_operations *f)
 {
 	struct proc_dir_entry *entry;
 	entry = create_proc_entry(name, mode, NULL);
Index: linux-2.6.15/fs/select.c
===================================================================
--- linux-2.6.15.orig/fs/select.c
+++ linux-2.6.15/fs/select.c
@@ -210,7 +210,7 @@ int do_select(int n, fd_set_bits *fds, l
 		for (i = 0; i < n; ++rinp, ++routp, ++rexp) {
 			unsigned long in, out, ex, all_bits, bit = 1, mask, j;
 			unsigned long res_in = 0, res_out = 0, res_ex = 0;
-			struct file_operations *f_op = NULL;
+			const struct file_operations *f_op = NULL;
 			struct file *file = NULL;
 
 			in = *inp++; out = *outp++; ex = *exp++;
Index: linux-2.6.15/include/linux/cdev.h
===================================================================
--- linux-2.6.15.orig/include/linux/cdev.h
+++ linux-2.6.15/include/linux/cdev.h
@@ -5,13 +5,13 @@
 struct cdev {
 	struct kobject kobj;
 	struct module *owner;
-	struct file_operations *ops;
+	const struct file_operations *ops;
 	struct list_head list;
 	dev_t dev;
 	unsigned int count;
 };
 
-void cdev_init(struct cdev *, struct file_operations *);
+void cdev_init(struct cdev *, const struct file_operations *);
 
 struct cdev *cdev_alloc(void);
 
Index: linux-2.6.15/include/linux/debugfs.h
===================================================================
--- linux-2.6.15.orig/include/linux/debugfs.h
+++ linux-2.6.15/include/linux/debugfs.h
@@ -24,7 +24,7 @@ struct file_operations;
 #if defined(CONFIG_DEBUG_FS)
 struct dentry *debugfs_create_file(const char *name, mode_t mode,
 				   struct dentry *parent, void *data,
-				   struct file_operations *fops);
+				   const struct file_operations *fops);
 
 struct dentry *debugfs_create_dir(const char *name, struct dentry *parent);
 
Index: linux-2.6.15/include/linux/fs.h
===================================================================
--- linux-2.6.15.orig/include/linux/fs.h
+++ linux-2.6.15/include/linux/fs.h
@@ -456,7 +456,7 @@ struct inode {
 	struct semaphore	i_sem;
 	struct rw_semaphore	i_alloc_sem;
 	struct inode_operations	*i_op;
-	struct file_operations	*i_fop;	/* former ->i_op->default_file_ops */
+	const struct file_operations	*i_fop;	/* former ->i_op->default_file_ops */
 	struct super_block	*i_sb;
 	struct file_lock	*i_flock;
 	struct address_space	*i_mapping;
@@ -596,7 +596,7 @@ struct file {
 	} f_u;
 	struct dentry		*f_dentry;
 	struct vfsmount         *f_vfsmnt;
-	struct file_operations	*f_op;
+	const struct file_operations	*f_op;
 	atomic_t		f_count;
 	unsigned int 		f_flags;
 	mode_t			f_mode;
@@ -1356,7 +1356,7 @@ extern void bd_release(struct block_devi
 extern int alloc_chrdev_region(dev_t *, unsigned, unsigned, const char *);
 extern int register_chrdev_region(dev_t, unsigned, const char *);
 extern int register_chrdev(unsigned int, const char *,
-			   struct file_operations *);
+			   const struct file_operations *);
 extern int unregister_chrdev(unsigned int, const char *);
 extern void unregister_chrdev_region(dev_t, unsigned);
 extern int chrdev_open(struct inode *, struct file *);
Index: linux-2.6.15/include/linux/input.h
===================================================================
--- linux-2.6.15.orig/include/linux/input.h
+++ linux-2.6.15/include/linux/input.h
@@ -954,7 +954,7 @@ struct input_handler {
 	struct input_handle* (*connect)(struct input_handler *handler, struct input_dev *dev, struct input_device_id *id);
 	void (*disconnect)(struct input_handle *handle);
 
-	struct file_operations *fops;
+	const struct file_operations *fops;
 	int minor;
 	char *name;
 
Index: linux-2.6.15/include/linux/miscdevice.h
===================================================================
--- linux-2.6.15.orig/include/linux/miscdevice.h
+++ linux-2.6.15/include/linux/miscdevice.h
@@ -36,7 +36,7 @@ struct class_device;
 struct miscdevice  {
 	int minor;
 	const char *name;
-	struct file_operations *fops;
+	const struct file_operations *fops;
 	struct list_head list;
 	struct device *dev;
 	struct class_device *class;
Index: linux-2.6.15/include/linux/oprofile.h
===================================================================
--- linux-2.6.15.orig/include/linux/oprofile.h
+++ linux-2.6.15/include/linux/oprofile.h
@@ -74,10 +74,10 @@ void oprofile_add_trace(unsigned long ei
  * the specified file operations.
  */
 int oprofilefs_create_file(struct super_block * sb, struct dentry * root,
-	char const * name, struct file_operations * fops);
+	char const * name, const struct file_operations * fops);
 
 int oprofilefs_create_file_perm(struct super_block * sb, struct dentry * root,
-	char const * name, struct file_operations * fops, int perm);
+	char const * name, const struct file_operations * fops, int perm);
  
 /** Create a file for read/write access to an unsigned long. */
 int oprofilefs_create_ulong(struct super_block * sb, struct dentry * root,
Index: linux-2.6.15/include/linux/proc_fs.h
===================================================================
--- linux-2.6.15.orig/include/linux/proc_fs.h
+++ linux-2.6.15/include/linux/proc_fs.h
@@ -57,7 +57,7 @@ struct proc_dir_entry {
 	gid_t gid;
 	unsigned long size;
 	struct inode_operations * proc_iops;
-	struct file_operations * proc_fops;
+	const struct file_operations * proc_fops;
 	get_info_t *get_info;
 	struct module *owner;
 	struct proc_dir_entry *next, *parent, *subdir;
@@ -181,7 +181,7 @@ static inline struct proc_dir_entry *pro
 }
 
 static inline struct proc_dir_entry *proc_net_fops_create(const char *name,
-	mode_t mode, struct file_operations *fops)
+	mode_t mode, const struct file_operations *fops)
 {
 	struct proc_dir_entry *res = create_proc_entry(name, mode, proc_net);
 	if (res)
Index: linux-2.6.15/include/linux/sound.h
===================================================================
--- linux-2.6.15.orig/include/linux/sound.h
+++ linux-2.6.15/include/linux/sound.h
@@ -30,12 +30,12 @@
  */
  
 struct device;
-extern int register_sound_special(struct file_operations *fops, int unit);
-extern int register_sound_special_device(struct file_operations *fops, int unit, struct device *dev);
-extern int register_sound_mixer(struct file_operations *fops, int dev);
-extern int register_sound_midi(struct file_operations *fops, int dev);
-extern int register_sound_dsp(struct file_operations *fops, int dev);
-extern int register_sound_synth(struct file_operations *fops, int dev);
+extern int register_sound_special(const struct file_operations *fops, int unit);
+extern int register_sound_special_device(const struct file_operations *fops, int unit, struct device *dev);
+extern int register_sound_mixer(const struct file_operations *fops, int dev);
+extern int register_sound_midi(const struct file_operations *fops, int dev);
+extern int register_sound_dsp(const struct file_operations *fops, int dev);
+extern int register_sound_synth(const struct file_operations *fops, int dev);
 
 extern void unregister_sound_special(int unit);
 extern void unregister_sound_mixer(int unit);
Index: linux-2.6.15/include/linux/sunrpc/stats.h
===================================================================
--- linux-2.6.15.orig/include/linux/sunrpc/stats.h
+++ linux-2.6.15/include/linux/sunrpc/stats.h
@@ -50,7 +50,7 @@ struct proc_dir_entry *	rpc_proc_registe
 void			rpc_proc_unregister(const char *);
 void			rpc_proc_zero(struct rpc_program *);
 struct proc_dir_entry *	svc_proc_register(struct svc_stat *,
-					  struct file_operations *);
+					  const struct file_operations *);
 void			svc_proc_unregister(const char *);
 
 void			svc_seq_show(struct seq_file *,
@@ -65,7 +65,7 @@ static inline void rpc_proc_unregister(c
 static inline void rpc_proc_zero(struct rpc_program *p) {}
 
 static inline struct proc_dir_entry *svc_proc_register(struct svc_stat *s,
-						       struct file_operations *f) { return NULL; }
+						       const struct file_operations *f) { return NULL; }
 static inline void svc_proc_unregister(const char *p) {}
 
 static inline void svc_seq_show(struct seq_file *seq,
Index: linux-2.6.15/include/linux/usb.h
===================================================================
--- linux-2.6.15.orig/include/linux/usb.h
+++ linux-2.6.15/include/linux/usb.h
@@ -606,7 +606,7 @@ extern struct bus_type usb_bus_type;
  */
 struct usb_class_driver {
 	char *name;
-	struct file_operations *fops;
+	const struct file_operations *fops;
 	int minor_base;
 };
 
Index: linux-2.6.15/include/linux/videodev2.h
===================================================================
--- linux-2.6.15.orig/include/linux/videodev2.h
+++ linux-2.6.15/include/linux/videodev2.h
@@ -64,7 +64,7 @@ struct video_device
 	int minor;
 
 	/* device ops + callbacks */
-	struct file_operations *fops;
+	const struct file_operations *fops;
 	void (*release)(struct video_device *vfd);
 
 
Index: linux-2.6.15/include/sound/core.h
===================================================================
--- linux-2.6.15.orig/include/sound/core.h
+++ linux-2.6.15/include/sound/core.h
@@ -246,7 +246,7 @@ struct _snd_minor {
 	int number;			/* minor number */
 	int device;			/* device number */
 	const char *comment;		/* for /proc/asound/devices */
-	struct file_operations *f_ops;	/* file operations */
+	const struct file_operations *f_ops;	/* file operations */
 	char name[0];			/* device name (keep at the end of
 								structure) */
 };
Index: linux-2.6.15/net/sunrpc/rpc_pipe.c
===================================================================
--- linux-2.6.15.orig/net/sunrpc/rpc_pipe.c
+++ linux-2.6.15/net/sunrpc/rpc_pipe.c
@@ -371,7 +371,7 @@ enum {
  */
 struct rpc_filelist {
 	char *name;
-	struct file_operations *i_fop;
+	const struct file_operations *i_fop;
 	int mode;
 };
 
Index: linux-2.6.15/net/sunrpc/stats.c
===================================================================
--- linux-2.6.15.orig/net/sunrpc/stats.c
+++ linux-2.6.15/net/sunrpc/stats.c
@@ -110,7 +110,7 @@ void svc_seq_show(struct seq_file *seq, 
  * Register/unregister RPC proc files
  */
 static inline struct proc_dir_entry *
-do_register(const char *name, void *data, struct file_operations *fops)
+do_register(const char *name, void *data, const struct file_operations *fops)
 {
 	struct proc_dir_entry *ent;
 
@@ -138,7 +138,7 @@ rpc_proc_unregister(const char *name)
 }
 
 struct proc_dir_entry *
-svc_proc_register(struct svc_stat *statp, struct file_operations *fops)
+svc_proc_register(struct svc_stat *statp, const struct file_operations *fops)
 {
 	return do_register(statp->program->pg_name, statp, fops);
 }
Index: linux-2.6.15/sound/core/init.c
===================================================================
--- linux-2.6.15.orig/sound/core/init.c
+++ linux-2.6.15/sound/core/init.c
@@ -163,7 +163,8 @@ int snd_card_disconnect(snd_card_t * car
 	struct snd_monitor_file *mfile;
 	struct file *file;
 	struct snd_shutdown_f_ops *s_f_ops;
-	struct file_operations *f_ops, *old_f_ops;
+	struct file_operations *f_ops;
+	const struct file_operations *old_f_ops;
 	int err;
 
 	spin_lock(&card->files_lock);
Index: linux-2.6.15/sound/core/sound.c
===================================================================
--- linux-2.6.15.orig/sound/core/sound.c
+++ linux-2.6.15/sound/core/sound.c
@@ -127,7 +127,7 @@ static int snd_open(struct inode *inode,
 	int card = SNDRV_MINOR_CARD(minor);
 	int dev = SNDRV_MINOR_DEVICE(minor);
 	snd_minor_t *mptr = NULL;
-	struct file_operations *old_fops;
+	const struct file_operations *old_fops;
 	int err = 0;
 
 	if (dev != SNDRV_MINOR_GLOBAL) {
Index: linux-2.6.15/sound/sound_core.c
===================================================================
--- linux-2.6.15.orig/sound/sound_core.c
+++ linux-2.6.15/sound/sound_core.c
@@ -53,7 +53,7 @@
 struct sound_unit
 {
 	int unit_minor;
-	struct file_operations *unit_fops;
+	const struct file_operations *unit_fops;
 	struct sound_unit *next;
 	char name[32];
 };
@@ -73,7 +73,7 @@ EXPORT_SYMBOL(sound_class);
  *	join into it. Called with the lock asserted
  */
 
-static int __sound_insert_unit(struct sound_unit * s, struct sound_unit **list, struct file_operations *fops, int index, int low, int top)
+static int __sound_insert_unit(struct sound_unit * s, struct sound_unit **list, const struct file_operations *fops, int index, int low, int top)
 {
 	int n=low;
 
@@ -153,7 +153,7 @@ static DEFINE_SPINLOCK(sound_loader_lock
  *	list. Acquires locks as needed
  */
 
-static int sound_insert_unit(struct sound_unit **list, struct file_operations *fops, int index, int low, int top, const char *name, umode_t mode, struct device *dev)
+static int sound_insert_unit(struct sound_unit **list, const struct file_operations *fops, int index, int low, int top, const char *name, umode_t mode, struct device *dev)
 {
 	struct sound_unit *s = kmalloc(sizeof(*s), GFP_KERNEL);
 	int r;
@@ -237,7 +237,7 @@ static struct sound_unit *chains[SOUND_S
  *	a negative error code is returned.
  */
  
-int register_sound_special_device(struct file_operations *fops, int unit,
+int register_sound_special_device(const struct file_operations *fops, int unit,
 				  struct device *dev)
 {
 	const int chain = unit % SOUND_STEP;
@@ -301,7 +301,7 @@ int register_sound_special_device(struct
  
 EXPORT_SYMBOL(register_sound_special_device);
 
-int register_sound_special(struct file_operations *fops, int unit)
+int register_sound_special(const struct file_operations *fops, int unit)
 {
 	return register_sound_special_device(fops, unit, NULL);
 }
@@ -318,7 +318,7 @@ EXPORT_SYMBOL(register_sound_special);
  *	number is returned, on failure a negative error code is returned.
  */
 
-int register_sound_mixer(struct file_operations *fops, int dev)
+int register_sound_mixer(const struct file_operations *fops, int dev)
 {
 	return sound_insert_unit(&chains[0], fops, dev, 0, 128,
 				 "mixer", S_IRUSR | S_IWUSR, NULL);
@@ -336,7 +336,7 @@ EXPORT_SYMBOL(register_sound_mixer);
  *	number is returned, on failure a negative error code is returned.
  */
 
-int register_sound_midi(struct file_operations *fops, int dev)
+int register_sound_midi(const struct file_operations *fops, int dev)
 {
 	return sound_insert_unit(&chains[2], fops, dev, 2, 130,
 				 "midi", S_IRUSR | S_IWUSR, NULL);
@@ -362,7 +362,7 @@ EXPORT_SYMBOL(register_sound_midi);
  *	and will always allocate them as a matching pair - eg dsp3/audio3
  */
 
-int register_sound_dsp(struct file_operations *fops, int dev)
+int register_sound_dsp(const struct file_operations *fops, int dev)
 {
 	return sound_insert_unit(&chains[3], fops, dev, 3, 131,
 				 "dsp", S_IWUSR | S_IRUSR, NULL);
@@ -381,7 +381,7 @@ EXPORT_SYMBOL(register_sound_dsp);
  */
 
 
-int register_sound_synth(struct file_operations *fops, int dev)
+int register_sound_synth(const struct file_operations *fops, int dev)
 {
 	return sound_insert_unit(&chains[9], fops, dev, 9, 137,
 				 "synth", S_IRUSR | S_IWUSR, NULL);
@@ -501,7 +501,7 @@ int soundcore_open(struct inode *inode, 
 	int chain;
 	int unit = iminor(inode);
 	struct sound_unit *s;
-	struct file_operations *new_fops = NULL;
+	const struct file_operations *new_fops = NULL;
 
 	chain=unit&0x0F;
 	if(chain==4 || chain==5)	/* dsp/audio/dsp16 */
@@ -540,7 +540,7 @@ int soundcore_open(struct inode *inode, 
 		 * switching ->f_op in the first place.
 		 */
 		int err = 0;
-		struct file_operations *old_fops = file->f_op;
+		const struct file_operations *old_fops = file->f_op;
 		file->f_op = new_fops;
 		spin_unlock(&sound_loader_lock);
 		if(file->f_op->open)
Index: linux-2.6.15/drivers/telephony/phonedev.c
===================================================================
--- linux-2.6.15.orig/drivers/telephony/phonedev.c
+++ linux-2.6.15/drivers/telephony/phonedev.c
@@ -48,7 +48,7 @@ static int phone_open(struct inode *inod
 	unsigned int minor = iminor(inode);
 	int err = 0;
 	struct phone_device *p;
-	struct file_operations *old_fops, *new_fops = NULL;
+	const struct file_operations *old_fops, *new_fops = NULL;
 
 	if (minor >= PHONE_NUM_DEVICES)
 		return -ENODEV;


