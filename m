Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136111AbRD0Qxj>; Fri, 27 Apr 2001 12:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136110AbRD0Qxa>; Fri, 27 Apr 2001 12:53:30 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:42375 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S136109AbRD0QxT>; Fri, 27 Apr 2001 12:53:19 -0400
Message-ID: <3AE9B203.88B6C799@antefacto.com>
Date: Fri, 27 Apr 2001 18:53:07 +0100
From: Padraig Brady <padraig@antefacto.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.0-ac4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: ramdisk/tmpfs/ramfs/memfs ?
In-Reply-To: <3AE99CE8.BD325F52@antefacto.com>  <Pine.LNX.3.96.1010426203656.22847A-100000@medusa.sparta.lu.se> <15296.988386995@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> 
> padraig@antefacto.com said:
> > btw I get my initial root filesystem from a compact flash that can be
> > accessed just like a hardisk. It's writeable also like a harddisk, but
> > we boot with it readonly, and only mount it rw if we want to save
> > config or whatever. We definitely wouldn't swap to it as it has
> > limited erase/write cycles. The filesystem is compressed ext2.
> 
> Why copy it into RAM? Why not use cramfs and either turn the writable
> directories into symlinks into a ramfs which you create at boot time, or
> union-mount a ramfs over the top of it?

? I never said I copied it into RAM. The ramfs is just used for /tmp &
/var
which are symlinks on the flash. I didn't know you could read/write
cramfs
like ext2/JFFS2? I still want to be able to update/create/delete files
like a normal ext2 partition. Oh I see the confusion, sorry my fault,
when
I said the root filesystem is compressed ext2, I meant it's ext2 with
chattr +c done on all files (the e2compr patch implmenents it). By the
way why isn't e2compr a standard part of the kernel. I've have no
problems
at all with it.

I didn't know about union-mounting, seems useful.

As for whether to use tmpfs/ramfs I think they do basically the same
thing 
only the implementation is different. tmpfs uses shared mem and so is 
probably more portable than ramfs which it tightly coupled with VFS. I
think I'll use ramfs (with limits patch) so.

> padraig@antefacto.com said:
> > As for using JFFS2 + MTD ramdisk intead of ext2+e2compr+ramdisk is not
> > an option as the only advantage would be journalling, you still can't
> > resize. IMHO JFFS is only required where you have flash without an IDE
> > interface.
> 
> True. We are currently lacking a compact, compressing, journalling
> filesystem for use on block devices. It's been suggested that we could make
> JFFS2 work on them, by making a fake MTD device which uses a block device
> as backing store. Nobody's yet shown me the code though :)

How much more efficent is JFFS than say ext3+e3compr, wrt:
logic size/logic speed/RAM requirements/filesystem structure size.

> --
> dwmw2

Padraig.
