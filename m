Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbRBOXJQ>; Thu, 15 Feb 2001 18:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129936AbRBOXJI>; Thu, 15 Feb 2001 18:09:08 -0500
Received: from alto.i-cable.com ([210.80.60.4]:33789 "EHLO alto.i-cable.com")
	by vger.kernel.org with ESMTP id <S129066AbRBOXJC>;
	Thu, 15 Feb 2001 18:09:02 -0500
Message-ID: <3A8C61AE.426F0F5D@hkicable.com>
Date: Fri, 16 Feb 2001 07:09:34 +0800
From: Thomas Lau <lkthomas@hkicable.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac13 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-list] oopsing in the reiser included in 2.4.2-pre2
In-Reply-To: <20010215175401.A4743@incandescent.mp3revolution.net>
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andres Salomon wrote:

> I'm getting the following oopses, both apparently in the same place of
> create_virtual_node():
>
> Feb 15 16:03:32 infinity kernel:  printing eip:
> Feb 15 16:03:32 infinity kernel: c015aeaa
> Feb 15 16:03:32 infinity kernel: Oops: 0000
> Feb 15 16:03:32 infinity kernel: CPU:    0
> Feb 15 16:03:32 infinity kernel: EIP:    0010:[create_virtual_node+698/1240]
> Feb 15 16:03:32 infinity kernel: EFLAGS: 00010287
> Feb 15 16:03:32 infinity kernel: eax: ffffff3e   ebx: 00000000   ecx: c12efcc4
>  edx: 00000000
> Feb 15 16:03:32 infinity kernel: esi: c0c8f000   edi: 0000000b   ebp: c0c8f124
>  esp: c12efba0
> Feb 15 16:03:32 infinity kernel: ds: 0018   es: 0018   ss: 0018
> Feb 15 16:03:32 infinity kernel: Process rm (pid: 2756, stackpage=c12ef000)
> Feb 15 16:03:32 infinity kernel: Stack: c0c8f000 c0c8f124 00000000 ffffff3e c12e
> fcc4 000003e8 00000000 00000086
> Feb 15 16:03:32 infinity kernel:        00000016 0000000c 00000000 c0a4b4a0 c0de
> f018 c015d204 c12efcc4 00000000
> Feb 15 16:03:32 infinity kernel:        c12efcc4 00000000 c12efcc4 00000000 0000
> 0000 00000064 00000000 c12efcc4
> kFeb 15 16:03:32 infinity kernel: Call Trace: [dc_check_balance_leaf+84/344] [dc_
> check_balance+32/36] [check_balance+95/104] [fix_nodes+252/1064] [reiserfs_cut_f
> rom_item+154/1120] [reiserfs_cut_from_item+481/1120] [reiserfs_do_truncate+780/1
> 052]
> Feb 15 16:03:33 infinity kernel:        [reiserfs_delete_object+35/56] [reiserfs
> _delete_inode+72/148] [iput+167/340] [d_delete+76/104] [vfs_unlink+246/300] [sys
> _unlink+167/284] [system_call+51/64]
> Feb 15 16:03:33 infinity kernel:
> Feb 15 16:03:33 infinity kernel: Code: 8b 42 14 ff d0 89 c2 03 16 89 16 8b 4c 24
>  38 83 c4 10 8b 81
>
> Feb 15 17:23:47 infinity kernel:  printing eip:
> Feb 15 17:23:47 infinity kernel: c015aeaa
> Feb 15 17:23:47 infinity kernel: Oops: 0000
> Feb 15 17:23:47 infinity kernel: CPU:    0
> Feb 15 17:23:47 infinity kernel: EIP:    0010:[create_virtual_node+698/1240]
> Feb 15 17:23:47 infinity kernel: EFLAGS: 00010287
> Feb 15 17:23:47 infinity kernel: eax: 00000038   ebx: 00000000   ecx: c0c85cb0
>  edx: 00000000
> Feb 15 17:23:47 infinity kernel: esi: c0c59000   edi: 0000000d   ebp: c0c59154
>  esp: c0c85b00
> Feb 15 17:23:47 infinity kernel: ds: 0018   es: 0018   ss: 0018
> Feb 15 17:23:47 infinity kernel: Process BitchX (pid: 189, stackpage=c0c85000)
> Feb 15 17:23:47 infinity kernel: Stack: c0c59000 c0c59154 00000000 00000038 0000
> 0000 00001008 c0c93ba0 c0c85c14
> Feb 15 17:23:47 infinity kernel:        0000001a 0000000e 00000000 c0c93ba0 c0cb
> 0018 c015c4df c0c85cb0 00000000
> Feb 15 17:23:47 infinity kernel:        c0c85ea0 00000069 00000000 00000000 0000
> 0101 00001000 00000282 00000000
> Feb 15 17:23:47 infinity kernel: Call Trace: [ip_check_balance+919/2816] [__allo
> c_pages+219/720] [filemap_nopage+282/1032] [do_no_page+77/192] [check_balance+86
> /104] [fix_nodes+252/1064] [ide_set_handler+89/100]
> Feb 15 17:23:47 infinity kernel:        [reiserfs_insert_item+123/256] [reiserfs
> _new_inode+855/1092] [reiserfs_mkdir+215/456] [vfs_mkdir+133/184] [sys_mkdir+114
> /180] [system_call+51/64]
> Feb 15 17:23:47 infinity kernel:
> Feb 15 17:23:47 infinity kernel: Code: 8b 42 14 ff d0 89 c2 03 16 89 16 8b 4c 24
>  38 83 c4 10 8b 81
>
> This is w/ linux 2.4.2-pre2, Debian testing, and
> ii  reiserfsprogs  3.0.20001019-3 *PRE-RELEASE* Tools for ReiserFS filesystems
>
> Is this a known issue?  What would you folks recommend I do?
> --
> "... being a Linux user is sort of like living in a house inhabited
> by a large family of carpenters and architects. Every morning when
> you wake up, the house is a little different. Maybe there is a new
> turret, or some walls have moved. Or perhaps someone has temporarily
> removed the floor under your bed." - Unix for Dummies, 2nd Edition
>         -- found in the .sig of Rob Riggs, rriggs@tesser.com

do not reply this post please, if you know how to fix problem ( alan please help )
please email to him directly:
dilinger@mp3revolution.net

I just reply to kernel mail list :)

