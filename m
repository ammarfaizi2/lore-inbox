Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261446AbSJMHSn>; Sun, 13 Oct 2002 03:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261447AbSJMHSn>; Sun, 13 Oct 2002 03:18:43 -0400
Received: from ns.suse.de ([213.95.15.193]:49929 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261446AbSJMHSn>;
	Sun, 13 Oct 2002 03:18:43 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: wagnerjd@prodigy.net, robm@fastmail.fm, hahn@physics.mcmaster.ca,
       linux-kernel@vger.kernel.org, jhoward@fastmail.fm
Subject: Re: Strange load spikes on 2.4.19 kernel
References: <113001c27282$93955eb0$1900a8c0@lifebook.suse.lists.linux.kernel> <000001c27286$6ab6bc60$7443f4d1@joe.suse.lists.linux.kernel> <20021013.000127.43007739.davem@redhat.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 13 Oct 2002 09:24:32 +0200
In-Reply-To: "David S. Miller"'s message of "13 Oct 2002 09:12:48 +0200"
Message-ID: <p73elaupzrj.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:
> 
> Allocating blocks and inodes, yes that is currently single
> threaded on SMP.  But there is no fundamental reason for that,
> we just haven't gotten around to threading that bit yet.

It depends on your file system. XFS and JFS do block and inode allocation
fully SMP multithreaded. reiserfs/ext2/ext3 do not.

Still in 2.4 the VFS takes the big kernel lock unnecessarily for
a few VFS operations (no matter if the underlying FS needs it or not).
That's fixed in 2.5.

-Andi
