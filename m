Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261838AbULGP36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbULGP36 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 10:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbULGP36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 10:29:58 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:15523 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261838AbULGP3q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 10:29:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=mQehEDqVmUWGM30LBm77z8pDVFRvNQ3RzNPuBlhFFoQwAp/5ME8r5GjV9LsfVNfU4IfIavkwqKBx6/hBepEutF1ROpYCYbsUU1BUulaKdg9WGLs6HK7NzDx/T4scRsbpt9rpu4zukhQOWHbP9iX58DFqtijsEkSuenrCnTHeft4=
Message-ID: <3063e504120707297d3d05f8@mail.gmail.com>
Date: Tue, 7 Dec 2004 17:29:46 +0200
From: George Alexandru Dragoi <waruiinu@gmail.com>
Reply-To: George Alexandru Dragoi <waruiinu@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc[2|3] protection fault on /proc/devices
Cc: Georg Schild <dangertools@gmx.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20041206234044.51667e94.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41B4E70F.8040306@gmx.net> <20041206234044.51667e94.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

I have some similar problem. I use 2.6.10-rc2-mm3 kernel. For some
reason i can't read /proc/modules

31222 ?        D      0:00 lsmod
31243 ?        D      0:00 cat /proc/modules

This is what remained in memory after i tryed to see modules list. I
also had some problem with this kernel after i loaded iptables_nat,
and unload it and also unload the ip_conntrack module and after that i
got some OOPS, and then a nice panic. I mailed after that to this
list.


On Mon, 6 Dec 2004 23:40:44 -0800, Andrew Morton <akpm@osdl.org> wrote:
> Georg Schild <dangertools@gmx.net> wrote:
> 
> 
> >
> > Since 2.6.10-rc2 I am having problems accessing /proc/devices. On
> > startup some init-skripts access this node and print out a protection
> > fault. i am having this on pcmcia and swap startup. My system is an
> > amd64 @3000+ in an Acer Aspire 1501Lmi at 64bit mode running gentoo.
> > .config is the same as on 2.6.10-rc1 which works good. cat on
> > /proc/devices gives the same problems. The kernel has just a patch for
> > wbsd (builtin mmc-cardreader) from Pierre Ossman in use, everything else
> > is vanilla. Does anyone know of this issue and perhaps on how to solve this?
> >
> > Regards
> >
> > Georg Schild
> >
> > > kjournald starting.  Commit interval 5 seconds
> > > EXT3 FS on hda10, internal journal
> > > EXT3-fs: mounted filesystem with ordered data mode.
> > > kjournald starting.  Commit interval 5 seconds
> > > EXT3 FS on hda11, internal journal
> > > EXT3-fs: mounted filesystem with ordered data mode.
> > > general protection fault: 0000 [1]
> > > CPU 0
> > > Modules linked in:
> > > Pid: 5693, comm: grep Not tainted 2.6.10-rc3
> > > RIP: 0010:[<ffffffff8028c5b5>] <ffffffff8028c5b5>{get_blkdev_list+85}
> > > RSP: 0018:000001001eec1e48  EFLAGS: 00010202
> > > RAX: 000000000000000c RBX: 6d736f2d636f7270 RCX: 0000000000000000
> > > RDX: ffffffff804332e2 RSI: fffffffffffffffe RDI: ffffffff804332e2
> > > RBP: 0000000000000048 R08: 00000000ffffffff R09: 0000000000000009
> > > R10: 00000000ffffffff R11: 0000000000000000 R12: 000001001f248139
> > > R13: 000000000000000b R14: 0000000000000c00 R15: 0000000000000000
> > > FS:  0000000000000000(0000) GS:ffffffff805f71c0(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> > > CR2: 0000002a95725f60 CR3: 0000000000101000 CR4: 00000000000006e0
> > > Process grep (pid: 5693, threadinfo 000001001eec0000, task 000001001e80f0b0)
> > > Stack: 0000000000000003 0000000000000139 000001001eec1ed8 000001001f248000
> > >        000001001eec1ed4 ffffffff80186903 000001001ec4be80 0000000000000000
> > >        000001001f248000 0000000000000c00
> > > Call Trace:<ffffffff80186903>{devices_read_proc+67} <ffffffff801841ba>{proc_file_read+234}
> > >        <ffffffff80158ac7>{vfs_read+199} <ffffffff80158d73>{sys_read+83}
> > >        <ffffffff8010e12a>{system_call+126}
> > >
> > > Code: 8b 53 08 48 8d 4b 0c 48 63 fd 4c 01 e7 48 c7 c6 db 32 43 80
> 
> How odd.  All I can think is that something has registered a zillion
> devices and get_blkdev_list() has run off the /proc page.  But then, it
> should have oopsed in sprintf()..
> 
> Still.  Please send a copy of your /proc/devices from 2.6.10-rc1 and also
> apply this:
> 
> --- 25/drivers/block/genhd.c~a  2004-12-06 23:31:13.677476528 -0800
> +++ 25-akpm/drivers/block/genhd.c       2004-12-06 23:31:30.539913048 -0800
> @@ -48,9 +48,11 @@ int get_blkdev_list(char *p)
> 
>         down_read(&block_subsys.rwsem);
>         for (i = 0; i < ARRAY_SIZE(major_names); i++) {
> -               for (n = major_names[i]; n; n = n->next)
> -                       len += sprintf(p+len, "%3d %s\n",
> +               for (n = major_names[i]; n; n = n->next) {
> +                       if (len < PAGE_SIZE / 2)
> +                               len += sprintf(p+len, "%3d %s\n",
>                                        n->major, n->name);
> +               }
>         }
>         up_read(&block_subsys.rwsem);
> 
> _
> 
> to 2.6.10-rc3 and see if that fixes it.  If so, please send the
> /proc/devices content from this kernel.
> 
> Beyond that, perhaps something scribbled on the data structures in there.
> Setting CONFIG_SLAB_DEBUG and/or CONFIG_DEBUG_PAGEALLOC might turn
> something up.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Bla bla
