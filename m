Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311885AbSDSJEq>; Fri, 19 Apr 2002 05:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311936AbSDSJEp>; Fri, 19 Apr 2002 05:04:45 -0400
Received: from lego.zianet.com ([204.134.124.54]:6928 "EHLO lego.zianet.com")
	by vger.kernel.org with ESMTP id <S311885AbSDSJEo>;
	Fri, 19 Apr 2002 05:04:44 -0400
Message-ID: <3CBFD8C5.2000504@zianet.com>
Date: Fri, 19 Apr 2002 02:43:49 -0600
From: kwijibo@zianet.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG in ext3 (2.4.18pre1)
In-Reply-To: <5.1.0.14.0.20020418230637.0164d828@mailhost.ivimey.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Funny this came up,  I just got a similiar error just last night and I 
did track it down
to being bad RAM so I would take a look at that.

Steven

Ruth Ivimey-Cook wrote:

> I report this in the hope that it might be useful. My machine crashed 
> yesterday with the following messages. It was sort of alive, but not 
> responding to network connections and when I tried to log in as root, 
> Init said it was unable to fork(). At that point I hit the reset 
> switch.  If you need other info please ask.
>
> System: Cyrix i586/333 with 32MB RAM, ALi Mobo. OS: RH7.2/server with 
> kernel.org 2.4.18pre1 kernel + Speedtouch USB patches. System disk is 
> a single Fujitsu 30Gb IDE disk runing ext3.
>
> Apr 17 23:20:01 gatemaster kernel: Assertion failure in 
> __journal_file_buffer() at transaction.c:1935: "jh->b_jlist < 9"
> Apr 17 23:20:01 gatemaster kernel: kernel BUG at transaction.c:1935!
> Apr 17 23:20:01 gatemaster kernel: invalid operand: 0000
> Apr 17 23:20:01 gatemaster kernel: CPU:    0
> Apr 17 23:20:01 gatemaster kernel: EIP:    
> 0010:[__journal_file_buffer+72/476]    Not tainted
> Apr 17 23:20:01 gatemaster kernel: EIP:    0010:[<c0156d18>]    Not 
> tainted
> Apr 17 23:20:01 gatemaster kernel: EFLAGS: 00010282
> Apr 17 23:20:01 gatemaster kernel: eax: 00000022   ebx: c035f820   
> ecx: c029cc20   edx: 00003e1b
> Apr 17 23:20:01 gatemaster kernel: esi: c0d0da60   edi: 00000000   
> ebp: 00000008   esp: c0cf1e40
> Apr 17 23:20:01 gatemaster kernel: ds: 0018   es: 0018   ss: 0018
> Apr 17 23:20:01 gatemaster kernel: Process python (pid: 15602, 
> stackpage=c0cf1000)
> Apr 17 23:20:01 gatemaster kernel: Stack: c0257da0 0000078f c035f820 
> c05d9f80 c035f820 c10a4c00 c0155a58 c035f820
> Apr 17 23:20:01 gatemaster kernel:        c0d0da60 00000008 c10a4c00 
> c05d9f80 c035f820 c10a4c94 00000302 00000000
> Apr 17 23:20:01 gatemaster kernel:        00000000 00000000 c0d0da60 
> c0155b3c c05d9f80 c035f820 00000000 00000000
> Apr 17 23:20:01 gatemaster kernel: Call Trace: 
> [do_get_write_access+1268/1440] [journal_get_write_access+56/88] 
> [ext3_reserve_inode_write+50/172] [ext3_mark_inode_dirty+26/52] 
> [ext3_dirty_inode+182
> /244]
> Apr 17 23:20:01 gatemaster kernel: Call Trace: [<c0155a58>] 
> [<c0155b3c>] [<c014fa0a>] [<c014fa9e>] [<c014fb6e>]
> Apr 17 23:20:01 gatemaster kernel:    [__mark_inode_dirty+46/120] 
> [update_atime+75/80] [do_generic_file_read+1031/1044] 
> [generic_file_read+126/304] [file_read_actor+0/104] [sys_read+150/204]
> Apr 17 23:20:01 gatemaster kernel:    [<c013ecca>] [<c0140073>] 
> [<c01229c7>] [<c0122ca6>] [<c0122bc0>] [<c012e106>]
> Apr 17 23:20:01 gatemaster kernel:    [system_call+51/64]
> Apr 17 23:20:01 gatemaster kernel:    [<c0106b83>]
> Apr 17 23:20:01 gatemaster kernel:
> Apr 17 23:20:01 gatemaster kernel: Code: 0f 0b 83 c4 08 8d 76 00 8b 43 
> 14 39 f0 74 39 85 c0 74 55 68
> Apr 17 23:20:01 gatemaster kernel:  <0>Assertion failure in 
> journal_start() at transaction.c:226: 
> "handle->h_transaction->t_journal == journal"
> Apr 17 23:20:01 gatemaster kernel: kernel BUG at transaction.c:226!
> Apr 17 23:20:01 gatemaster kernel: invalid operand: 0000
> Apr 17 23:20:01 gatemaster kernel: CPU:    0
> Apr 17 23:20:01 gatemaster kernel: EIP:    
> 0010:[journal_start+110/252]    Not tainted
> Apr 17 23:20:01 gatemaster kernel: EIP:    0010:[<c0154e4a>]    Not 
> tainted
> Apr 17 23:20:01 gatemaster kernel: EFLAGS: 00010282
> Apr 17 23:20:01 gatemaster kernel: eax: 00000021   ebx: c05d9f80   
> ecx: c029cc20   edx: 000041e9
> Apr 17 23:20:01 gatemaster kernel: esi: c05d9f80   edi: c15220e0   
> ebp: c10a4e00   esp: c0cf1c28
> Apr 17 23:20:01 gatemaster kernel: ds: 0018   es: 0018   ss: 0018
> Apr 17 23:20:01 gatemaster kernel: Process python (pid: 15602, 
> stackpage=c0cf1000)
> Apr 17 23:20:01 gatemaster kernel: Stack: c0257da0 000000e2 c05d9f80 
> c1967c00 c15220e0 c0cf1cf8 c0cf0000 c014fb0d
> Apr 17 23:20:01 gatemaster kernel:        c10a4e00 00000001 c15220e0 
> c1967c00 00000001 c013ecca c15220e0 c15220e0
> Apr 17 23:20:01 gatemaster kernel:        ffffffff c19a1ee0 c0124588 
> c15220e0 00000001 c19a1ec0 c0000000 c19a1ee0
> Apr 17 23:20:01 gatemaster kernel: Call Trace: 
> [ext3_dirty_inode+85/244] [__mark_inode_dirty+46/120] 
> [generic_file_write+812/1748] [ext3_file_write+70/76] 
> [do_acct_process+552/568]
> Apr 17 23:20:01 gatemaster kernel: Call Trace: [<c014fb0d>] 
> [<c013ecca>] [<c0124588>] [<c014b9ca>] [<c011934c>]
> Apr 17 23:20:01 gatemaster kernel:    [acct_process+25/40] 
> [do_exit+97/492] [do_invalid_op+0/136] [die+82/84] 
> [do_invalid_op+127/136] [__journal_file_buffer+72/476]
> Apr 17 23:20:01 gatemaster kernel:    [<c0119375>] [<c0115ee9>] 
> [<c0107334>] [<c010711e>] [<c01073b3>] [<c0156d18>]
> Apr 17 23:20:01 gatemaster kernel:    [vt_console_print+729/748] 
> [vsnprintf+931/996] [call_console_drivers+225/232] 
> [release_console_sem+46/120] [error_code+52/64] 
> [__journal_file_buffer+72/476]
> Apr 17 23:20:01 gatemaster kernel:    [<c01858f1>] [<c024382f>] 
> [<c0113771>] [<c011396a>] [<c0106c94>] [<c0156d18>]
> Apr 17 23:20:01 gatemaster kernel:    [do_get_write_access+1268/1440] 
> [journal_get_write_access+56/88] [ext3_reserve_inode_write+50/172] 
> [ext3_mark_inode_dirty+26/52] [ext3_dirty_inode+182/244] [__
> mark_inode_dirty+46/120]
> Apr 17 23:20:01 gatemaster kernel:    [<c0155a58>] [<c0155b3c>] 
> [<c014fa0a>] [<c014fa9e>] [<c014fb6e>] [<c013ecca>]
> Apr 17 23:20:01 gatemaster kernel:    [update_atime+75/80] 
> [do_generic_file_read+1031/1044] [generic_file_read+126/304] 
> [file_read_actor+0/104] [sys_read+150/204] [system_call+51/64]
> Apr 17 23:20:01 gatemaster kernel:    [<c0140073>] [<c01229c7>] 
> [<c0122ca6>] [<c0122bc0>] [<c012e106>] [<c0106b83>]
> Apr 17 23:20:01 gatemaster kernel:
> Apr 17 23:20:01 gatemaster kernel: Code: 0f 0b 83 c4 08 90 ff 43 08 89 
> d8 eb 79 6a 01 68 f0 00 00 00
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>



