Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030230AbWGaQi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbWGaQi0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 12:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbWGaQi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 12:38:26 -0400
Received: from lucidpixels.com ([66.45.37.187]:8885 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1030230AbWGaQiZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 12:38:25 -0400
Date: Mon, 31 Jul 2006 12:38:24 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Jan Kasprzak <kas@fi.muni.cz>
cc: Nathan Scott <nathans@sgi.com>, linux-kernel@vger.kernel.org,
       xfs@oss.sgi.com
Subject: Re: FAQ updated (was Re: XFS breakage...)
In-Reply-To: <20060731162535.GA15555@fi.muni.cz>
Message-ID: <Pine.LNX.4.64.0607311238020.13428@p34.internal.lan>
References: <20060718222941.GA3801@stargate.galaxy>
 <20060719085731.C1935136@wobbly.melbourne.sgi.com> <1153304468.3706.4.camel@localhost>
 <20060720171310.B1970528@wobbly.melbourne.sgi.com> <20060731162535.GA15555@fi.muni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 31 Jul 2006, Jan Kasprzak wrote:

> Nathan Scott wrote:
> : I've captured the state of this issue here, with options and ways
> : to correct the problem:
> : 	http://oss.sgi.com/projects/xfs/faq.html#dir2
> :
> : Hope this helps.
>
> 	I have been hit with this bug as well - I tried to clear the
> two corrupted directory inodes with xfs_db (as the FAQ entry says), then ran
> xfs_repair (lots of files ended up in lost+found), but apparently
> the volume is still not OK - when I tried to use it (this volume
> is a public FTP archive), I got the following traces:
>
> Jul 30 16:04:49 odysseus kernel: Filesystem "md5": XFS internal error xfs_da_do_buf(2) at line 2212 of file fs/xfs/xfs_da_btree.c.  Caller 0xffffffff80324221
> Jul 30 16:04:49 odysseus kernel:
> Jul 30 16:04:49 odysseus kernel: Call Trace: <ffffffff803331ac>{xfs_corruption_error+228}
> Jul 30 16:04:49 odysseus kernel:        <ffffffff8035630e>{kmem_zone_alloc+86} <ffffffff803240f0>{xfs_da_do_buf+1359}
> Jul 30 16:04:49 odysseus kernel:        <ffffffff80324221>{xfs_da_read_buf+22} <ffffffff80323aba>{xfs_da_buf_make+31}
> Jul 30 16:04:49 odysseus kernel:        <ffffffff80324221>{xfs_da_read_buf+22} <ffffffff803263e7>{xfs_da_node_lookup_int+112}
> Jul 30 16:04:49 odysseus kernel:        <ffffffff803263e7>{xfs_da_node_lookup_int+112} <ffffffff8032c7b8>{xfs_dir2_node_lookup+70}
> Jul 30 16:04:50 odysseus kernel:        <ffffffff80327b35>{xfs_dir2_isleaf+25} <ffffffff803280d6>{xfs_dir2_lookup+256}
> Jul 30 16:04:51 odysseus kernel:        <ffffffff8034dd10>{xfs_dir_lookup_int+55} <ffffffff803511af>{xfs_lookup+79}
> Jul 30 16:04:51 odysseus kernel:        <ffffffff8035c95a>{xfs_vn_lo7b35>{xfs_dir2_isleaf+25} <ffffffff803280d6>{xfs_dir2_lookup+256}
> Jul 30 16:04:52 odysseus kernel:        <ffffffff8034dd10>{xfs_dir_lookup_int+55} <ffffffff803511af>{xfs_lookup+79}
> Jul 30 16:04:53 odysseus kernel:        <ffffffff8035c95a>{xfs_vn_lookup+48} <ffffffff80270b45>{do_lookup+196}
> Jul 30 16:04:53 odysseus rpc.statd[3145]: Caught signal 15, un-registering and exiting.
> Jul 30 16:04:53 odysseus kernel:        <ffffffff802729c6>{__link_path_walk+2435} <ffffffff80272f40>{link_path_walk+89}
> Jul 30 16:04:53 odysseus kernel:        <ffffffff8049c0d2>{__sched_text_start+290} <ffffffff80273396>{do_path_lookup+614}
> Jul 30 16:04:53 odysseus kernel:        <ffffffff80271e47>{getname+347} <ffffffff80273bd6>{__user_walk_fd+55}
> Jul 30 16:04:53 odysseus kernel:        <ffffffff8026cba7>{vfs_lstat_fd+21} <ffffffff8049c0d2>{__sched_text_start+290}
> Jul 30 16:04:53 odysseus kernel:        <ffffffff8026cd92>{sys_newlstat+25} <ffffffff80265023>{vfs_write+283}
> Jul 30 16:04:53 odysseus kernel:        <ffffffff8026554c>{sys_write+69} <ffffffff80209826>{system_call+126}
> Jul 30 16:04:53 odysseus kernel: 0x0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00
>
> 	This is 2.6.17.7 dual x86_64 (Fedora Core 5). It has been unfortunately
> running 2.6.17.1 for some time.
>
> 	I will probably have to recreate the volume and restore its
> contents from backups. Or is there any better solution?
>
> 	Thanks,
>
> -Yenya
>
> -- 
> | Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
> | GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
> | http://www.fi.muni.cz/~kas/    Journal: http://www.fi.muni.cz/~kas/blog/ |
>> I will never go to meetings again because I think  face to face meetings <
>> are the biggest waste of time you can ever have.        --Linus Torvalds <
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

If you unmount, xfs_repair -n /dev/md5, what does it show currently?
