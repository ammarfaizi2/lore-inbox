Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbVDFWat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbVDFWat (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 18:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbVDFWas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 18:30:48 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:43377 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262339AbVDFWa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 18:30:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=IprhtPClUW3gK4OLZdHWBckj2AmmqaZ1kIOUPZMMOlz6kREghBWpH/9j1CvTSvp71JrOYhSjSX+XJTpeYnePU/Isc0m5yJqshm1lOU655oukm6N8vZD9YiL3UiU6oMbNgB/5JbZShR9LYaCpDEQP/RQv7NGPeJDkIIWXvBXyAyg=
Message-ID: <5a4c581d05040615306f12ebde@mail.gmail.com>
Date: Thu, 7 Apr 2005 00:30:28 +0200
From: Alessandro Suardi <alessandro.suardi@gmail.com>
Reply-To: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: non-fatal oops with EIP at skb_release_data, available for debugging
Cc: netdev@oss.sgi.com
In-Reply-To: <5a4c581d05030412482a596ee5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <5a4c581d05030412482a596ee5@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting my post of over a month ago, hit another
 non-fatal oops this time with 2.6.12-rc1-bk2...

[17330.816664] Adding 232932k swap on /dev/hdb4.  Priority:-2 extents:1
[42120.713332] UDP: bad checksum. From 84.188.199.xxx:57483 to
192.168.1.7:10600  ulen 27
[56984.872784] UDP: bad checksum. From 216.155.90.xxx:11417 to
192.168.1.7:10600  ulen 28
[383152.586711] scsi: unknown opcode 0x01
[630539.047761] UDP: short packet: From 4.46.101.xxx:5431 58/27 to
192.168.1.7:1 0600
[681405.777002] ------------[ cut here ]------------
[681405.777337] kernel BUG at include/linux/mm.h:343!
[681405.777642] invalid operand: 0000 [#1]
[681405.777885] PREEMPT
[681405.778041] Modules linked in: parport_pc parport 8139too floppy
[681405.778488] CPU:    0
[681405.778491] EIP:    0060:[<c02dcd23>]    Not tainted VLI
[681405.778494] EFLAGS: 00210256   (2.6.12-rc1-bk2)
[681405.779293] EIP is at skb_release_data+0xa3/0xb0
[681405.779593] eax: 00000000   ebx: 00000002   ecx: ceb1af80   edx: c10eeb40
[681405.780027] esi: c30785c0   edi: c30785c0   ebp: ccd95d28   esp: ccd95d20
[681405.780458] ds: 007b   es: 007b   ss: 0068
[681405.780723] Process metacity (pid: 2190, threadinfo=ccd94000 task=cb501a40)
[681405.781164] Stack: c30785c0 00000020 ccd95d34 c02dcd3b cec7a6c0
ccd95d54 c02 dcdb7 ccd95f3c
[681405.781807]        00001620 c30785c0 506c6f85 c30785c0 506c6f85
ccd95da8 c03 0100a 00000000
[681405.782448]        c02dc46f caf7d420 ccd95d80 00000001 caf7d46c
ccd94000 000 00001 00000000
[681405.783088] Call Trace:
[681405.783258]  [<c010303a>] show_stack+0x7a/0x90
[681405.783574]  [<c01031bd>] show_registers+0x14d/0x1c0
[681405.783915]  [<c01033b4>] die+0xe4/0x170
[681405.784192]  [<c01037e3>] do_invalid_op+0xa3/0xb0
[681405.784517]  [<c0102cbf>] error_code+0x2b/0x30
[681405.785009]  [<c02dcd3b>] kfree_skbmem+0xb/0x20
[681405.785494]  [<c02dcdb7>] __kfree_skb+0x67/0xf0
[681405.785978]  [<c030100a>] tcp_recvmsg+0x5fa/0x720
[681405.786477]  [<c02dc836>] sock_common_recvmsg+0x46/0x60
[681405.787004]  [<c02d90ed>] sock_recvmsg+0xbd/0xf0
[681405.787493]  [<c02d9443>] sock_readv_writev+0x83/0x90
[681405.788009]  [<c02d948b>] sock_readv+0x3b/0x50
[681405.788487]  [<c0150cb5>] do_readv_writev+0x205/0x230
[681405.789004]  [<c0150d1d>] vfs_readv+0x3d/0x50
[681405.789476]  [<c0150dcd>] sys_readv+0x3d/0xa0
[681405.789947]  [<c0102abb>] sysenter_past_esp+0x54/0x75
[681405.790461] Code: 8b 86 98 00 00 00 5e c9 e9 7b e9 e5 ff 89 d0 e8
44 f7 e5 f f eb d6 89 f0 e8 fb fe ff ff 5b 8b 86 98 00 00 00 5e c9 e9
5d e9 e5 ff <0f> 0b 5 7 01 32 ed 35 c0 eb ac 8d 76 00 55 89 e5 53 89
c3 e8 45
[681405.857278]  <7>UDP: short packet: From 213.23.1.xxx:11236 2814/33
to 192.168. 1.7:10600


On Mar 4, 2005 10:48 PM, Alessandro Suardi <alessandro.suardi@gmail.com> wrote:
> This is my K7-800, 256MB RAM machine running as
>  ed2k/bittorrent 24/7 box... metacity died, but the
>  windows are still alive (and working) so if someone
>  wants to get more info about it, just ping me...
> 
> [root@donkey ~]# cat /proc/version
> Linux version 2.6.11-rc3-bk8 (asuardi@donkey) (gcc version 3.4.2
> 20041017 (Red Hat 3.4.2-6.fc3)) #1 Sat Feb 12 00:01:28 CET 2005
> [root@donkey ~]# lsmod
> Module                  Size  Used by
> loop                   15368  -
> nls_iso8859_1           3840  -
> parport_pc             29444  -
> parport                24704  -
> 8139too                24896  -
> floppy                 57392  -
> 
> From the dmesg ring:
> 
> kernel BUG at include/linux/mm.h:343!
> invalid operand: 0000 [#1]
> PREEMPT
> Modules linked in: loop nls_iso8859_1 parport_pc parport 8139too floppy
> CPU:    0
> EIP:    0060:[<c02da6a2>]    Not tainted VLI
> EFLAGS: 00210256   (2.6.11-rc3-bk8)
> EIP is at skb_release_data+0x92/0xa0
> eax: 00000000   ebx: 00000000   ecx: cca36f80   edx: c11a97c0
> esi: c4205f20   edi: c4205f20   ebp: cd149dcc   esp: cd149dc4
> ds: 007b   es: 007b   ss: 0068
> Process metacity (pid: 2109, threadinfo=cd148000 task=ce8935d0)
> Stack: c4205f20 00000000 cd149dd8 c02da6bb c6e9a0c0 cd149df8 c02da737 c5134250
>        00000000 c4205f20 c5134250 c4205f20 c5134250 cd149e4c c02feba6 00000000
>        00000040 cc68c454 00000000 00000001 cc68c444 cd148000 00000001 00000000
> Call Trace:
>  [<c0102b2a>] show_stack+0x7a/0x90
>  [<c0102cad>] show_registers+0x14d/0x1c0
>  [<c0102ea4>] die+0xe4/0x180
>  [<c01032e3>] do_invalid_op+0xa3/0xb0
>  [<c01027a7>] error_code+0x2b/0x30
>  [<c02da6bb>] kfree_skbmem+0xb/0x20
>  [<c02da737>] __kfree_skb+0x67/0xf0
>  [<c02feba6>] tcp_recvmsg+0x5f6/0x710
>  [<c02da1e6>] sock_common_recvmsg+0x46/0x60
>  [<c02d6bbe>] sock_aio_read+0xee/0x100
>  [<c014e427>] do_sync_read+0x97/0xf0
>  [<c014e511>] vfs_read+0x91/0x120
>  [<c014e7ed>] sys_read+0x3d/0x70
>  [<c01025a9>] sysenter_past_esp+0x52/0x75
> Code: c9 e9 03 e5 e5 ff 8d 76 00 5b 5e c9 c3 89 d0 e8 c5 f2 e5 ff eb
> cf 89 f0 e8 0c ff ff ff 5b 8b 86 98 00 00 00 5e c9 e9 de e4 e5 ff <0f>
> 0b 57 01 ab c5 35 c0 eb a5 8d 74 26 00 55 89 e5 53 89 c3 e8
 
--alessandro

 "I want to know if it's you I don't trust
  'cause I damn sure don't trust myself"

    (Bruce Springsteen, "Brilliant Disguise")
