Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270381AbRH1IFN>; Tue, 28 Aug 2001 04:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270386AbRH1IFD>; Tue, 28 Aug 2001 04:05:03 -0400
Received: from ns2.teleworld.at ([212.152.248.30]:4695 "EHLO
	sgisrv1.teleworld.at") by vger.kernel.org with ESMTP
	id <S270381AbRH1IEo>; Tue, 28 Aug 2001 04:04:44 -0400
Message-ID: <3B8B50A6.D0D11A3A@teleworld.at>
Date: Tue, 28 Aug 2001 10:04:54 +0200
From: Gerald Weber <gerald.weber@teleworld.at>
Reply-To: gerald.weber@teleworld.at
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en,de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: oops with 2.4.9-xfs
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi there,

oops with 2.4.9 (cvs checkout from oss.sgi.com,18-aug-01) on a dell 2450 / dual
p3 with ~800mhz
running suse-7.1
1 mylex accelraid 170,single channel
1 mylex accelraid 352 dual channel (serving ~300gb xfs raid5)


Aug 28 00:36:11 twasrv1 kernel: invalid operand: 0000
Aug 28 00:36:11 twasrv1 kernel: CPU:    0
Aug 28 00:36:11 twasrv1 kernel: EIP:    0010:[__get_free_pages+8/24]
Aug 28 00:36:11 twasrv1 kernel: EFLAGS: 00010682
Aug 28 00:36:11 twasrv1 kernel: eax: d19bf1f4   ebx: 00000000   ecx: c10a91a0  
edx: 00000000
Aug 28 00:36:11 twasrv1 kernel: esi: c10a9173   edi: 00000ce4   ebp: d09170e4  
esp: cc345e90
Aug 28 00:36:11 twasrv1 kernel: ds: 0018   es: 0018   ss: 0018
Aug 28 00:36:11 twasrv1 kernel: Process tar (pid: 9716, stackpage=cc345000)
Aug 28 00:36:11 twasrv1 kernel: Stack: c0125f9b 00001ce4 080691f0 00000000
dfcc8000 dfe9d930 00000000 00000ce4 
Aug 28 00:36:11 twasrv1 kernel:        00000001 00000000 00000001 d0917040
c0126377 de95b800 cc345f8c cc345ee0 
Aug 28 00:36:11 twasrv1 kernel:        c01262c0 de95b800 00001ce4 080691f0
00001000 00000ce4 0806a1f0 00000000 
Aug 28 00:36:11 twasrv1 kernel: Call Trace: [do_generic_file_read+563/1368]
[generic_file_read+99/128] [file_read_actor+0/84] [xfs_read+650/724]
[linvfs_read+167/212] 
Aug 28 00:36:11 twasrv1 kernel: Code: ff ff 85 c0 75 03 31 c0 c3 8b 40 3c c3 8d
76 00 57 31 d2 53 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   ff                        (bad)  
Code;  00000001 Before first symbol
   1:   ff 85 c0 75 03 31         incl   0x310375c0(%ebp)
Code;  00000007 Before first symbol
   7:   c0 c3 8b                  rol    $0x8b,%bl
Code;  0000000a Before first symbol
   a:   40                        inc    %eax
Code;  0000000b Before first symbol
   b:   3c c3                     cmp    $0xc3,%al
Code;  0000000d Before first symbol
   d:   8d 76 00                  lea    0x0(%esi),%esi
Code;  00000010 Before first symbol
  10:   57                        push   %edi
Code;  00000011 Before first symbol
  11:   31 d2                     xor    %edx,%edx
Code;  00000013 Before first symbol
  13:   53                        push   %ebx

this is the command causing the oops:

tar cf - . | gzip -c > backup.tar.gz

the dir in which tar is looking for files is exported via nfs (not knfsd) to
other hosts.

kernel 2.4.[3-8] usually die at this point.no network,no console,caps lock and
scroll lock are blinking
on keyboard...

gcc used to compile kernel:
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/specs
gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)

any hints ?
tell me if anyone needs more info..

please cc me if possible,i'm not subscibed to the list.
this mail is going to xfs-mailing list also..

thanks,
gerald weber
