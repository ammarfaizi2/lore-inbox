Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281809AbRKVWoN>; Thu, 22 Nov 2001 17:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281808AbRKVWny>; Thu, 22 Nov 2001 17:43:54 -0500
Received: from mailgate.indstate.edu ([139.102.15.118]:19434 "EHLO
	mailgate.indstate.edu") by vger.kernel.org with ESMTP
	id <S281809AbRKVWnc>; Thu, 22 Nov 2001 17:43:32 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Rich Baum <richbaum@acm.org>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] fix compile warnings in 2.4.15pre9
Date: Thu, 22 Nov 2001 17:45:23 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <132A4694022@coral.indstate.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch fixes some compile warnings in 2..4.15pre9.  The warnings 
are for using labels at the end of compound statements and for tokens at the 
end of #undef statements.  Please consider applying this patch.

Thanks, 
Rich

diff -urN -X dontdiff linux/drivers/atm/firestream.c 
linux-rb/drivers/atm/firestream.c
--- linux/drivers/atm/firestream.c	Thu Nov 22 17:20:52 2001
+++ linux-rb/drivers/atm/firestream.c	Thu Nov 22 17:21:22 2001
@@ -758,6 +758,7 @@
 			kfree (td);
 			break;
 		default:
+			break;
 			/* Here we get the tx purge inhibit command ... */
 			/* Action, I believe, is "don't do anything". -- REW */
 		}
diff -urN -X dontdiff linux/drivers/media/video/meye.c 
linux-rb/drivers/media/video/meye.c
--- linux/drivers/media/video/meye.c	Thu Oct 25 15:53:47 2001
+++ linux-rb/drivers/media/video/meye.c	Sun Nov 18 19:17:56 2001
@@ -903,6 +903,7 @@
 		mchip_free_frame();
 	}
 out:
+	return;
 }
 
 /****************************************************************************
/
diff -urN -X dontdiff linux/drivers/media/video/zr36067.c 
linux-rb/drivers/media/video/zr36067.c
--- linux/drivers/media/video/zr36067.c	Thu Nov 22 17:20:54 2001
+++ linux-rb/drivers/media/video/zr36067.c	Thu Nov 22 17:21:24 2001
@@ -1418,6 +1418,7 @@
 		post_office_write(zr, 3, 0, 0);
 		udelay(2);
 	default:
+		break;
 	}
 	return 0;
 }
diff -urN -X dontdiff linux/drivers/scsi/cpqfcTSworker.c 
linux-rb/drivers/scsi/cpqfcTSworker.c
--- linux/drivers/scsi/cpqfcTSworker.c	Thu Oct 25 15:53:50 2001
+++ linux-rb/drivers/scsi/cpqfcTSworker.c	Sun Nov 18 19:21:00 2001
@@ -2912,6 +2912,7 @@
   }
 
 Done:  
+  	return;
 }
 
 static void 
@@ -3029,7 +3030,7 @@
 
 
 Done:
-
+	return;
 }
 
 
diff -urN -X dontdiff linux/drivers/scsi/sym53c8xx_2/sym_hipd.c 
linux-rb/drivers/scsi/sym53c8xx_2/sym_hipd.c
--- linux/drivers/scsi/sym53c8xx_2/sym_hipd.c	Thu Nov 22 17:20:57 2001
+++ linux-rb/drivers/scsi/sym53c8xx_2/sym_hipd.c	Thu Nov 22 17:21:35 2001
@@ -4691,6 +4691,7 @@
 	OUTL_DSP (SCRIPTA_BA (np, clrack));
 	return;
 out_stuck:
+	return;
 }
 
 /*
@@ -5226,6 +5227,7 @@
 
 	return;
 fail:
+	return;
 }
 
 /*
diff -urN -X dontdiff linux/drivers/scsi/sym53c8xx_2/sym_nvram.c 
linux-rb/drivers/scsi/sym53c8xx_2/sym_nvram.c
--- linux/drivers/scsi/sym53c8xx_2/sym_nvram.c	Thu Nov 22 17:20:57 2001
+++ linux-rb/drivers/scsi/sym53c8xx_2/sym_nvram.c	Thu Nov 22 09:04:51 2001
@@ -505,10 +505,10 @@
 	return retv;
 }
 
-#undef SET_BIT 0
-#undef CLR_BIT 1
-#undef SET_CLK 2
-#undef CLR_CLK 3
+#undef SET_BIT /* 0 */
+#undef CLR_BIT /* 1 */
+#undef SET_CLK /* 2 */
+#undef CLR_CLK /* 3 */
 
 /*
  *  Try reading Symbios NVRAM.
diff -urN -X dontdiff linux/fs/ntfs/fs.c linux-rb/fs/ntfs/fs.c
--- linux/fs/ntfs/fs.c	Thu Oct 25 02:02:26 2001
+++ linux-rb/fs/ntfs/fs.c	Sun Nov 18 19:21:50 2001
@@ -852,7 +852,7 @@
 		}
 		break;
 	default:
-		/* Nothing. Just clear the inode and exit. */
+		break;	/* Nothing. Just clear the inode and exit. */
 	}
 	ntfs_clear_inode(&inode->u.ntfs_i);
 unl_out:
diff -urN -X dontdiff linux/net/802/cl2llc.c linux-rb/net/802/cl2llc.c
--- linux/net/802/cl2llc.c	Sun Nov 18 15:34:16 2001
+++ linux-rb/net/802/cl2llc.c	Sun Nov 18 19:22:38 2001
@@ -97,6 +97,7 @@
 					llc_interpret_pseudo_code(lp, REJECT1, skb, NO_FRAME);
 				break;
 			default:
+				break;
 		}
 		if(lp->llc_callbacks)
 		{
@@ -498,6 +499,7 @@
 					lp->f_flag = fr->i_hdr.i_pflag;
 				break;
 			default:
+				break;
 		}
 		pc++;	
 	}
