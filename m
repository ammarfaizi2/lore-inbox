Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262493AbUKQSZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbUKQSZN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 13:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262486AbUKQSXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 13:23:32 -0500
Received: from [213.85.13.118] ([213.85.13.118]:13187 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S262480AbUKQSVC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 13:21:02 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16795.38517.516369.268494@gargle.gargle.HOWL>
Date: Wed, 17 Nov 2004 21:20:37 +0300
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
In-Reply-To: <E1CUU2P-0005g4-00@dorka.pomaz.szeredi.hu>
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu>
	<Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org>
	<E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu>
	<84144f0204111602136a9bbded@mail.gmail.com>
	<E1CU0Ri-0000f9-00@dorka.pomaz.szeredi.hu>
	<20041116120226.A27354@pauline.vellum.cz>
	<E1CU3tO-0000rV-00@dorka.pomaz.szeredi.hu>
	<20041116163314.GA6264@kroah.com>
	<E1CURx6-0005Qf-00@dorka.pomaz.szeredi.hu>
	<16795.33515.187015.492860@thebsh.namesys.com>
	<E1CUU2P-0005g4-00@dorka.pomaz.szeredi.hu>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi writes:
 > 
 > > /sys/fs used to exist for for some. Moreover, /sys/fs/foofs/ was added
 > > automagically when foofs file system type was registered. But it was
 > > ultimately removed, because nobody took the time to fix all races
 > > between accessing /sys/fs/foofs/gadget and
 > > umount/filesystem-module-unloading. 
 > 
 > I don't see why this would be any harder for filesystem code than for
 > other types of drivers.  Maybe someone can enlighten me.
 > 
 > Anyway, I can try to clean it up: remove all the racy bits and keep
 > what I need (which is mainly just the /sys/fs directory).  Where can I
 > find the most recent version of this?

It was removed at 2003.06.05, by "[fs] Remove kobject support for
filesystems" change-set (mochel@osdl.org), you can extract patch from
bitkeeper.

Reiser4 adds /sys/fs and /sys/fs/reiser4 manually (see kattr.[ch] in its
sources), and uses

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/broken-out/reiser4-kobject-umount-race.patch
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/broken-out/reiser4-kobject-umount-race-cleanup.patch

to avoid _some_ races (with umount), but these patches provide no
protection against races with module unloading.

 > 
 > Thanks,
 > Miklos

Nikita.
