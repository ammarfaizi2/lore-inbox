Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVBGTuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVBGTuY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 14:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbVBGTuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 14:50:09 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:51330 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261266AbVBGThC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 14:37:02 -0500
Date: Mon, 7 Feb 2005 13:36:35 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Michael Halcrow <mhalcrow@us.ibm.com>
Subject: [PATCH] BSD Secure Levels: comment cleanups, 2.6.11-rc2-mm1 (7/8)
Message-ID: <20050207193635.GF834@halcrow.us>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20050207192108.GA776@halcrow.us>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="A9z/3b/E4MkkD+7G"
Content-Disposition: inline
In-Reply-To: <20050207192108.GA776@halcrow.us>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--A9z/3b/E4MkkD+7G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is the seventh in a series of eight patches to the BSD Secure
Levels LSM.  It makes several trivial changes to comments in order to
make the code look more pretty.

Signed off by: Michael Halcrow <mhalcrow@us.ibm.com>

--A9z/3b/E4MkkD+7G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="seclvl_comment_cleanups.patch"

Index: linux-2.6.11-rc2-mm1-modules/security/seclvl.c
===================================================================
--- linux-2.6.11-rc2-mm1-modules.orig/security/seclvl.c	2005-02-03 15:47:52.249082872 -0600
+++ linux-2.6.11-rc2-mm1-modules/security/seclvl.c	2005-02-03 15:54:35.055846936 -0600
@@ -52,7 +52,9 @@
 module_param(initlvl, int, 0);
 MODULE_PARM_DESC(initlvl, "Initial secure level (defaults to 1)");
 
-/* Module parameter that defines the verbosity level */
+/**
+ * Module parameter that defines the verbosity level.
+ */
 static int verbosity;
 module_param(verbosity, int, 0);
 MODULE_PARM_DESC(verbosity, "Initial verbosity level (0 or 1; defaults to "
@@ -166,7 +168,7 @@
 }
 
 /**
- * Callback function pointers for show and store
+ * Callback function pointers for show and store.
  */
 static struct sysfs_ops seclvlfs_sysfs_ops = {
 	.show = seclvl_attr_show,
@@ -185,7 +187,7 @@
 static int seclvl;
 
 /**
- * flag to keep track of how we were registered
+ * Flag to keep track of how we were registered.
  */
 static int secondary;
 
@@ -212,7 +214,7 @@
 
 /**
  * Called whenever the user reads the sysfs handle to this kernel
- * object
+ * object.
  */
 static ssize_t seclvl_read_file(struct seclvl_obj * obj, char * buff)
 {
@@ -220,7 +222,7 @@
 }
 
 /**
- * security level advancement rules:
+ * Security level advancement rules:
  *   Valid levels are -1 through 2, inclusive.
  *   From -1, stuck.  [ in case compiled into kernel ]
  *   From 0 or above, can only increment.
@@ -272,7 +274,9 @@
 	return count;
 }
 
-/* Generate sysfs_attr_seclvl */
+/**
+ * Generate sysfs_attr_seclvl.
+ */
 static struct seclvl_attribute sysfs_attr_seclvl =
 __ATTR(seclvl, (S_IFREG | S_IRUGO | S_IWUSR), seclvl_read_file,
        seclvl_write_file);
@@ -284,12 +288,10 @@
  */
 static ssize_t seclvl_read_passwd(struct seclvl_obj * obj, char * buff)
 {
-	/* So just how good *is* your password? :-) */
 	char tmp[3];
 	int i = 0;
 	buff[0] = '\0';
 	if (hide_hash) {
-		/* Security through obscurity */
 		return 0;
 	}
 	while (i < SHA1_DIGEST_SIZE) {
@@ -325,8 +327,8 @@
 			      "SHA1\n", __FUNCTION__);
 		return -ENOSYS;
 	}
-	// Just get a new page; don't play around with page boundaries
-	// and scatterlists.
+	/* Just get a new page; don't play around with page boundaries
+	   and scatterlists. */
 	pg_virt_addr = (char *)__get_free_page(GFP_KERNEL);
 	if (!pg_virt_addr) {
 		seclvl_printk(0, KERN_ERR "%s: Out of memory\n", __FUNCTION__);
@@ -387,7 +389,9 @@
 	return count;
 }
 
-/* Generate sysfs_attr_passwd */
+/**
+ * Generate sysfs_attr_passwd.
+ */
 static struct seclvl_attribute sysfs_attr_passwd =
 __ATTR(passwd, (S_IFREG | S_IRUGO | S_IWUSR), seclvl_read_passwd,
        seclvl_write_passwd);
@@ -432,7 +436,7 @@
 				      "denied in seclvl [%d]\n", __FUNCTION__,
 				      seclvl);
 			return -EPERM;
-		} else if (cap == CAP_SYS_RAWIO) {	// Somewhat broad...
+		} else if (cap == CAP_SYS_RAWIO) { /* Somewhat broad */
 			seclvl_printk(1, KERN_WARNING "%s: Attempt to perform "
 				      "raw I/O while in secure level [%d] "
 				      "denied\n", __FUNCTION__, seclvl);
@@ -487,8 +491,8 @@
 				      __FUNCTION__, seclvl, current->pid,
 				      current->group_leader->pid);
 			return -EPERM;
-		}		/* if attempt to decrement time */
-	}			/* if seclvl > 1 */
+		}
+	}
 	return 0;
 }
 
@@ -614,7 +618,7 @@
 }
 
 /**
- * Cannot unmount in secure level 2
+ * Cannot unmount in secure level 2.
  */
 static int seclvl_umount(struct vfsmount * mnt, int flags)
 {
@@ -642,7 +646,7 @@
 };
 
 /**
- * Process the password-related module parameters
+ * Process the password-related module parameters.
  */
 static int process_password(void)
 {
@@ -662,9 +666,9 @@
 				      "not in kernel\n", __FUNCTION__);
 			return rc;
 		}
-		/* All static data goes to the BSS, which zero's the
+		/* All static data goes to the BSS, which wipes the
 		 * plaintext password out for us. */
-	} else if (*sha1_passwd) {	// Base 16
+	} else if (*sha1_passwd) { /* Base 16 */
 		int i;
 		i = strlen(sha1_passwd);
 		if (i != (SHA1_DIGEST_SIZE * 2)) {
@@ -688,7 +692,7 @@
 }
 
 /**
- * Sysfs registrations
+ * Sysfs registrations.
  */
 static int do_sysfs_registrations(void)
 {
@@ -744,9 +748,9 @@
 				      "registering with primary security "
 				      "module.\n", __FUNCTION__);
 			goto exit;
-		}		/* if primary module registered */
+		}
 		secondary = 1;
-	}			/* if we registered ourselves with the security framework */
+	}
 	if ((rc = do_sysfs_registrations())) {
 		seclvl_printk(0, KERN_ERR "%s: Error registering with sysfs\n",
 			      __FUNCTION__);

--A9z/3b/E4MkkD+7G--
