Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262431AbUKQQ7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbUKQQ7x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 11:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbUKQQ6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 11:58:12 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:29118 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262431AbUKQQ5R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 11:57:17 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16795.33515.187015.492860@thebsh.namesys.com>
Date: Wed, 17 Nov 2004 19:57:15 +0300
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
In-Reply-To: <E1CURx6-0005Qf-00@dorka.pomaz.szeredi.hu>
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu>
	<Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org>
	<E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu>
	<84144f0204111602136a9bbded@mail.gmail.com>
	<E1CU0Ri-0000f9-00@dorka.pomaz.szeredi.hu>
	<20041116120226.A27354@pauline.vellum.cz>
	<E1CU3tO-0000rV-00@dorka.pomaz.szeredi.hu>
	<20041116163314.GA6264@kroah.com>
	<E1CURx6-0005Qf-00@dorka.pomaz.szeredi.hu>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi writes:
 > > No.  Actually, put it in sysfs, and then udev will create your /dev node
 > > for you automatically.  And in sysfs you can put your other stuff
 > > (version, etc.) which is the proper place for it.
 > 
 > Next question: _where_ to put other stuff?  In /proc this has a
 > logical place for filesystems: /proc/fs/fsname/other_stuff.  But
 > there's no filesystem section in sysfs.

/sys/fs used to exist for for some. Moreover, /sys/fs/foofs/ was added
automagically when foofs file system type was registered. But it was
ultimately removed, because nobody took the time to fix all races
between accessing /sys/fs/foofs/gadget and
umount/filesystem-module-unloading. 

Another way is to implement special "control" file-system type (using
fs/libfs.c functions), to be used like

mount -tfoofs /device /mnt/point
mount -tfoo_ctrlfs -o host=/mnt/point /mnt/control-point

Again, nobody took the time to actually do this for any real
file-system, as far as I know.

 > 
 > So?

Go ahead bravely. :)

 > 
 > Thanks,
 > Miklos

Nikita.
