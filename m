Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263784AbUGFL5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263784AbUGFL5k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 07:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUGFL5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 07:57:40 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:6048 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S263784AbUGFL5g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 07:57:36 -0400
Message-ID: <40EA93AE.7080500@namesys.com>
Date: Tue, 06 Jul 2004 15:57:34 +0400
From: "Vladimir V. Saveliev" <vs@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Jens_B=E4ckman?= <jens.backman@titv.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: ReiserFS panic (faulty hardware?)
References: <2CAE0EA7-CF3F-11D8-B1D3-00039364C5D8@titv.se>
In-Reply-To: <2CAE0EA7-CF3F-11D8-B1D3-00039364C5D8@titv.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Jens Bäckman wrote:
> Hello, hackers.
> 
> So our server decided to stop being useful an hour ago, right when my
> vacation had begun. A quick 'dmesg' told me that a ReiserFS panic had
> occurred. I fed this thing through ksymoops, but got no wiser from the
> result. Maybe you can read something more out of this. Any pointers
> (even 'faulty RAM, replace' or a simple 'sod off' in Viro style) are 
> welcome.
> 
> journal-715: flush_journal_list, length is 9633792, list number 63
>  (device md(9,1))

Well, transaction length is too big. It should  not more than 1024.
So, if this does not reproduce - lets think it was hardware fault.
Chris might want to correct me, though

> kernel BUG at prints.c:341!
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c0199168>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010286
> eax: 00000058   ebx: f7d3e800   ecx: f7eea000   edx: f7cbbf7c
> esi: 00930000   edi: 000010bc   ebp: 00001198   esp: f7eebe24
> ds: 0018   es: 0018   ss: 0018
> Process kupdated (pid: 6, stackpage=f7eeb000)
> Stack: c028c48e c0324780 c03226c0 f7d3e800 c01a52cb f7d3e800 c0294de0 
> 00930000
>        0000003f 0000000b 00000009 f7d3e800 00000000 f7d3e800 000010bc 
> 000010bc
>        000010bc c01a914a f7d3e800 f893e198 00000001 00000006 f880bc48 
> 00002000
> Call Trace:    [<c01a52cb>] [<c01a914a>] [<c01a814e>] [<c019606e>] 
> [<c013c7e2>]
>   [<c013bc8c>] [<c013bf55>] [<c0107182>] [<c013be80>] [<c0105000>] 
> [<c010570b>]
>   [<c013be80>]
> Code: 0f 0b 55 01 a1 c4 28 c0 85 db b8 aa c4 28 c0 74 0c 0f b7 43
> 
> 
>  >>EIP; c0199168 <reiserfs_panic+48/80>   <=====
> 
>  >>ebx; f7d3e800 <_end+379fe0bc/385ba93c>
>  >>ecx; f7eea000 <_end+37ba98bc/385ba93c>
>  >>edx; f7cbbf7c <_end+3797b838/385ba93c>
>  >>esp; f7eebe24 <_end+37bab6e0/385ba93c>
> 
> Trace; c01a52cb <flush_journal_list+42b/430>
> Trace; c01a914a <do_journal_end+86a/b80>
> Trace; c01a814e <flush_old_commits+11e/1b0>
> Trace; c019606e <reiserfs_write_super+2e/30>
> Trace; c013c7e2 <sync_supers+b2/140>
> Trace; c013bc8c <sync_old_buffers+1c/60>
> Trace; c013bf55 <kupdate+d5/160>
> Trace; c0107182 <ret_from_fork+6/20>
> Trace; c013be80 <kupdate+0/160>
> Trace; c0105000 <_stext+0/0>
> Trace; c010570b <arch_kernel_thread+2b/40>
> Trace; c013be80 <kupdate+0/160>
> 
> Code;  c0199168 <reiserfs_panic+48/80>
> 00000000 <_EIP>:
> Code;  c0199168 <reiserfs_panic+48/80>   <=====
>    0:   0f 0b                     ud2a      <=====
> Code;  c019916a <reiserfs_panic+4a/80>
>    2:   55                        push   %ebp
> Code;  c019916b <reiserfs_panic+4b/80>
>    3:   01 a1 c4 28 c0 85         add    %esp,0x85c028c4(%ecx)
> Code;  c0199171 <reiserfs_panic+51/80>
>    9:   db b8 aa c4 28 c0         fstpt  0xc028c4aa(%eax)
> Code;  c0199177 <reiserfs_panic+57/80>
>    f:   74 0c                     je     1d <_EIP+0x1d>
> Code;  c0199179 <reiserfs_panic+59/80>
>   11:   0f b7 43 00               movzwl 0x0(%ebx),%eax
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


