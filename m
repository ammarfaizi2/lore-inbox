Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267641AbTAQTSQ>; Fri, 17 Jan 2003 14:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267644AbTAQTSQ>; Fri, 17 Jan 2003 14:18:16 -0500
Received: from mailb.telia.com ([194.22.194.6]:52680 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id <S267641AbTAQTSJ>;
	Fri, 17 Jan 2003 14:18:09 -0500
X-Original-Recipient: <linux-kernel@vger.kernel.org>
Message-ID: <002801c2be5e$675e1ee0$4fc8a8c0@NERV.NERV>
Reply-To: "Zydox" <Zydox@Smurfa.com>
From: "Zydox" <Zydox@Smurfa.com>
To: <linux-kernel@vger.kernel.org>
Subject: kernel BUG at revoke.c:329!
Date: Fri, 17 Jan 2003 20:26:58 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was what happend when I ran this serie of commands on a ramdisk...

mkfs -t ext3 /dev/ram0
tune2fs -r 0 /dev/ram0
mount /dev/ram0 /mnt/www
rm /mnt/www/* -rf
umount /mnt/www
mkfs -t ext3 /dev/ram0
tune2fs -r 0 /dev/ram0
mount /dev/ram0 /mnt/www
rm /mnt/www/* -rf

Jan 17 20:18:45 Balthasar-2 kernel: kjournald starting.  Commit interval 5
seconds
Jan 17 20:18:45 Balthasar-2 kernel: EXT3 FS 2.4-0.9.18, 14 May 2002 on
ramdisk(1,0), internal journal
Jan 17 20:18:45 Balthasar-2 kernel: EXT3-fs: mounted filesystem with ordered
data mode.
Jan 17 20:19:03 Balthasar-2 kernel: kjournald starting.  Commit interval 5
seconds
Jan 17 20:19:03 Balthasar-2 kernel: EXT3 FS 2.4-0.9.18, 14 May 2002 on
ramdisk(1,0), internal journal
Jan 17 20:19:03 Balthasar-2 kernel: EXT3-fs: mounted filesystem with ordered
data mode.
Jan 17 20:19:03 Balthasar-2 kernel: Assertion failure in
journal_revoke_Rsmp_c9928903() at revoke.c:329: "!(__builtin_constant_p(BH$
Jan 17 20:19:03 Balthasar-2 kernel: ------------[ cut here ]------------
Jan 17 20:19:03 Balthasar-2 kernel: kernel BUG at revoke.c:329!
Jan 17 20:19:03 Balthasar-2 kernel: invalid operand: 0000
Jan 17 20:19:03 Balthasar-2 kernel: nfsd lockd sunrpc 3c59x iptable_filter
ip_tables ext3 jbd
Jan 17 20:19:03 Balthasar-2 kernel: CPU:    1
Jan 17 20:19:03 Balthasar-2 kernel: EIP:    0010:[<f082bf3c>]    Not tainted
Jan 17 20:19:03 Balthasar-2 kernel: EFLAGS: 00010282
Jan 17 20:19:03 Balthasar-2 kernel:
Jan 17 20:19:03 Balthasar-2 kernel: EIP is at journal_revoke_Rsmp_c9928903
[jbd] 0x13c (2.4.18-14smp)
Jan 17 20:19:03 Balthasar-2 kernel: eax: 000000d0   ebx: ec319ec0   ecx:
00000097   edx: ec2cdd60
Jan 17 20:19:03 Balthasar-2 kernel: esi: ef5b3400   edi: ec319ec0   ebp:
c1a99860   esp: ec2cddc0
Jan 17 20:19:03 Balthasar-2 kernel: ds: 0018   es: 0018   ss: 0018
Jan 17 20:19:03 Balthasar-2 kernel: Process rm (pid: 797,
stackpage=ec2cd000)
Jan 17 20:19:03 Balthasar-2 kernel: Stack: f08304a0 f082ef2b f082eec0
00000149 f0830520 ecdfc164 ecdfc040 c1a99860
Jan 17 20:19:03 Balthasar-2 kernel:        c1a99860 f0838ad4 c1a99860
00000104 ec319ec0 00000103 00000400 00000001
Jan 17 20:19:03 Balthasar-2 kernel:        00000000 ecdfc164 ecdfc164
00000104 ec2cc000 f083b239 c1a99860 00000000
Jan 17 20:19:03 Balthasar-2 kernel: Call Trace: [<f08304a0>] .rodata.str1.32
[jbd] 0x12e0 (0xec2cddc0))
Jan 17 20:19:03 Balthasar-2 kernel: [<f082ef2b>] .rodata.str1.1 [jbd] 0x48b
(0xec2cddc4))
Jan 17 20:19:03 Balthasar-2 kernel: [<f082eec0>] .rodata.str1.1 [jbd] 0x420
(0xec2cddc8))
Jan 17 20:19:03 Balthasar-2 kernel: [<f0830520>] .rodata.str1.32 [jbd]
0x1360 (0xec2cddd0))
Jan 17 20:19:03 Balthasar-2 kernel: [<f0838ad4>] ext3_forget [ext3] 0x94
(0xec2cdde4))
Jan 17 20:19:04 Balthasar-2 kernel: [<f083b239>] ext3_clear_blocks [ext3]
0x119 (0xec2cde14))
Jan 17 20:19:04 Balthasar-2 kernel: [<f082863f>] __journal_file_buffer [jbd]
0x1bf (0xec2cde44))
Jan 17 20:19:04 Balthasar-2 kernel: [<f083b45b>] ext3_free_data [ext3] 0x16b
(0xec2cde5c))
Jan 17 20:19:04 Balthasar-2 kernel: [<f0838c04>] start_transaction [ext3]
0x94 (0xec2cde9c))
Jan 17 20:19:04 Balthasar-2 kernel: [<f083bbc8>] ext3_truncate [ext3] 0x478
(0xec2cdeb4))
Jan 17 20:19:04 Balthasar-2 kernel: [<f082624a>] start_this_handle [jbd]
0xaa (0xec2cded0))
Jan 17 20:19:04 Balthasar-2 kernel: [<f0826445>] journal_start_Rsmp_36a229d3
[jbd] 0xa5 (0xec2cdefc))
Jan 17 20:19:04 Balthasar-2 kernel: [<f0827b9e>] journal_stop_Rsmp_691ba086
[jbd] 0x17e (0xec2cdf10))
Jan 17 20:19:04 Balthasar-2 kernel: [<f0838c04>] start_transaction [ext3]
0x94 (0xec2cdf20))
Jan 17 20:19:04 Balthasar-2 kernel: [<f0838dd9>] ext3_delete_inode [ext3]
0x159 (0xec2cdf38))
Jan 17 20:19:04 Balthasar-2 kernel: [<f0838c80>] ext3_delete_inode [ext3]
0x0 (0xec2cdf4c))
Jan 17 20:19:04 Balthasar-2 kernel: [<c0163969>] iput [kernel] 0x149
(0xec2cdf54))
Jan 17 20:19:04 Balthasar-2 kernel: [<c0160c39>] dput [kernel] 0xb9
(0xec2cdf70))
Jan 17 20:19:04 Balthasar-2 kernel: [<c01589f9>] sys_rmdir [kernel] 0xf9
(0xec2cdf84))
Jan 17 20:19:04 Balthasar-2 kernel: [<c0109437>] system_call [kernel] 0x33
(0xec2cdfc0))
Jan 17 20:19:04 Balthasar-2 kernel:
Jan 17 20:19:04 Balthasar-2 kernel:
Jan 17 20:19:04 Balthasar-2 kernel: Code: 0f 0b 49 01 c0 ee 82 f0 e9 54 ff
ff ff 89 04 24 8b 44 24 2c

// Regards Zydox
   Zydox@Smurfa.com


