Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261967AbVC1RoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbVC1RoS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 12:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbVC1RoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 12:44:18 -0500
Received: from fep18.inet.fi ([194.251.242.243]:53124 "EHLO fep18.inet.fi")
	by vger.kernel.org with ESMTP id S261967AbVC1Rl0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 12:41:26 -0500
Subject: [PATCH 1/9] isofs: indent rock.c
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <ie2p3w.8axj20.6dtzk29izx5dbxb43kc9fm7y4.refire@cs.helsinki.fi>
In-Reply-To: <ie2p3m.2u2ccu.3z4p19m1j53m9pob6l5ceeebq.refire@cs.helsinki.fi>
Date: Mon, 28 Mar 2005 20:41:25 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch indents the file fs/isofs/rock.c.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 rock.c |  647 +++++++++++++++++++++++++++++++++++------------------------------
 1 files changed, 356 insertions(+), 291 deletions(-)

Index: 2.6/fs/isofs/rock.c
===================================================================
--- 2.6.orig/fs/isofs/rock.c	2005-03-28 16:26:26.000000000 +0300
+++ 2.6/fs/isofs/rock.c	2005-03-28 16:27:05.000000000 +0300
@@ -26,8 +26,7 @@
  * returns a symbolic link name, and a fourth one returns the extent number
  * for the file. */
 
-#define SIG(A,B) ((A) | ((B) << 8)) /* isonum_721() */
-
+#define SIG(A,B) ((A) | ((B) << 8))	/* isonum_721() */
 
 /* This is a way of ensuring that we have something in the system
    use fields that is compatible with Rock Ridge */
@@ -60,7 +59,7 @@
      CHR+=ISOFS_SB(inode->i_sb)->s_rock_offset;                \
      if (LEN<0) LEN=0;                                          \
   }                                                             \
-}                                     
+}
 
 #define MAYBE_CONTINUE(LABEL,DEV) \
   {if (buffer) { kfree(buffer); buffer = NULL; } \
@@ -91,280 +90,348 @@
   }}
 
 /* return length of name field; 0: not found, -1: to be ignored */
-int get_rock_ridge_filename(struct iso_directory_record * de,
-			    char * retname, struct inode * inode)
+int get_rock_ridge_filename(struct iso_directory_record *de,
+			    char *retname, struct inode *inode)
 {
-  int len;
-  unsigned char * chr;
-  CONTINUE_DECLS;
-  int retnamlen = 0, truncate=0;
- 
-  if (!ISOFS_SB(inode->i_sb)->s_rock) return 0;
-  *retname = 0;
-
-  SETUP_ROCK_RIDGE(de, chr, len);
- repeat:
-  {
-    struct rock_ridge * rr;
-    int sig;
-    
-    while (len > 2){ /* There may be one byte for padding somewhere */
-      rr = (struct rock_ridge *) chr;
-      if (rr->len < 3) goto out; /* Something got screwed up here */
-      sig = isonum_721(chr);
-      chr += rr->len; 
-      len -= rr->len;
-      if (len < 0) goto out;	/* corrupted isofs */
-
-      switch(sig){
-      case SIG('R','R'):
-	if((rr->u.RR.flags[0] & RR_NM) == 0) goto out;
-	break;
-      case SIG('S','P'):
-	CHECK_SP(goto out);
-	break;
-      case SIG('C','E'):
-	CHECK_CE;
-	break;
-      case SIG('N','M'):
-	if (truncate) break;
-	if (rr->len < 5) break;
-        /*
-	 * If the flags are 2 or 4, this indicates '.' or '..'.
-	 * We don't want to do anything with this, because it
-	 * screws up the code that calls us.  We don't really
-	 * care anyways, since we can just use the non-RR
-	 * name.
-	 */
-	if (rr->u.NM.flags & 6) {
-	  break;
-	}
+	int len;
+	unsigned char *chr;
+	CONTINUE_DECLS;
+	int retnamlen = 0, truncate = 0;
 
-	if (rr->u.NM.flags & ~1) {
-	  printk("Unsupported NM flag settings (%d)\n",rr->u.NM.flags);
-	  break;
-	}
-	if((strlen(retname) + rr->len - 5) >= 254) {
-	  truncate = 1;
-	  break;
+	if (!ISOFS_SB(inode->i_sb)->s_rock)
+		return 0;
+	*retname = 0;
+
+	SETUP_ROCK_RIDGE(de, chr, len);
+      repeat:
+	{
+		struct rock_ridge *rr;
+		int sig;
+
+		while (len > 2) {	/* There may be one byte for padding somewhere */
+			rr = (struct rock_ridge *)chr;
+			if (rr->len < 3)
+				goto out;	/* Something got screwed up here */
+			sig = isonum_721(chr);
+			chr += rr->len;
+			len -= rr->len;
+			if (len < 0)
+				goto out;	/* corrupted isofs */
+
+			switch (sig) {
+			case SIG('R', 'R'):
+				if ((rr->u.RR.flags[0] & RR_NM) == 0)
+					goto out;
+				break;
+			case SIG('S', 'P'):
+				CHECK_SP(goto out);
+				break;
+			case SIG('C', 'E'):
+				CHECK_CE;
+				break;
+			case SIG('N', 'M'):
+				if (truncate)
+					break;
+				if (rr->len < 5)
+					break;
+				/*
+				 * If the flags are 2 or 4, this indicates '.' or '..'.
+				 * We don't want to do anything with this, because it
+				 * screws up the code that calls us.  We don't really
+				 * care anyways, since we can just use the non-RR
+				 * name.
+				 */
+				if (rr->u.NM.flags & 6) {
+					break;
+				}
+
+				if (rr->u.NM.flags & ~1) {
+					printk
+					    ("Unsupported NM flag settings (%d)\n",
+					     rr->u.NM.flags);
+					break;
+				}
+				if ((strlen(retname) + rr->len - 5) >= 254) {
+					truncate = 1;
+					break;
+				}
+				strncat(retname, rr->u.NM.name, rr->len - 5);
+				retnamlen += rr->len - 5;
+				break;
+			case SIG('R', 'E'):
+				if (buffer)
+					kfree(buffer);
+				return -1;
+			default:
+				break;
+			}
+		}
 	}
-	strncat(retname, rr->u.NM.name, rr->len - 5);
-	retnamlen += rr->len - 5;
-	break;
-      case SIG('R','E'):
-	if (buffer) kfree(buffer);
-	return -1;
-      default:
-	break;
-      }
-    }
-  }
-  MAYBE_CONTINUE(repeat,inode);
-  if (buffer) kfree(buffer);
-  return retnamlen; /* If 0, this file did not have a NM field */
- out:
-  if(buffer) kfree(buffer);
-  return 0;
+	MAYBE_CONTINUE(repeat, inode);
+	if (buffer)
+		kfree(buffer);
+	return retnamlen;	/* If 0, this file did not have a NM field */
+      out:
+	if (buffer)
+		kfree(buffer);
+	return 0;
 }
 
 static int
 parse_rock_ridge_inode_internal(struct iso_directory_record *de,
 				struct inode *inode, int regard_xa)
 {
-  int len;
-  unsigned char * chr;
-  int symlink_len = 0;
-  CONTINUE_DECLS;
-
-  if (!ISOFS_SB(inode->i_sb)->s_rock) return 0;
-
-  SETUP_ROCK_RIDGE(de, chr, len);
-  if (regard_xa)
-   {
-     chr+=14;
-     len-=14;
-     if (len<0) len=0;
-   }
-   
- repeat:
-  {
-    int cnt, sig;
-    struct inode * reloc;
-    struct rock_ridge * rr;
-    int rootflag;
-    
-    while (len > 2){ /* There may be one byte for padding somewhere */
-      rr = (struct rock_ridge *) chr;
-      if (rr->len < 3) goto out; /* Something got screwed up here */
-      sig = isonum_721(chr);
-      chr += rr->len; 
-      len -= rr->len;
-      if (len < 0) goto out;	/* corrupted isofs */
-      
-      switch(sig){
+	int len;
+	unsigned char *chr;
+	int symlink_len = 0;
+	CONTINUE_DECLS;
+
+	if (!ISOFS_SB(inode->i_sb)->s_rock)
+		return 0;
+
+	SETUP_ROCK_RIDGE(de, chr, len);
+	if (regard_xa) {
+		chr += 14;
+		len -= 14;
+		if (len < 0)
+			len = 0;
+	}
+
+      repeat:
+	{
+		int cnt, sig;
+		struct inode *reloc;
+		struct rock_ridge *rr;
+		int rootflag;
+
+		while (len > 2) {	/* There may be one byte for padding somewhere */
+			rr = (struct rock_ridge *)chr;
+			if (rr->len < 3)
+				goto out;	/* Something got screwed up here */
+			sig = isonum_721(chr);
+			chr += rr->len;
+			len -= rr->len;
+			if (len < 0)
+				goto out;	/* corrupted isofs */
+
+			switch (sig) {
 #ifndef CONFIG_ZISOFS		/* No flag for SF or ZF */
-      case SIG('R','R'):
-	if((rr->u.RR.flags[0] & 
- 	    (RR_PX | RR_TF | RR_SL | RR_CL)) == 0) goto out;
-	break;
+			case SIG('R', 'R'):
+				if ((rr->u.RR.flags[0] &
+				     (RR_PX | RR_TF | RR_SL | RR_CL)) == 0)
+					goto out;
+				break;
 #endif
-      case SIG('S','P'):
-	CHECK_SP(goto out);
-	break;
-      case SIG('C','E'):
-	CHECK_CE;
-	break;
-      case SIG('E','R'):
-	ISOFS_SB(inode->i_sb)->s_rock = 1;
-	printk(KERN_DEBUG "ISO 9660 Extensions: ");
-	{ int p;
-	  for(p=0;p<rr->u.ER.len_id;p++) printk("%c",rr->u.ER.data[p]);
-	}
-	  printk("\n");
-	break;
-      case SIG('P','X'):
-	inode->i_mode  = isonum_733(rr->u.PX.mode);
-	inode->i_nlink = isonum_733(rr->u.PX.n_links);
-	inode->i_uid   = isonum_733(rr->u.PX.uid);
-	inode->i_gid   = isonum_733(rr->u.PX.gid);
-	break;
-      case SIG('P','N'):
-	{ int high, low;
-	  high = isonum_733(rr->u.PN.dev_high);
-	  low = isonum_733(rr->u.PN.dev_low);
-	  /*
-	   * The Rock Ridge standard specifies that if sizeof(dev_t) <= 4,
-	   * then the high field is unused, and the device number is completely
-	   * stored in the low field.  Some writers may ignore this subtlety,
-	   * and as a result we test to see if the entire device number is
-	   * stored in the low field, and use that.
-	   */
-	  if((low & ~0xff) && high == 0) {
-	    inode->i_rdev = MKDEV(low >> 8, low & 0xff);
-	  } else {
-	    inode->i_rdev = MKDEV(high, low);
-	  }
-	}
-	break;
-      case SIG('T','F'):
-	/* Some RRIP writers incorrectly place ctime in the TF_CREATE field.
-	   Try to handle this correctly for either case. */
-	cnt = 0; /* Rock ridge never appears on a High Sierra disk */
-	if(rr->u.TF.flags & TF_CREATE) { 
-	  inode->i_ctime.tv_sec = iso_date(rr->u.TF.times[cnt++].time, 0);
-	  inode->i_ctime.tv_nsec = 0;
-	}
-	if(rr->u.TF.flags & TF_MODIFY) {
-	  inode->i_mtime.tv_sec = iso_date(rr->u.TF.times[cnt++].time, 0);
-	  inode->i_mtime.tv_nsec = 0;
-	}
-	if(rr->u.TF.flags & TF_ACCESS) {
-	  inode->i_atime.tv_sec = iso_date(rr->u.TF.times[cnt++].time, 0);
-	  inode->i_atime.tv_nsec = 0;
-	}
-	if(rr->u.TF.flags & TF_ATTRIBUTES) { 
-	  inode->i_ctime.tv_sec = iso_date(rr->u.TF.times[cnt++].time, 0);
-	  inode->i_ctime.tv_nsec = 0;
-	} 
-	break;
-      case SIG('S','L'):
-	{int slen;
-	 struct SL_component * slp;
-	 struct SL_component * oldslp;
-	 slen = rr->len - 5;
-	 slp = &rr->u.SL.link;
-	 inode->i_size = symlink_len;
-	 while (slen > 1){
-	   rootflag = 0;
-	   switch(slp->flags &~1){
-	   case 0:
-	     inode->i_size += slp->len;
-	     break;
-	   case 2:
-	     inode->i_size += 1;
-	     break;
-	   case 4:
-	     inode->i_size += 2;
-	     break;
-	   case 8:
-	     rootflag = 1;
-	     inode->i_size += 1;
-	     break;
-	   default:
-	     printk("Symlink component flag not implemented\n");
-	   }
-	   slen -= slp->len + 2;
-	   oldslp = slp;
-	   slp = (struct SL_component *) (((char *) slp) + slp->len + 2);
-
-	   if(slen < 2) {
-	     if(    ((rr->u.SL.flags & 1) != 0) 
-		    && ((oldslp->flags & 1) == 0) ) inode->i_size += 1;
-	     break;
-	   }
-
-	   /*
-	    * If this component record isn't continued, then append a '/'.
-	    */
-	   if (!rootflag && (oldslp->flags & 1) == 0)
-		   inode->i_size += 1;
-	 }
-	}
-	symlink_len = inode->i_size;
-	break;
-      case SIG('R','E'):
-	printk(KERN_WARNING "Attempt to read inode for relocated directory\n");
-	goto out;
-      case SIG('C','L'):
-	ISOFS_I(inode)->i_first_extent = isonum_733(rr->u.CL.location);
-	reloc = isofs_iget(inode->i_sb, ISOFS_I(inode)->i_first_extent, 0);
-	if (!reloc)
-		goto out;
-	inode->i_mode = reloc->i_mode;
-	inode->i_nlink = reloc->i_nlink;
-	inode->i_uid = reloc->i_uid;
-	inode->i_gid = reloc->i_gid;
-	inode->i_rdev = reloc->i_rdev;
-	inode->i_size = reloc->i_size;
-	inode->i_blocks = reloc->i_blocks;
-	inode->i_atime = reloc->i_atime;
-	inode->i_ctime = reloc->i_ctime;
-	inode->i_mtime = reloc->i_mtime;
-	iput(reloc);
-	break;
+			case SIG('S', 'P'):
+				CHECK_SP(goto out);
+				break;
+			case SIG('C', 'E'):
+				CHECK_CE;
+				break;
+			case SIG('E', 'R'):
+				ISOFS_SB(inode->i_sb)->s_rock = 1;
+				printk(KERN_DEBUG "ISO 9660 Extensions: ");
+				{
+					int p;
+					for (p = 0; p < rr->u.ER.len_id; p++)
+						printk("%c", rr->u.ER.data[p]);
+				}
+				printk("\n");
+				break;
+			case SIG('P', 'X'):
+				inode->i_mode = isonum_733(rr->u.PX.mode);
+				inode->i_nlink = isonum_733(rr->u.PX.n_links);
+				inode->i_uid = isonum_733(rr->u.PX.uid);
+				inode->i_gid = isonum_733(rr->u.PX.gid);
+				break;
+			case SIG('P', 'N'):
+				{
+					int high, low;
+					high = isonum_733(rr->u.PN.dev_high);
+					low = isonum_733(rr->u.PN.dev_low);
+					/*
+					 * The Rock Ridge standard specifies that if sizeof(dev_t) <= 4,
+					 * then the high field is unused, and the device number is completely
+					 * stored in the low field.  Some writers may ignore this subtlety,
+					 * and as a result we test to see if the entire device number is
+					 * stored in the low field, and use that.
+					 */
+					if ((low & ~0xff) && high == 0) {
+						inode->i_rdev =
+						    MKDEV(low >> 8, low & 0xff);
+					} else {
+						inode->i_rdev =
+						    MKDEV(high, low);
+					}
+				}
+				break;
+			case SIG('T', 'F'):
+				/* Some RRIP writers incorrectly place ctime in the TF_CREATE field.
+				   Try to handle this correctly for either case. */
+				cnt = 0;	/* Rock ridge never appears on a High Sierra disk */
+				if (rr->u.TF.flags & TF_CREATE) {
+					inode->i_ctime.tv_sec =
+					    iso_date(rr->u.TF.times[cnt++].time,
+						     0);
+					inode->i_ctime.tv_nsec = 0;
+				}
+				if (rr->u.TF.flags & TF_MODIFY) {
+					inode->i_mtime.tv_sec =
+					    iso_date(rr->u.TF.times[cnt++].time,
+						     0);
+					inode->i_mtime.tv_nsec = 0;
+				}
+				if (rr->u.TF.flags & TF_ACCESS) {
+					inode->i_atime.tv_sec =
+					    iso_date(rr->u.TF.times[cnt++].time,
+						     0);
+					inode->i_atime.tv_nsec = 0;
+				}
+				if (rr->u.TF.flags & TF_ATTRIBUTES) {
+					inode->i_ctime.tv_sec =
+					    iso_date(rr->u.TF.times[cnt++].time,
+						     0);
+					inode->i_ctime.tv_nsec = 0;
+				}
+				break;
+			case SIG('S', 'L'):
+				{
+					int slen;
+					struct SL_component *slp;
+					struct SL_component *oldslp;
+					slen = rr->len - 5;
+					slp = &rr->u.SL.link;
+					inode->i_size = symlink_len;
+					while (slen > 1) {
+						rootflag = 0;
+						switch (slp->flags & ~1) {
+						case 0:
+							inode->i_size +=
+							    slp->len;
+							break;
+						case 2:
+							inode->i_size += 1;
+							break;
+						case 4:
+							inode->i_size += 2;
+							break;
+						case 8:
+							rootflag = 1;
+							inode->i_size += 1;
+							break;
+						default:
+							printk
+							    ("Symlink component flag not implemented\n");
+						}
+						slen -= slp->len + 2;
+						oldslp = slp;
+						slp =
+						    (struct SL_component
+						     *)(((char *)slp) +
+							slp->len + 2);
+
+						if (slen < 2) {
+							if (((rr->u.SL.
+							      flags & 1) != 0)
+							    &&
+							    ((oldslp->
+							      flags & 1) == 0))
+								inode->i_size +=
+								    1;
+							break;
+						}
+
+						/*
+						 * If this component record isn't continued, then append a '/'.
+						 */
+						if (!rootflag
+						    && (oldslp->flags & 1) == 0)
+							inode->i_size += 1;
+					}
+				}
+				symlink_len = inode->i_size;
+				break;
+			case SIG('R', 'E'):
+				printk(KERN_WARNING
+				       "Attempt to read inode for relocated directory\n");
+				goto out;
+			case SIG('C', 'L'):
+				ISOFS_I(inode)->i_first_extent =
+				    isonum_733(rr->u.CL.location);
+				reloc =
+				    isofs_iget(inode->i_sb,
+					       ISOFS_I(inode)->i_first_extent,
+					       0);
+				if (!reloc)
+					goto out;
+				inode->i_mode = reloc->i_mode;
+				inode->i_nlink = reloc->i_nlink;
+				inode->i_uid = reloc->i_uid;
+				inode->i_gid = reloc->i_gid;
+				inode->i_rdev = reloc->i_rdev;
+				inode->i_size = reloc->i_size;
+				inode->i_blocks = reloc->i_blocks;
+				inode->i_atime = reloc->i_atime;
+				inode->i_ctime = reloc->i_ctime;
+				inode->i_mtime = reloc->i_mtime;
+				iput(reloc);
+				break;
 #ifdef CONFIG_ZISOFS
-      case SIG('Z','F'):
-	      if ( !ISOFS_SB(inode->i_sb)->s_nocompress ) {
-		      int algo;
-		      algo = isonum_721(rr->u.ZF.algorithm);
-		      if ( algo == SIG('p','z') ) {
-			      int block_shift = isonum_711(&rr->u.ZF.parms[1]);
-			      if ( block_shift < PAGE_CACHE_SHIFT || block_shift > 17 ) {
-				      printk(KERN_WARNING "isofs: Can't handle ZF block size of 2^%d\n", block_shift);
-			      } else {
-				/* Note: we don't change i_blocks here */
-				      ISOFS_I(inode)->i_file_format = isofs_file_compressed;
-				/* Parameters to compression algorithm (header size, block size) */
-				      ISOFS_I(inode)->i_format_parm[0] = isonum_711(&rr->u.ZF.parms[0]);
-				      ISOFS_I(inode)->i_format_parm[1] = isonum_711(&rr->u.ZF.parms[1]);
-				      inode->i_size = isonum_733(rr->u.ZF.real_size);
-			      }
-		      } else {
-			      printk(KERN_WARNING "isofs: Unknown ZF compression algorithm: %c%c\n",
-				     rr->u.ZF.algorithm[0], rr->u.ZF.algorithm[1]);
-		      }
-	      }
-	      break;
+			case SIG('Z', 'F'):
+				if (!ISOFS_SB(inode->i_sb)->s_nocompress) {
+					int algo;
+					algo = isonum_721(rr->u.ZF.algorithm);
+					if (algo == SIG('p', 'z')) {
+						int block_shift =
+						    isonum_711(&rr->u.ZF.
+							       parms[1]);
+						if (block_shift <
+						    PAGE_CACHE_SHIFT
+						    || block_shift > 17) {
+							printk(KERN_WARNING
+							       "isofs: Can't handle ZF block size of 2^%d\n",
+							       block_shift);
+						} else {
+							/* Note: we don't change i_blocks here */
+							ISOFS_I(inode)->
+							    i_file_format =
+							    isofs_file_compressed;
+							/* Parameters to compression algorithm (header size, block size) */
+							ISOFS_I(inode)->
+							    i_format_parm[0] =
+							    isonum_711(&rr->u.
+								       ZF.
+								       parms
+								       [0]);
+							ISOFS_I(inode)->
+							    i_format_parm[1] =
+							    isonum_711(&rr->u.
+								       ZF.
+								       parms
+								       [1]);
+							inode->i_size =
+							    isonum_733(rr->u.ZF.
+								       real_size);
+						}
+					} else {
+						printk(KERN_WARNING
+						       "isofs: Unknown ZF compression algorithm: %c%c\n",
+						       rr->u.ZF.algorithm[0],
+						       rr->u.ZF.algorithm[1]);
+					}
+				}
+				break;
 #endif
-      default:
-	break;
-      }
-    }
-  }
-  MAYBE_CONTINUE(repeat,inode);
- out:
-  if(buffer) kfree(buffer);
-  return 0;
+			default:
+				break;
+			}
+		}
+	}
+	MAYBE_CONTINUE(repeat, inode);
+      out:
+	if (buffer)
+		kfree(buffer);
+	return 0;
 }
 
 static char *get_symlink_chunk(char *rpnt, struct rock_ridge *rr, char *plimit)
@@ -382,32 +449,32 @@
 			if (slp->len > plimit - rpnt)
 				return NULL;
 			memcpy(rpnt, slp->text, slp->len);
-			rpnt+=slp->len;
+			rpnt += slp->len;
 			break;
 		case 2:
 			if (rpnt >= plimit)
 				return NULL;
-			*rpnt++='.';
+			*rpnt++ = '.';
 			break;
 		case 4:
 			if (2 > plimit - rpnt)
 				return NULL;
-			*rpnt++='.';
-			*rpnt++='.';
+			*rpnt++ = '.';
+			*rpnt++ = '.';
 			break;
 		case 8:
 			if (rpnt >= plimit)
 				return NULL;
 			rootflag = 1;
-			*rpnt++='/';
+			*rpnt++ = '/';
 			break;
 		default:
 			printk("Symlink component flag not implemented (%d)\n",
-			     slp->flags);
+			       slp->flags);
 		}
 		slen -= slp->len + 2;
 		oldslp = slp;
-		slp = (struct SL_component *) ((char *) slp + slp->len + 2);
+		slp = (struct SL_component *)((char *)slp + slp->len + 2);
 
 		if (slen < 2) {
 			/*
@@ -418,7 +485,7 @@
 			    !(oldslp->flags & 1)) {
 				if (rpnt >= plimit)
 					return NULL;
-				*rpnt++='/';
+				*rpnt++ = '/';
 			}
 			break;
 		}
@@ -429,24 +496,22 @@
 		if (!rootflag && !(oldslp->flags & 1)) {
 			if (rpnt >= plimit)
 				return NULL;
-			*rpnt++='/';
+			*rpnt++ = '/';
 		}
 	}
 	return rpnt;
 }
 
-int parse_rock_ridge_inode(struct iso_directory_record * de,
-			   struct inode * inode)
+int parse_rock_ridge_inode(struct iso_directory_record *de, struct inode *inode)
 {
-   int result=parse_rock_ridge_inode_internal(de,inode,0);
-   /* if rockridge flag was reset and we didn't look for attributes
-    * behind eventual XA attributes, have a look there */
-   if ((ISOFS_SB(inode->i_sb)->s_rock_offset==-1)
-       &&(ISOFS_SB(inode->i_sb)->s_rock==2))
-     {
-	result=parse_rock_ridge_inode_internal(de,inode,14);
-     }
-   return result;
+	int result = parse_rock_ridge_inode_internal(de, inode, 0);
+	/* if rockridge flag was reset and we didn't look for attributes
+	 * behind eventual XA attributes, have a look there */
+	if ((ISOFS_SB(inode->i_sb)->s_rock_offset == -1)
+	    && (ISOFS_SB(inode->i_sb)->s_rock == 2)) {
+		result = parse_rock_ridge_inode_internal(de, inode, 14);
+	}
+	return result;
 }
 
 /* readpage() for symlinks: reads symlink contents into the page and either
@@ -455,7 +520,7 @@
 static int rock_ridge_symlink_readpage(struct file *file, struct page *page)
 {
 	struct inode *inode = page->mapping->host;
-        struct iso_inode_info *ei = ISOFS_I(inode);
+	struct iso_inode_info *ei = ISOFS_I(inode);
 	char *link = kmap(page);
 	unsigned long bufsize = ISOFS_BUFFER_SIZE(inode);
 	struct buffer_head *bh;
@@ -478,10 +543,10 @@
 	if (!bh)
 		goto out_noread;
 
-        offset = ei->i_iget5_offset;
-	pnt = (unsigned char *) bh->b_data + offset;
+	offset = ei->i_iget5_offset;
+	pnt = (unsigned char *)bh->b_data + offset;
 
-	raw_inode = (struct iso_directory_record *) pnt;
+	raw_inode = (struct iso_directory_record *)pnt;
 
 	/*
 	 * If we go past the end of the buffer, there is some sort of error.
@@ -495,8 +560,8 @@
 	SETUP_ROCK_RIDGE(raw_inode, chr, len);
 
       repeat:
-	while (len > 2) { /* There may be one byte for padding somewhere */
-		rr = (struct rock_ridge *) chr;
+	while (len > 2) {	/* There may be one byte for padding somewhere */
+		rr = (struct rock_ridge *)chr;
 		if (rr->len < 3)
 			goto out;	/* Something got screwed up here */
 		sig = isonum_721(chr);
@@ -561,5 +626,5 @@
 }
 
 struct address_space_operations isofs_symlink_aops = {
-	.readpage	= rock_ridge_symlink_readpage
+	.readpage = rock_ridge_symlink_readpage
 };
