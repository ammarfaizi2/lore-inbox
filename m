Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131658AbRCOIfn>; Thu, 15 Mar 2001 03:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131660AbRCOIfd>; Thu, 15 Mar 2001 03:35:33 -0500
Received: from orbita.don.sitek.net ([213.24.25.98]:22788 "EHLO
	orbita.don.sitek.net") by vger.kernel.org with ESMTP
	id <S131658AbRCOIfR>; Thu, 15 Mar 2001 03:35:17 -0500
Date: Thu, 15 Mar 2001 11:32:59 +0300
From: Andrey Panin <pazke@orbita.don.sitek.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] add missing KERN_xxx to /linux/fs
Message-ID: <20010315113259.A2084@debian>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8P1HSweYDcXXzwPJ
Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi all,

IMHO subject is self explaining :)

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-fs-printk
Content-Transfer-Encoding: quoted-printable

diff -ur linux.vanilla/fs/buffer.c linux/fs/buffer.c
--- linux.vanilla/fs/buffer.c	Thu Mar 15 22:06:19 2001
+++ linux/fs/buffer.c	Thu Mar 15 20:52:49 2001
@@ -1122,7 +1122,7 @@
 		atomic_dec(&buf->b_count);
 		return;
 	}
-	printk("VFS: brelse: Trying to free free buffer\n");
+	printk(KERN_ERR "VFS: brelse: Trying to free free buffer\n");
 }
=20
 /*
@@ -2269,7 +2269,7 @@
 	int isize;
=20
 	if ((size & 511) || (size > PAGE_SIZE)) {
-		printk("VFS: grow_buffers: size =3D %d\n",size);
+		printk(KERN_ERR "VFS: grow_buffers: size =3D %d\n",size);
 		return 0;
 	}
=20
@@ -2444,7 +2444,7 @@
 	static char *buf_types[NR_LIST] =3D { "CLEAN", "LOCKED", "DIRTY", "PROTEC=
TED", };
 #endif
=20
-	printk("Buffer memory:   %6dkB\n",
+	printk(KERN_DEBUG "Buffer memory:   %6dkB\n",
 			atomic_read(&buffermem_pages) << (PAGE_SHIFT-10));
=20
 #ifdef CONFIG_SMP /* trylock does nothing on UP and so we could deadlock */
@@ -2470,10 +2470,10 @@
 		{
 			int tmp =3D nr_buffers_type[nlist];
 			if (found !=3D tmp)
-				printk("%9s: BUG -> found %d, reported %d\n",
+				printk(KERN_DEBUG "%9s: BUG -> found %d, reported %d\n",
 				       buf_types[nlist], found, tmp);
 		}
-		printk("%9s: %d buffers, %lu kbyte, %d used (last=3D%d), "
+		printk(KERN_DEBUG "%9s: %d buffers, %lu kbyte, %d used (last=3D%d), "
 		       "%d locked, %d protected, %d dirty\n",
 		       buf_types[nlist], found, size_buffers_type[nlist]>>10,
 		       used, lastused, locked, protected, dirty);
@@ -2521,7 +2521,7 @@
 		hash_table =3D (struct buffer_head **)
 		    __get_free_pages(GFP_ATOMIC, order);
 	} while (hash_table =3D=3D NULL && --order > 0);
-	printk("Buffer-cache hash table entries: %d (order: %d, %ld bytes)\n",
+	printk(KERN_INFO "Buffer-cache hash table entries: %d (order: %d, %ld byt=
es)\n",
 	       nr_hash, order, (PAGE_SIZE << order));
=20
 	if (!hash_table)
@@ -2801,7 +2801,7 @@
 				goto stop_kupdate;
 		}
 #ifdef DEBUG
-		printk("kupdate() activated...\n");
+		printk(KERN_DEBUG "kupdate() activated...\n");
 #endif
 		sync_old_buffers();
 	}
diff -ur linux.vanilla/fs/dquot.c linux/fs/dquot.c
--- linux.vanilla/fs/dquot.c	Thu Mar 15 22:06:19 2001
+++ linux/fs/dquot.c	Thu Mar 15 21:30:40 2001
@@ -186,7 +186,7 @@
 {
 #ifdef __DQUOT_PARANOIA
 	if (list_empty(&dquot->dq_free)) {
-		printk("remove_free_dquot: dquot not on the free list??\n");
+		printk(KERN_ERR "remove_free_dquot: dquot not on the free list??\n");
 		return;		/* J.K. Just don't do anything */
 	}
 #endif
@@ -1006,8 +1006,8 @@
 	if (!dquot)
 		return;
 	if (!dquot->dq_count) {
-		printk("VFS: dqput: trying to free free dquot\n");
-		printk("VFS: device %s, dquot of %s %d\n",
+		printk(KERN_ERR "VFS: dqput: trying to free free dquot\n");
+		printk(KERN_ERR "VFS: device %s, dquot of %s %d\n",
 			kdevname(dquot->dq_dev), quotatypes[dquot->dq_type],
 			dquot->dq_id);
 		return;
diff -ur linux.vanilla/fs/exec.c linux/fs/exec.c
--- linux.vanilla/fs/exec.c	Thu Mar 15 22:06:20 2001
+++ linux/fs/exec.c	Thu Mar 15 21:11:18 2001
@@ -260,7 +260,7 @@
 	pte_t * pte;
=20
 	if (page_count(page) !=3D 1)
-		printk("mem_map disagrees with %p at %08lx\n", page, address);
+		printk(KERN_WARNING "mem_map disagrees with %p at %08lx\n", page, addres=
s);
 	pgd =3D pgd_offset(tsk->mm, address);
 	pmd =3D pmd_alloc(pgd, address);
 	if (!pmd) {
diff -ur linux.vanilla/fs/file_table.c linux/fs/file_table.c
--- linux.vanilla/fs/file_table.c	Tue Dec  5 21:27:31 2000
+++ linux/fs/file_table.c	Thu Mar 15 21:05:43 2001
@@ -66,10 +66,11 @@
 			goto new_one;
 		}
 		/* Big problems... */
-		printk("VFS: filp allocation failed\n");
+		printk(KERN_ERR "VFS: filp allocation failed\n");
=20
 	} else if (files_stat.max_files > old_max) {
-		printk("VFS: file-max limit %d reached\n", files_stat.max_files);
+		printk(KERN_ERR "VFS: file-max limit %d reached\n",=20
+		       files_stat.max_files);
 		old_max =3D files_stat.max_files;
 	}
 	file_list_unlock();
diff -ur linux.vanilla/fs/inode.c linux/fs/inode.c
--- linux.vanilla/fs/inode.c	Thu Mar 15 22:06:20 2001
+++ linux/fs/inode.c	Thu Mar 15 21:34:37 2001
@@ -304,7 +304,7 @@
 		spin_unlock(&inode_lock);
 	}
 	else
-		printk("write_inode_now: no super block\n");
+		printk(KERN_ERR "write_inode_now: no super block\n");
 }
=20
 /**
@@ -972,7 +972,7 @@
 			__get_free_pages(GFP_ATOMIC, order);
 	} while (inode_hashtable =3D=3D NULL && --order >=3D 0);
=20
-	printk("Inode-cache hash table entries: %d (order: %ld, %ld bytes)\n",
+	printk(KERN_INFO "Inode-cache hash table entries: %d (order: %ld, %ld byt=
es)\n",
 			nr_hash, order, (PAGE_SIZE << order));
=20
 	if (!inode_hashtable)
diff -ur linux.vanilla/fs/locks.c linux/fs/locks.c
--- linux.vanilla/fs/locks.c	Thu Mar 15 22:06:20 2001
+++ linux/fs/locks.c	Thu Mar 15 21:28:05 2001
@@ -531,7 +531,7 @@
 		return (1);
=20
 	default:
-		printk("locks_conflict(): impossible lock type - %d\n",
+		printk(KERN_ERR "locks_conflict(): impossible lock type - %d\n",
 		       caller_fl->fl_type);
 		break;
 	}
diff -ur linux.vanilla/fs/msdos/namei.c linux/fs/msdos/namei.c
--- linux.vanilla/fs/msdos/namei.c	Wed Sep  6 01:07:29 2000
+++ linux/fs/msdos/namei.c	Thu Mar 15 20:47:18 2001
@@ -389,7 +389,7 @@
 	return res;
=20
 mkdir_error:
-	printk("msdos_mkdir: error=3D%d, attempting cleanup\n", res);
+	printk(KERN_ERR "msdos_mkdir: error=3D%d, attempting cleanup\n", res);
 	inode->i_nlink =3D 0;
 	inode->i_ctime =3D dir->i_ctime =3D dir->i_mtime =3D CURRENT_TIME;
 	dir->i_nlink--;
diff -ur linux.vanilla/fs/open.c linux/fs/open.c
--- linux.vanilla/fs/open.c	Thu Mar 15 22:06:22 2001
+++ linux/fs/open.c	Thu Mar 15 21:08:47 2001
@@ -520,7 +520,7 @@
=20
 	error =3D -ENOENT;
 	if (!(inode =3D dentry->d_inode)) {
-		printk("chown_common: NULL inode\n");
+		printk(KERN_ERR "chown_common: NULL inode\n");
 		goto out;
 	}
 	error =3D -EROFS;
@@ -744,7 +744,7 @@
 #if 1
 	/* Sanity check */
 	if (files->fd[fd] !=3D NULL) {
-		printk("get_unused_fd: slot %d not NULL!\n", fd);
+		printk(KERN_ERR "get_unused_fd: slot %d not NULL!\n", fd);
 		files->fd[fd] =3D NULL;
 	}
 #endif
@@ -807,7 +807,7 @@
 	int retval;
=20
 	if (!file_count(filp)) {
-		printk("VFS: Close: file count is 0\n");
+		printk(KERN_WARNING "VFS: Close: file count is 0\n");
 		return 0;
 	}
 	retval =3D 0;
diff -ur linux.vanilla/fs/stat.c linux/fs/stat.c
--- linux.vanilla/fs/stat.c	Thu Mar 15 22:06:23 2001
+++ linux/fs/stat.c	Thu Mar 15 20:44:53 2001
@@ -39,7 +39,7 @@
=20
 	if (warncount > 0) {
 		warncount--;
-		printk("VFS: Warning: %s using old stat() call. Recompile your binary.\n=
",
+		printk(KERN_WARNING "VFS: Warning: %s using old stat() call. Recompile y=
our binary.\n",
 			current->comm);
 	} else if (warncount < 0) {
 		/* it's laughable, but... */
diff -ur linux.vanilla/fs/super.c linux/fs/super.c
--- linux.vanilla/fs/super.c	Thu Mar 15 22:06:23 2001
+++ linux/fs/super.c	Thu Mar 15 21:17:47 2001
@@ -706,7 +706,7 @@
 			continue;
 		if (!s->s_lock)
 			return s;
-		printk("VFS: empty superblock %p locked!\n", s);
+		printk(KERN_WARNING "VFS: empty superblock %p locked!\n", s);
 	}
 	/* Need a new one... */
 	if (nr_super_blocks >=3D max_super_blocks)
@@ -784,7 +784,7 @@
 		return;
 	if (test_and_clear_bit(MINOR(dev), unnamed_dev_in_use))
 		return;
-	printk("VFS: put_unnamed_dev: freeing unused device %s\n",
+	printk(KERN_WARNING "VFS: put_unnamed_dev: freeing unused device %s\n",
 			kdevname(dev));
 }
=20
@@ -915,7 +915,7 @@
=20
 	/* Forget any remaining inodes */
 	if (invalidate_inodes(sb)) {
-		printk("VFS: Busy inodes after unmount. "
+		printk(KERN_WARNING "VFS: Busy inodes after unmount. "
 			"Self-destruct in 5 seconds.  Have a nice day...\n");
 	}
=20
@@ -1568,9 +1568,9 @@
 		 * Allow the user to distinguish between failed open
 		 * and bad superblock on root device.
 		 */
-		printk ("VFS: Cannot open root device \"%s\" or %s\n",
+		printk (KERN_ERR "VFS: Cannot open root device \"%s\" or %s\n",
 			root_device_name, kdevname (ROOT_DEV));
-		printk ("Please append a correct \"root=3D\" boot option\n");
+		printk (KERN_ERR "Please append a correct \"root=3D\" boot option\n");
 		panic("VFS: Unable to mount root fs on %s",
 			kdevname(ROOT_DEV));
 	}
@@ -1599,7 +1599,7 @@
 	panic("VFS: Unable to mount root fs on %s", kdevname(ROOT_DEV));
=20
 mount_it:
-	printk ("VFS: Mounted root (%s filesystem)%s.\n",
+	printk (KERN_INFO "VFS: Mounted root (%s filesystem)%s.\n",
 		fs_type->name,
 		(sb->s_flags & MS_RDONLY) ? " readonly" : "");
 	if (path_start >=3D 0) {
@@ -1779,7 +1779,7 @@
 	mount_root();
 #if 1
 	shrink_dcache();
-	printk("change_root: old root has d_count=3D%d\n",=20
+	printk(KERN_DEBUG "change_root: old root has d_count=3D%d\n",=20
 	       atomic_read(&old_rootmnt->mnt_root->d_count));
 #endif
 	mount_devfs_fs ();

--GvXjxJ+pjyke8COw--

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6sH47Bm4rlNOo3YgRAqmeAJ9mxcpterKIGU3iojDpUcANPPnHdgCgiReF
1T+qZ02J5+txvhBqJ/gGYrU=
=HhJr
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
