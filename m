Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752218AbWAEVnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbWAEVnF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 16:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752220AbWAEVnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 16:43:05 -0500
Received: from marski.suomi.net ([212.50.131.142]:22441 "EHLO marski.suomi.net")
	by vger.kernel.org with ESMTP id S1752219AbWAEVnB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 16:43:01 -0500
Date: Thu, 05 Jan 2006 23:42:53 +0200
From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH] Remove gfp argument from kstrdup()
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <20060105234253.758b126a.tihirvon@gmail.com>
MIME-version: 1.0
X-Mailer: Sylpheed version 2.2.0beta2 (GTK+ 2.8.9; i686-pc-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
X-OPOY-MailScanner-Information: Please contact the OPOY for more information
X-OPOY-MailScanner: Found to be clean
X-OPOY-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.355,	required 5,
 autolearn=not spam, AWL 0.24, BAYES_00 -2.60)
X-OPOY-MailScanner-From: tihirvon@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


All kstrdup() callers use GFP_KERNEL flag so this parameter seems to be
useless.

Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>

---

 arch/um/kernel/process_kern.c       |    2 +-
 drivers/infiniband/ulp/srp/ib_srp.c |    2 +-
 drivers/md/dm-ioctl.c               |    6 +++---
 drivers/parport/probe.c             |   10 +++++-----
 include/linux/fsnotify.h            |    2 +-
 include/linux/string.h              |    2 +-
 kernel/module.c                     |    2 +-
 mm/slab.c                           |    5 ++---
 net/core/neighbour.c                |    2 +-
 net/ipv4/devinet.c                  |    2 +-
 net/ipv6/addrconf.c                 |    2 +-
 net/sunrpc/svcauth_unix.c           |    2 +-
 security/selinux/hooks.c            |    2 +-
 sound/core/info.c                   |    2 +-
 sound/core/info_oss.c               |    2 +-
 sound/core/oss/mixer_oss.c          |    2 +-
 sound/core/oss/pcm_oss.c            |    2 +-
 sound/core/timer.c                  |    2 +-
 sound/isa/gus/gus_mem.c             |    6 +++---
 sound/pci/hda/patch_analog.c        |    2 +-
 sound/pci/hda/patch_realtek.c       |    2 +-
 sound/pci/hda/patch_sigmatel.c      |    2 +-
 sound/synth/emux/emux.c             |    2 +-
 23 files changed, 32 insertions(+), 33 deletions(-)

e61add31c2fa0ff747154d61424eb4a098b64827
diff --git a/arch/um/kernel/process_kern.c b/arch/um/kernel/process_kern.c
index 34b54a3..390ae34 100644
--- a/arch/um/kernel/process_kern.c
+++ b/arch/um/kernel/process_kern.c
@@ -341,7 +341,7 @@ void do_uml_exitcalls(void)
 
 char *uml_strdup(char *string)
 {
-	return kstrdup(string, GFP_KERNEL);
+	return kstrdup(string);
 }
 
 int copy_to_user_proc(void __user *to, void *from, int size)
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index ee9fe22..3a039f3 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -1323,7 +1323,7 @@ static int srp_parse_options(const char 
 	int ret = -EINVAL;
 	int i;
 
-	options = kstrdup(buf, GFP_KERNEL);
+	options = kstrdup(buf);
 	if (!options)
 		return -ENOMEM;
 
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 07d44e1..37dc3be 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -131,7 +131,7 @@ static struct hash_cell *alloc_cell(cons
 	if (!hc)
 		return NULL;
 
-	hc->name = kstrdup(name, GFP_KERNEL);
+	hc->name = kstrdup(name);
 	if (!hc->name) {
 		kfree(hc);
 		return NULL;
@@ -141,7 +141,7 @@ static struct hash_cell *alloc_cell(cons
 		hc->uuid = NULL;
 
 	else {
-		hc->uuid = kstrdup(uuid, GFP_KERNEL);
+		hc->uuid = kstrdup(uuid);
 		if (!hc->uuid) {
 			kfree(hc->name);
 			kfree(hc);
@@ -274,7 +274,7 @@ static int dm_hash_rename(const char *ol
 	/*
 	 * duplicate new.
 	 */
-	new_name = kstrdup(new, GFP_KERNEL);
+	new_name = kstrdup(new);
 	if (!new_name)
 		return -ENOMEM;
 
diff --git a/drivers/parport/probe.c b/drivers/parport/probe.c
index 4b48b31..77da756 100644
--- a/drivers/parport/probe.c
+++ b/drivers/parport/probe.c
@@ -79,15 +79,15 @@ static void parse_data(struct parport *p
 			}
 			if (!strcmp(p, "MFG") || !strcmp(p, "MANUFACTURER")) {
 				kfree(info->mfr);
-				info->mfr = kstrdup(sep, GFP_KERNEL);
+				info->mfr = kstrdup(sep);
 			} else if (!strcmp(p, "MDL") || !strcmp(p, "MODEL")) {
 				kfree(info->model);
-				info->model = kstrdup(sep, GFP_KERNEL);
+				info->model = kstrdup(sep);
 			} else if (!strcmp(p, "CLS") || !strcmp(p, "CLASS")) {
 				int i;
 
 				kfree(info->class_name);
-				info->class_name = kstrdup(sep, GFP_KERNEL);
+				info->class_name = kstrdup(sep);
 				for (u = sep; *u; u++)
 					*u = toupper(*u);
 				for (i = 0; classes[i].token; i++) {
@@ -101,14 +101,14 @@ static void parse_data(struct parport *p
 			} else if (!strcmp(p, "CMD") ||
 				   !strcmp(p, "COMMAND SET")) {
 				kfree(info->cmdset);
-				info->cmdset = kstrdup(sep, GFP_KERNEL);
+				info->cmdset = kstrdup(sep);
 				/* if it speaks printer language, it's
 				   probably a printer */
 				if (strstr(sep, "PJL") || strstr(sep, "PCL"))
 					guessed_class = PARPORT_CLASS_PRINTER;
 			} else if (!strcmp(p, "DES") || !strcmp(p, "DESCRIPTION")) {
 				kfree(info->description);
-				info->description = kstrdup(sep, GFP_KERNEL);
+				info->description = kstrdup(sep);
 			}
 		}
 	rock_on:
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 03b8e79..864cec0 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -222,7 +222,7 @@ static inline void fsnotify_change(struc
  */
 static inline const char *fsnotify_oldname_init(const char *name)
 {
-	return kstrdup(name, GFP_KERNEL);
+	return kstrdup(name);
 }
 
 /*
diff --git a/include/linux/string.h b/include/linux/string.h
index 369be32..5213d24 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -88,7 +88,7 @@ extern int memcmp(const void *,const voi
 extern void * memchr(const void *,int,__kernel_size_t);
 #endif
 
-extern char *kstrdup(const char *s, gfp_t gfp);
+extern char *kstrdup(const char *s);
 
 #ifdef __cplusplus
 }
diff --git a/kernel/module.c b/kernel/module.c
index 2ea929d..3c96d95 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -382,7 +382,7 @@ static inline void percpu_modcopy(void *
 #define MODINFO_ATTR(field)	\
 static void setup_modinfo_##field(struct module *mod, const char *s)  \
 {                                                                     \
-	mod->field = kstrdup(s, GFP_KERNEL);                          \
+	mod->field = kstrdup(s);                                      \
 }                                                                     \
 static ssize_t show_modinfo_##field(struct module_attribute *mattr,   \
 	                struct module *mod, char *buffer)             \
diff --git a/mm/slab.c b/mm/slab.c
index e5ec26e..48531f6 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3615,9 +3615,8 @@ unsigned int ksize(const void *objp)
  * kstrdup - allocate space for and copy an existing string
  *
  * @s: the string to duplicate
- * @gfp: the GFP mask used in the kmalloc() call when allocating memory
  */
-char *kstrdup(const char *s, gfp_t gfp)
+char *kstrdup(const char *s)
 {
 	size_t len;
 	char *buf;
@@ -3626,7 +3625,7 @@ char *kstrdup(const char *s, gfp_t gfp)
 		return NULL;
 
 	len = strlen(s) + 1;
-	buf = kmalloc(len, gfp);
+	buf = kmalloc(len, GFP_KERNEL);
 	if (buf)
 		memcpy(buf, s, len);
 	return buf;
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index e68700f..2baaf52 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2588,7 +2588,7 @@ int neigh_sysctl_register(struct net_dev
 		t->neigh_vars[17].extra1 = dev;
 	}
 
-	dev_name = kstrdup(dev_name_source, GFP_KERNEL);
+	dev_name = kstrdup(dev_name_source);
 	if (!dev_name) {
 		err = -ENOBUFS;
 		goto free;
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 7b9bb28..8f27f01 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -1492,7 +1492,7 @@ static void devinet_sysctl_register(stru
 	 * by sysctl and we wouldn't want anyone to change it under our feet
 	 * (see SIOCSIFNAME).
 	 */	
-	dev_name = kstrdup(dev_name, GFP_KERNEL);
+	dev_name = kstrdup(dev_name);
 	if (!dev_name)
 	    goto free;
 
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 704fb73..236d36e 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3664,7 +3664,7 @@ static void addrconf_sysctl_register(str
 	 * by sysctl and we wouldn't want anyone to change it under our feet
 	 * (see SIOCSIFNAME).
 	 */	
-	dev_name = kstrdup(dev_name, GFP_KERNEL);
+	dev_name = kstrdup(dev_name);
 	if (!dev_name)
 	    goto free;
 
diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index cac2e77..a938167 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -48,7 +48,7 @@ struct auth_domain *unix_domain_find(cha
 	if (new == NULL)
 		return NULL;
 	cache_init(&new->h.h);
-	new->h.name = kstrdup(name, GFP_KERNEL);
+	new->h.name = kstrdup(name);
 	new->h.flavour = RPC_AUTH_UNIX;
 	new->addr_changes = 0;
 	new->h.h.expiry_time = NEVER;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3d496ea..1818568 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1991,7 +1991,7 @@ static int selinux_inode_init_security(s
 		return -EOPNOTSUPP;
 
 	if (name) {
-		namep = kstrdup(XATTR_SELINUX_SUFFIX, GFP_KERNEL);
+		namep = kstrdup(XATTR_SELINUX_SUFFIX);
 		if (!namep)
 			return -ENOMEM;
 		*name = namep;
diff --git a/sound/core/info.c b/sound/core/info.c
index ae88539..e33a2d0 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -751,7 +751,7 @@ static struct snd_info_entry *snd_info_c
 	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
 	if (entry == NULL)
 		return NULL;
-	entry->name = kstrdup(name, GFP_KERNEL);
+	entry->name = kstrdup(name);
 	if (entry->name == NULL) {
 		kfree(entry);
 		return NULL;
diff --git a/sound/core/info_oss.c b/sound/core/info_oss.c
index 820f477..cd26382 100644
--- a/sound/core/info_oss.c
+++ b/sound/core/info_oss.c
@@ -52,7 +52,7 @@ int snd_oss_info_register(int dev, int n
 			x = NULL;
 		}
 	} else {
-		x = kstrdup(string, GFP_KERNEL);
+		x = kstrdup(string);
 		if (x == NULL) {
 			up(&strings);
 			return -ENOMEM;
diff --git a/sound/core/oss/mixer_oss.c b/sound/core/oss/mixer_oss.c
index f08e65a..702e74e 100644
--- a/sound/core/oss/mixer_oss.c
+++ b/sound/core/oss/mixer_oss.c
@@ -1157,7 +1157,7 @@ static void snd_mixer_oss_proc_write(str
 			goto __unlock;
 		}
 		tbl->oss_id = ch;
-		tbl->name = kstrdup(str, GFP_KERNEL);
+		tbl->name = kstrdup(str);
 		if (! tbl->name) {
 			kfree(tbl);
 			goto __unlock;
diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index 16df124..7fde5bd 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -2373,7 +2373,7 @@ static void snd_pcm_oss_proc_write(struc
 					for (setup1 = pstr->oss.setup_list; setup1->next; setup1 = setup1->next);
 					setup1->next = setup;
 				}
-				template.task_name = kstrdup(task_name, GFP_KERNEL);
+				template.task_name = kstrdup(task_name);
 			} else {
 				buffer->error = -ENOMEM;
 			}
diff --git a/sound/core/timer.c b/sound/core/timer.c
index 2425b97..a74b692 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -102,7 +102,7 @@ static struct snd_timer_instance *snd_ti
 	timeri = kzalloc(sizeof(*timeri), GFP_KERNEL);
 	if (timeri == NULL)
 		return NULL;
-	timeri->owner = kstrdup(owner, GFP_KERNEL);
+	timeri->owner = kstrdup(owner);
 	if (! timeri->owner) {
 		kfree(timeri);
 		return NULL;
diff --git a/sound/isa/gus/gus_mem.c b/sound/isa/gus/gus_mem.c
index e8bdb86..1d3e8b4 100644
--- a/sound/isa/gus/gus_mem.c
+++ b/sound/isa/gus/gus_mem.c
@@ -214,7 +214,7 @@ struct snd_gf1_mem_block *snd_gf1_mem_al
 	if (share_id != NULL)
 		memcpy(&block.share_id, share_id, sizeof(block.share_id));
 	block.owner = owner;
-	block.name = kstrdup(name, GFP_KERNEL);
+	block.name = kstrdup(name);
 	nblock = snd_gf1_mem_xalloc(alloc, &block);
 	snd_gf1_mem_lock(alloc, 1);
 	return nblock;
@@ -254,13 +254,13 @@ int snd_gf1_mem_init(struct snd_gus_card
 	if (gus->gf1.enh_mode) {
 		block.ptr = 0;
 		block.size = 1024;
-		block.name = kstrdup("InterWave LFOs", GFP_KERNEL);
+		block.name = kstrdup("InterWave LFOs");
 		if (snd_gf1_mem_xalloc(alloc, &block) == NULL)
 			return -ENOMEM;
 	}
 	block.ptr = gus->gf1.default_voice_address;
 	block.size = 4;
-	block.name = kstrdup("Voice default (NULL's)", GFP_KERNEL);
+	block.name = kstrdup("Voice default (NULL's)");
 	if (snd_gf1_mem_xalloc(alloc, &block) == NULL)
 		return -ENOMEM;
 #ifdef CONFIG_SND_DEBUG
diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 1ada1b0..bb80466 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -1637,7 +1637,7 @@ static int add_control(struct ad198x_spe
 
 	knew = &spec->kctl_alloc[spec->num_kctl_used];
 	*knew = ad1988_control_templates[type];
-	knew->name = kstrdup(name, GFP_KERNEL);
+	knew->name = kstrdup(name);
 	if (! knew->name)
 		return -ENOMEM;
 	knew->private_value = val;
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index ad9e501..175def1 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1931,7 +1931,7 @@ static int add_control(struct alc_spec *
 
 	knew = &spec->kctl_alloc[spec->num_kctl_used];
 	*knew = alc880_control_templates[type];
-	knew->name = kstrdup(name, GFP_KERNEL);
+	knew->name = kstrdup(name);
 	if (! knew->name)
 		return -ENOMEM;
 	knew->private_value = val;
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 6190384..cb665be 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -535,7 +535,7 @@ static int stac92xx_add_control(struct s
 
 	knew = &spec->kctl_alloc[spec->num_kctl_used];
 	*knew = stac92xx_control_templates[type];
-	knew->name = kstrdup(name, GFP_KERNEL);
+	knew->name = kstrdup(name);
 	if (! knew->name)
 		return -ENOMEM;
 	knew->private_value = val;
diff --git a/sound/synth/emux/emux.c b/sound/synth/emux/emux.c
index 7c8e328..b601f40 100644
--- a/sound/synth/emux/emux.c
+++ b/sound/synth/emux/emux.c
@@ -100,7 +100,7 @@ int snd_emux_register(struct snd_emux *e
 	snd_assert(name != NULL, return -EINVAL);
 
 	emu->card = card;
-	emu->name = kstrdup(name, GFP_KERNEL);
+	emu->name = kstrdup(name);
 	emu->voices = kcalloc(emu->max_voices, sizeof(struct snd_emux_voice),
 			      GFP_KERNEL);
 	if (emu->voices == NULL)
-- 
1.0.6
