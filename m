Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317107AbSIAPNr>; Sun, 1 Sep 2002 11:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317112AbSIAPNr>; Sun, 1 Sep 2002 11:13:47 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:34802 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S317107AbSIAPNr>; Sun, 1 Sep 2002 11:13:47 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <E17lCXU-0002zH-00@storm.christs.cam.ac.uk> 
References: <E17lCXU-0002zH-00@storm.christs.cam.ac.uk> 
To: Anton Altaparmakov <aia21@cantab.net>
Cc: torvalds@transmeta.com (Linus Torvalds),
       viro@math.psu.edu (Alexander Viro),
       linux-kernel@vger.kernel.org (Linux Kernel)
Subject: Re: [BK-PATCH-2.5] Introduce new VFS inode cache lookup function 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 01 Sep 2002 16:17:41 +0100
Message-ID: <26631.1030893461@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


aia21@cantab.net said:
> The below ChangeSet against Linus' current BK tree adds a new function
> to the VFS, fs/inode.c::ilookup().

> This is needed in NTFS when writing out inode metadata pages via the
> VM dirty page code paths as we need to know whether there is an active
> inode in icache but we don't want to do an iget() because if the inode
> is not active then there is no need to write it... - I can just skip
> onto the next one instead... - If there is an active inode then I need
> to get the struct inode in order to perform appropriate locking for
> the write out to happen. 

Yum. I need similar functionality for JFFS2 garbage collection. When moving
a data node, we currently iget() the inode to which it belongs and update
its in-core extent lists accordingly. If the inode in question wasn't
already present, there's no real need to do that.

--
dwmw2


