Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284071AbRLALai>; Sat, 1 Dec 2001 06:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284074AbRLALaf>; Sat, 1 Dec 2001 06:30:35 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:63119 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S284071AbRLALaX>; Sat, 1 Dec 2001 06:30:23 -0500
Date: Sat, 1 Dec 2001 13:35:00 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Remove if (foo) kfree(foo) checks in /arch
Message-ID: <Pine.LNX.4.33.0112011333380.11026-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removes the redundant checking of wether foo is a null pointer since its already done
in kfree. This is the first chunk and targets the /arch section only to keep the size down.

diffed against 2.5.1-pre4

diff -urN linux-2.5.1-pre4.orig/arch/i386/kernel/microcode.c linux-2.5.1-pre4.kfree/arch/i386/kernel/microcode.c
--- linux-2.5.1-pre4.orig/arch/i386/kernel/microcode.c	Wed Oct 31 01:13:17 2001
+++ linux-2.5.1-pre4.kfree/arch/i386/kernel/microcode.c	Sat Dec  1 08:40:55 2001
@@ -144,8 +144,7 @@
 {
 	misc_deregister(&microcode_dev);
 	devfs_unregister(devfs_handle);
-	if (mc_applied)
-		kfree(mc_applied);
+	kfree(mc_applied);
 	printk(KERN_INFO "IA-32 Microcode Update Driver v%s unregistered\n",
 			MICROCODE_VERSION);
 }
diff -urN linux-2.5.1-pre4.orig/arch/i386/kernel/mtrr.c linux-2.5.1-pre4.kfree/arch/i386/kernel/mtrr.c
--- linux-2.5.1-pre4.orig/arch/i386/kernel/mtrr.c	Fri Nov  9 23:58:02 2001
+++ linux-2.5.1-pre4.kfree/arch/i386/kernel/mtrr.c	Sat Dec  1 08:41:22 2001
@@ -949,7 +949,7 @@
 /*  Free resources associated with a struct mtrr_state  */
 static void __init finalize_mtrr_state(struct mtrr_state *state)
 {
-    if (state->var_ranges) kfree (state->var_ranges);
+    kfree (state->var_ranges);
 }   /*  End Function finalize_mtrr_state  */


diff -urN linux-2.5.1-pre4.orig/arch/ia64/ia32/sys_ia32.c linux-2.5.1-pre4.kfree/arch/ia64/ia32/sys_ia32.c
--- linux-2.5.1-pre4.orig/arch/ia64/ia32/sys_ia32.c	Sat Nov 10 00:26:17 2001
+++ linux-2.5.1-pre4.kfree/arch/ia64/ia32/sys_ia32.c	Sat Dec  1 08:42:56 2001
@@ -4279,17 +4279,13 @@
 done:
 	if(karg) {
 		if(cmd == NFSCTL_UGIDUPDATE) {
-			if(karg->ca_umap.ug_ident)
-				kfree(karg->ca_umap.ug_ident);
-			if(karg->ca_umap.ug_udimap)
-				kfree(karg->ca_umap.ug_udimap);
-			if(karg->ca_umap.ug_gdimap)
-				kfree(karg->ca_umap.ug_gdimap);
+			kfree(karg->ca_umap.ug_ident);
+			kfree(karg->ca_umap.ug_udimap);
+			kfree(karg->ca_umap.ug_gdimap);
 		}
 		kfree(karg);
 	}
-	if(kres)
-		kfree(kres);
+	kfree(kres);
 	return err;
 }

diff -urN linux-2.5.1-pre4.orig/arch/ia64/kernel/efivars.c linux-2.5.1-pre4.kfree/arch/ia64/kernel/efivars.c
--- linux-2.5.1-pre4.orig/arch/ia64/kernel/efivars.c	Sat Nov 10 00:26:17 2001
+++ linux-2.5.1-pre4.kfree/arch/ia64/kernel/efivars.c	Sat Dec  1 01:20:35 2001
@@ -173,8 +173,8 @@
 	efivar_entry_t *new_efivar = kmalloc(sizeof(efivar_entry_t),
 					     GFP_KERNEL);
 	if (!short_name || !new_efivar)  {
-		if (short_name)        kfree(short_name);
-		if (new_efivar)        kfree(new_efivar);
+		kfree(short_name);
+		kfree(new_efivar);
 		return 1;
 	}
 	memset(short_name, 0, short_name_size+1);
diff -urN linux-2.5.1-pre4.orig/arch/ia64/sn/io/hcl.c linux-2.5.1-pre4.kfree/arch/ia64/sn/io/hcl.c
--- linux-2.5.1-pre4.orig/arch/ia64/sn/io/hcl.c	Thu Apr  5 21:51:47 2001
+++ linux-2.5.1-pre4.kfree/arch/ia64/sn/io/hcl.c	Sat Dec  1 01:16:18 2001
@@ -1145,8 +1145,7 @@

 failure:
 	/* GRAPH_LOCK_DONE_UPDATE(&invent_lock); */
-	if (pinv)
-		kfree(pinv);
+	kfree(pinv);
 	return(rv);
 }

diff -urN linux-2.5.1-pre4.orig/arch/ia64/sn/io/labelcl.c linux-2.5.1-pre4.kfree/arch/ia64/sn/io/labelcl.c
--- linux-2.5.1-pre4.orig/arch/ia64/sn/io/labelcl.c	Thu Apr  5 21:51:47 2001
+++ linux-2.5.1-pre4.kfree/arch/ia64/sn/io/labelcl.c	Sat Dec  1 01:17:55 2001
@@ -213,8 +213,7 @@
 		return(0);

 	/* Free the label list */
-	if (labelcl_info->label_list)
-		kfree(labelcl_info->label_list);
+	kfree(labelcl_info->label_list);

 	/* Now free the label info area */
 	labelcl_info->hwcl_magic = 0;
@@ -299,8 +298,7 @@
 	labelcl_info->num_labels = num_labels+1;
 	labelcl_info->label_list = new_label_list;

-	if (old_label_list != NULL)
-		kfree(old_label_list);
+	kfree(old_label_list);

 	return(0);
 }
@@ -367,8 +365,7 @@
 	}

 	/* The named info doesn't exist. */
-	if (new_label_list)
-		kfree(new_label_list);
+	kfree(new_label_list);

 	return(-1);

diff -urN linux-2.5.1-pre4.orig/arch/mips/kernel/irixelf.c linux-2.5.1-pre4.kfree/arch/mips/kernel/irixelf.c
--- linux-2.5.1-pre4.orig/arch/mips/kernel/irixelf.c	Mon Mar 19 22:35:09 2001
+++ linux-2.5.1-pre4.kfree/arch/mips/kernel/irixelf.c	Sat Dec  1 01:23:07 2001
@@ -779,8 +779,7 @@
 	allow_write_access(interpreter);
 	fput(interpreter);
 out_free_interp:
-	if (elf_interpreter)
-		kfree(elf_interpreter);
+	kfree(elf_interpreter);
 out_free_file:
 out_free_ph:
 	kfree (elf_phdata);
diff -urN linux-2.5.1-pre4.orig/arch/mips64/kernel/ioctl32.c linux-2.5.1-pre4.kfree/arch/mips64/kernel/ioctl32.c
--- linux-2.5.1-pre4.orig/arch/mips64/kernel/ioctl32.c	Sat Sep  1 20:01:28 2001
+++ linux-2.5.1-pre4.kfree/arch/mips64/kernel/ioctl32.c	Sat Dec  1 08:48:11 2001
@@ -215,8 +215,7 @@
 		goto out;
 	}
 out:
-	if(ifc.ifc_buf != NULL)
-		kfree (ifc.ifc_buf);
+	kfree (ifc.ifc_buf);
 	return err;
 }

diff -urN linux-2.5.1-pre4.orig/arch/mips64/kernel/linux32.c linux-2.5.1-pre4.kfree/arch/mips64/kernel/linux32.c
--- linux-2.5.1-pre4.orig/arch/mips64/kernel/linux32.c	Sun Sep  9 19:43:01 2001
+++ linux-2.5.1-pre4.kfree/arch/mips64/kernel/linux32.c	Sat Dec  1 01:34:07 2001
@@ -1959,10 +1959,8 @@
 			ret = -EFAULT;
 	}
 out:
-	if (kargs.oldval)
-		kfree(kargs.oldval);
-	if (kargs.newval)
-		kfree(kargs.newval);
+	kfree(kargs.oldval);
+	kfree(kargs.newval);
 	return ret;
 }

diff -urN linux-2.5.1-pre4.orig/arch/s390x/kernel/ioctl32.c linux-2.5.1-pre4.kfree/arch/s390x/kernel/ioctl32.c
--- linux-2.5.1-pre4.orig/arch/s390x/kernel/ioctl32.c	Thu Nov  8 00:39:36 2001
+++ linux-2.5.1-pre4.kfree/arch/s390x/kernel/ioctl32.c	Sat Dec  1 08:44:01 2001
@@ -193,8 +193,7 @@
 		goto out;
 	}
 out:
-	if(ifc.ifc_buf != NULL)
-		kfree (ifc.ifc_buf);
+	kfree (ifc.ifc_buf);
 	return err;
 }

diff -urN linux-2.5.1-pre4.orig/arch/s390x/kernel/linux32.c linux-2.5.1-pre4.kfree/arch/s390x/kernel/linux32.c
--- linux-2.5.1-pre4.orig/arch/s390x/kernel/linux32.c	Thu Oct 11 18:04:57 2001
+++ linux-2.5.1-pre4.kfree/arch/s390x/kernel/linux32.c	Sat Dec  1 08:44:51 2001
@@ -3727,17 +3727,13 @@
 done:
 	if(karg) {
 		if(cmd == NFSCTL_UGIDUPDATE) {
-			if(karg->ca_umap.ug_ident)
-				kfree(karg->ca_umap.ug_ident);
-			if(karg->ca_umap.ug_udimap)
-				kfree(karg->ca_umap.ug_udimap);
-			if(karg->ca_umap.ug_gdimap)
-				kfree(karg->ca_umap.ug_gdimap);
+			kfree(karg->ca_umap.ug_ident);
+			kfree(karg->ca_umap.ug_udimap);
+			kfree(karg->ca_umap.ug_gdimap);
 		}
 		kfree(karg);
 	}
-	if(kres)
-		kfree(kres);
+	kfree(kres);
 	return err;
 }

diff -urN linux-2.5.1-pre4.orig/arch/sparc64/kernel/ioctl32.c linux-2.5.1-pre4.kfree/arch/sparc64/kernel/ioctl32.c
--- linux-2.5.1-pre4.orig/arch/sparc64/kernel/ioctl32.c	Tue Nov 13 19:16:05 2001
+++ linux-2.5.1-pre4.kfree/arch/sparc64/kernel/ioctl32.c	Sat Dec  1 08:45:45 2001
@@ -246,8 +246,7 @@
 	struct video_clip *cp;

 	cp = kp->clips;
-	if(cp != NULL)
-		kfree(cp);
+	kfree(cp);
 }

 static int get_video_window32(struct video_window *kp, struct video_window32 *up)
@@ -541,8 +540,7 @@
 				err = -EFAULT;
 		}
 	}
-	if(ifc.ifc_buf != NULL)
-		kfree (ifc.ifc_buf);
+	kfree (ifc.ifc_buf);
 	return err;
 }

@@ -1101,10 +1099,11 @@
 	if (err)
 		err = -EFAULT;

-out:	if (cmap.red) kfree(cmap.red);
-	if (cmap.green) kfree(cmap.green);
-	if (cmap.blue) kfree(cmap.blue);
-	if (cmap.transp) kfree(cmap.transp);
+out:
+	kfree(cmap.red);
+	kfree(cmap.green);
+	kfree(cmap.blue);
+	kfree(cmap.transp);
 	return err;
 }

@@ -1433,7 +1432,8 @@
 	if (err)
 		err = -EFAULT;

-out:	if (karg) kfree(karg);
+out:
+	kfree(karg);
 	return err;
 }

@@ -1533,10 +1533,8 @@
 	int i;

 	for (i = 0; i < sgp->iovec_count; i++) {
-		if (kiov->iov_base) {
-			kfree(kiov->iov_base);
-			kiov->iov_base = NULL;
-		}
+		kfree(kiov->iov_base);
+		kiov->iov_base = NULL;
 		kiov++;
 	}
 	kfree(sgp->dxferp);
@@ -1646,10 +1644,8 @@
 		err = -EFAULT;

 out:
-	if (sg_io64.cmdp)
-		kfree(sg_io64.cmdp);
-	if (sg_io64.sbp)
-		kfree(sg_io64.sbp);
+	kfree(sg_io64.cmdp);
+	kfree(sg_io64.sbp);
 	if (sg_io64.dxferp) {
 		if (sg_io64.iovec_count) {
 			free_sg_iovec(&sg_io64);
@@ -1963,8 +1959,8 @@
 	default:
 		break;
 	}
-out:	if (data)
-		kfree(data);
+out:
+	kfree(data);
 	return err ? -EFAULT : 0;
 }

@@ -2750,7 +2746,7 @@
 		break;
 	case VG_CREATE:
 		for (i = 0; i < v->pv_max; i++)
-			if (v->pv[i]) kfree(v->pv[i]);
+			kfree(v->pv[i]);
 		for (i = 0; i < v->lv_max; i++)
 			if (v->lv[i]) put_lv_t(v->lv[i]);
 		kfree(v);
@@ -2867,12 +2863,9 @@
 	}

 out:
-	if (kversion.name)
-		kfree(kversion.name);
-	if (kversion.date)
-		kfree(kversion.date);
-	if (kversion.desc)
-		kfree(kversion.desc);
+	kfree(kversion.name);
+	kfree(kversion.date);
+	kfree(kversion.desc);
 	return ret;
 }

@@ -2929,8 +2922,7 @@
 			ret = -EFAULT;
 	}

-	if (karg.unique != NULL)
-		kfree(karg.unique);
+	kfree(karg.unique);

 	return ret;
 }
@@ -3257,14 +3249,10 @@
 	}

 out:
-	if (karg.send_indices)
-		kfree(karg.send_indices);
-	if (karg.send_sizes)
-		kfree(karg.send_sizes);
-	if (karg.request_indices)
-		kfree(karg.request_indices);
-	if (karg.request_sizes)
-		kfree(karg.request_sizes);
+	kfree(karg.send_indices);
+	kfree(karg.send_sizes);
+	kfree(karg.request_indices);
+	kfree(karg.request_sizes);

 	return ret;
 }
@@ -3318,8 +3306,7 @@
 			ret = -EFAULT;
 	}

-	if (karg.contexts)
-		kfree(karg.contexts);
+	kfree(karg.contexts);

 	return ret;
 }
diff -urN linux-2.5.1-pre4.orig/arch/sparc64/kernel/sys_sparc32.c linux-2.5.1-pre4.kfree/arch/sparc64/kernel/sys_sparc32.c
--- linux-2.5.1-pre4.orig/arch/sparc64/kernel/sys_sparc32.c	Sun Oct 21 19:36:54 2001
+++ linux-2.5.1-pre4.kfree/arch/sparc64/kernel/sys_sparc32.c	Sat Dec  1 08:47:15 2001
@@ -3803,17 +3803,13 @@
 done:
 	if(karg) {
 		if(cmd == NFSCTL_UGIDUPDATE) {
-			if(karg->ca_umap.ug_ident)
-				kfree(karg->ca_umap.ug_ident);
-			if(karg->ca_umap.ug_udimap)
-				kfree(karg->ca_umap.ug_udimap);
-			if(karg->ca_umap.ug_gdimap)
-				kfree(karg->ca_umap.ug_gdimap);
+			kfree(karg->ca_umap.ug_ident);
+			kfree(karg->ca_umap.ug_udimap);
+			kfree(karg->ca_umap.ug_gdimap);
 		}
 		kfree(karg);
 	}
-	if(kres)
-		kfree(kres);
+	kfree(kres);
 	return err;
 }
 #else /* !NFSD */

