Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265366AbUBCQxH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 11:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266007AbUBCQxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 11:53:07 -0500
Received: from macvin.cri2000.ens-lyon.fr ([140.77.13.138]:5517 "EHLO macvin")
	by vger.kernel.org with ESMTP id S265366AbUBCQxE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 11:53:04 -0500
Date: Tue, 3 Feb 2004 17:53:00 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.fr>
To: linux-kernel@vger.kernel.org
Subject: alloc_dentry and alloc_filp
Message-ID: <20040203165300.GS5068@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Operating-System: Linux 2.6.0 i686
Organization: Ecole Normale Superieure de Lyon
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would like to know why the alloc_inode/destroy_inode functions
have been added to super block operations during 2.5 development
while there still are no alloc/destroy_dentry or alloc/destroy_filp
functions.
It seems that the alloc_inode enhanced several filesystems such
as NFS, JFS, XFS, etc. But it also seems to me that similar
alloc_dentry or alloc_filp fields may also be interesting.

I looked at the usage of the private_data field of the struct file
in 2.6.1 filesystems and I think several implementations may be
enhanced by allowing filesystems to control the allocation of
struct file.
For instance, Coda could move its "struct coda_file_info" into
the main struct file.
Other examples are the struct dir_private_info of ext3,
presto_file_data in intermezzo, nfs4_state in nfs4, etc.

The usage of d_fsdata field in struct dentry shows that Intermezzo
may also be enhanced by allowing it to control dentry allocation
so that its struct presto_dentry_data would be allocated within
the dentry.

I imagine a simple patch adding in get_empty_filp/d_alloc a check
for the existence of alloc_file/dentry in the super block operations
and then call it or revert to the generic allocation routines.
Corresponding dentry/filp_init_once might then be exported as
inode_init_once is.

Looking at the current dentry/file allocation model in 2.6, I
didn't find any problem with that. What do you think about it ?
Has anobody already tried this ?
Any chance for such a patch to be included ?

Best regards
-- 
Brice Goglin
================================================
Ph.D Student
Laboratoire de l'Informatique et du Parallélisme
CNRS-INRIA-ENS Lyon
France
