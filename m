Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129040AbQKDOxj>; Sat, 4 Nov 2000 09:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129095AbQKDOxa>; Sat, 4 Nov 2000 09:53:30 -0500
Received: from www.ylenurme.ee ([193.40.6.1]:7930 "EHLO ylenurme.ee")
	by vger.kernel.org with ESMTP id <S129040AbQKDOxN>;
	Sat, 4 Nov 2000 09:53:13 -0500
Date: Sat, 4 Nov 2000 05:02:32 +0200 (GMT-2)
From: Elmer Joandi <elmer@ylenurme.ee>
To: linux-kernel@vger.kernel.org
Subject: OOPS: 2.4.0-test10-pre6 around reiserfs 3.6.18
Message-ID: <Pine.LNX.4.10.10011040453160.10531-100000@yle-server.ylenurme.sise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


under serious memory shortage, memory hog running and doing random access
over 133 MB(128MB ram) and disk output as fast as it could.
swap(128M) free = 0M, stable high disk io for long time, then
me killing X with -9 , got oops.
/home is on reiserfs, which is on raid, which has 5 slices all on same
disk (for fun).


Nov  4 07:22:32 fw kernel:  printing eip: 
Nov  4 07:22:32 fw kernel: c0133296 
Nov  4 07:22:32 fw kernel: *pde = 00000000 
Nov  4 07:22:32 fw kernel: Oops: 0000 
Nov  4 07:22:32 fw kernel: CPU:    0 
Nov  4 07:22:32 fw kernel: EIP:    0010:[block_read_full_page+14/500] 
Nov  4 07:22:32 fw kernel: EFLAGS: 00010282 
Nov  4 07:22:32 fw kernel: eax: 00000000   ebx: 00000000   ecx: c51c1f24   edx: c11d4f2c 
Nov  4 07:22:32 fw kernel: esi: c11d4f2c   edi: c04c157c   ebp: 00000000   esp: c7e75ee4 
Nov  4 07:22:32 fw kernel: ds: 0018   es: 0018   ss: 0018 
Nov  4 07:22:32 fw kernel: Process bash (pid: 24057, stackpage=c7e75000) 
Nov  4 07:22:32 fw kernel: Stack: 00000000 c11d4f2c c04c157c 00000000 00000000 00000000 c11d4f2c c04c157c  
Nov  4 07:22:32 fw kernel:        00000000 c021f0f0 c7e75f10 00000000 c51c1f24 c11d4f58 c11d4f2c c04c157c  
Nov  4 07:22:32 fw kernel:        00000000 c0278e40 c015faf7 c11d4f2c c015d4b8 c0124f56 c68d8e40 c11d4f2c  
Nov  4 07:22:32 fw kernel: Call Trace: [call_apic_timer_interrupt+5/13] [reiserfs_readpage+15/20] [reiserfs_get_block+0/3548] [do_generic_file_read+698/1284] [generic_file_read+91/120] [file_read_actor+0/84] [sys_read+143/196]  
Nov  4 07:22:32 fw kernel:        [system_call+51/56]  
Nov  4 07:22:32 fw kernel: Code: 8b 40 10 89 44 24 24 c7 44 24 18 00 00 00 00 8b 42 18 a8 01  

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
