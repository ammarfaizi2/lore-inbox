Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129944AbQKRAYA>; Fri, 17 Nov 2000 19:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130383AbQKRAXu>; Fri, 17 Nov 2000 19:23:50 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:3589 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129944AbQKRAXk>; Fri, 17 Nov 2000 19:23:40 -0500
Date: Fri, 17 Nov 2000 15:53:30 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Harald Koenig <koenig@tat.physik.uni-tuebingen.de>
cc: Andries.Brouwer@cwi.nl, aeb@veritas.com, emoenke@gwdg.de, eric@andante.org,
        kobras@tat.physik.uni-tuebingen.de, linux-kernel@vger.kernel.org
Subject: Re: BUG: isofs broken (2.2 and 2.4)
In-Reply-To: <20001117235515.A1522@turtle.tat.physik.uni-tuebingen.de>
Message-ID: <Pine.LNX.4.10.10011171552240.898-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Oh, and sorry - the last patch doesn't contain the (obvious) fixes to the
header files to take some of the calling convention changes into account.


		Linus

---
--- v2.4.0-test10/linux/include/linux/iso_fs.h	Fri Sep  8 12:52:56 2000
+++ linux/include/linux/iso_fs.h	Fri Nov 17 15:52:03 2000
@@ -177,16 +177,17 @@
 
 extern int parse_rock_ridge_inode(struct iso_directory_record *, struct inode *);
 extern int get_rock_ridge_filename(struct iso_directory_record *, char *, struct inode *);
+extern int isofs_name_translate(struct iso_directory_record *, char *, struct inode *);
 
 extern int find_rock_ridge_relocation(struct iso_directory_record *, struct inode *);
 
-int get_joliet_filename(struct iso_directory_record *, struct inode *, unsigned char *);
+int get_joliet_filename(struct iso_directory_record *, unsigned char *, struct inode *);
 int get_acorn_filename(struct iso_directory_record *, char *, struct inode *);
 
 extern struct dentry *isofs_lookup(struct inode *, struct dentry *);
 extern int isofs_get_block(struct inode *, long, struct buffer_head *, int);
 extern int isofs_bmap(struct inode *, int);
-extern int isofs_lookup_grandparent(struct inode *, int);
+extern struct buffer_head *isofs_bread(struct inode *, unsigned int, unsigned int);
 
 extern struct inode_operations isofs_dir_inode_operations;
 extern struct file_operations isofs_dir_operations;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
