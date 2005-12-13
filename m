Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbVLMR4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbVLMR4n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 12:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbVLMR4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 12:56:42 -0500
Received: from verein.lst.de ([213.95.11.210]:35027 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1751090AbVLMR4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 12:56:41 -0500
Date: Tue, 13 Dec 2005 18:56:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org, aia21@cantab.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] ntfs: remove superflous MS_NOATIME/MS_NODIRATIME assignments
Message-ID: <20051213175630.GA17130@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00,UPPERCASE_25_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MS_RDONLU implies not atime updates at all, no need for the MS_NOATIME
and MS_NODIRATIME flags.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6.15-rc5/fs/ntfs/super.c
===================================================================
--- linux-2.6.15-rc5.orig/fs/ntfs/super.c	2005-12-12 18:31:47.000000000 +0100
+++ linux-2.6.15-rc5/fs/ntfs/super.c	2005-12-12 22:40:06.000000000 +0100
@@ -443,8 +443,8 @@
 
 	ntfs_debug("Entering with remount options string: %s", opt);
 #ifndef NTFS_RW
-	/* For read-only compiled driver, enforce all read-only flags. */
-	*flags |= MS_RDONLY | MS_NOATIME | MS_NODIRATIME;
+	/* For read-only compiled driver, enforce read-only flag. */
+	*flags |= MS_RDONLY;
 #else /* NTFS_RW */
 	/*
 	 * For the read-write compiled driver, if we are remounting read-write,
@@ -1721,7 +1721,7 @@
 						es3);
 				goto iput_mirr_err_out;
 			}
-			sb->s_flags |= MS_RDONLY | MS_NOATIME | MS_NODIRATIME;
+			sb->s_flags |= MS_RDONLY;
 			ntfs_error(sb, "%s.  Mounting read-only%s",
 					!vol->mftmirr_ino ? es1 : es2, es3);
 		} else
@@ -1837,7 +1837,7 @@
 						es1, es2);
 				goto iput_vol_err_out;
 			}
-			sb->s_flags |= MS_RDONLY | MS_NOATIME | MS_NODIRATIME;
+			sb->s_flags |= MS_RDONLY;
 			ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
 		} else
 			ntfs_warning(sb, "%s.  Will not be able to remount "
@@ -1874,7 +1874,7 @@
 				}
 				goto iput_logfile_err_out;
 			}
-			sb->s_flags |= MS_RDONLY | MS_NOATIME | MS_NODIRATIME;
+			sb->s_flags |= MS_RDONLY;
 			ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
 		} else
 			ntfs_warning(sb, "%s.  Will not be able to remount "
@@ -1919,7 +1919,7 @@
 						es1, es2);
 				goto iput_root_err_out;
 			}
-			sb->s_flags |= MS_RDONLY | MS_NOATIME | MS_NODIRATIME;
+			sb->s_flags |= MS_RDONLY;
 			ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
 		} else
 			ntfs_warning(sb, "%s.  Will not be able to remount "
@@ -1943,7 +1943,7 @@
 			goto iput_root_err_out;
 		}
 		ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
-		sb->s_flags |= MS_RDONLY | MS_NOATIME | MS_NODIRATIME;
+		sb->s_flags |= MS_RDONLY;
 		/*
 		 * Do not set NVolErrors() because ntfs_remount() might manage
 		 * to set the dirty flag in which case all would be well.
@@ -1970,7 +1970,7 @@
 			goto iput_root_err_out;
 		}
 		ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
-		sb->s_flags |= MS_RDONLY | MS_NOATIME | MS_NODIRATIME;
+		sb->s_flags |= MS_RDONLY;
 		NVolSetErrors(vol);
 	}
 #endif
@@ -1989,7 +1989,7 @@
 			goto iput_root_err_out;
 		}
 		ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
-		sb->s_flags |= MS_RDONLY | MS_NOATIME | MS_NODIRATIME;
+		sb->s_flags |= MS_RDONLY;
 		NVolSetErrors(vol);
 	}
 #endif /* NTFS_RW */
@@ -2030,7 +2030,7 @@
 						es1, es2);
 				goto iput_quota_err_out;
 			}
-			sb->s_flags |= MS_RDONLY | MS_NOATIME | MS_NODIRATIME;
+			sb->s_flags |= MS_RDONLY;
 			ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
 		} else
 			ntfs_warning(sb, "%s.  Will not be able to remount "
@@ -2053,7 +2053,7 @@
 			goto iput_quota_err_out;
 		}
 		ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
-		sb->s_flags |= MS_RDONLY | MS_NOATIME | MS_NODIRATIME;
+		sb->s_flags |= MS_RDONLY;
 		NVolSetErrors(vol);
 	}
 	/*
@@ -2074,7 +2074,7 @@
 						es1, es2);
 				goto iput_usnjrnl_err_out;
 			}
-			sb->s_flags |= MS_RDONLY | MS_NOATIME | MS_NODIRATIME;
+			sb->s_flags |= MS_RDONLY;
 			ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
 		} else
 			ntfs_warning(sb, "%s.  Will not be able to remount "
@@ -2097,7 +2097,7 @@
 			goto iput_usnjrnl_err_out;
 		}
 		ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
-		sb->s_flags |= MS_RDONLY | MS_NOATIME | MS_NODIRATIME;
+		sb->s_flags |= MS_RDONLY;
 		NVolSetErrors(vol);
 	}
 #endif /* NTFS_RW */
@@ -2689,7 +2689,7 @@
 
 	ntfs_debug("Entering.");
 #ifndef NTFS_RW
-	sb->s_flags |= MS_RDONLY | MS_NOATIME | MS_NODIRATIME;
+	sb->s_flags |= MS_RDONLY;
 #endif /* ! NTFS_RW */
 	/* Allocate a new ntfs_volume and place it in sb->s_fs_info. */
 	sb->s_fs_info = kmalloc(sizeof(ntfs_volume), GFP_NOFS);
