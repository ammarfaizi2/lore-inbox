Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264859AbSLLGcs>; Thu, 12 Dec 2002 01:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267425AbSLLGcs>; Thu, 12 Dec 2002 01:32:48 -0500
Received: from mail47-s.fg.online.no ([148.122.161.47]:36770 "EHLO
	mail47.fg.online.no") by vger.kernel.org with ESMTP
	id <S264859AbSLLGcq>; Thu, 12 Dec 2002 01:32:46 -0500
Date: Thu, 12 Dec 2002 07:40:28 +0100 (MET)
Message-Id: <200212120640.HAA02320@mail47.fg.online.no>
From: Michael <soppscum@online.no>
To: linux-kernel@vger.kernel.org
Subject: 2.5.51 bttv oops.
Organization: na
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I added the 20_tda9887-2.5.50.diff patch to be able to compile it.
Then when I boot it tries to modprobe bttv automatically, it zombies, I press alt+sysrq+k and I get the oops.
For some reason I have no /proc/ksyms in 2.5.51, so I don't know if this is useful at all.

Thanks.


lsmod output :
bttv                   78516  0
video_buf              10324  1 bttv [permanent]
i2c_algo_bit            7462  2 bttv [unsafe]
i2c_core               15345  2 bttv i2c_algo_bit
v4l2_common             2656  1 bttv [permanent]
videodev                3455  1 bttv
emu10k1                49952  0
soundcore               3926  2 bttv emu10k1
ac97_codec              9704  1 emu10k1 [permanent]

ksymoops :
ksymoops 2.4.8 on i586 2.5.51.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.51/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 00000000
c0124709
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<c0124709>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: e7ffe800   ebx: e7360000   ecx: 00000000   edx: e77ba080
esi: 00000000   edi: 00000000   ebp: e7361f80   esp: e7361f74
ds: 0068   es: 0068   ss: 0068
Stack: e7360000 e77ba080 00000000 e7361fb0 c0124593 00000000 00000000 00000000 
       00000000 00000000 00000000 c027b180 e7360000 e77ba080 00000000 e7361fc0 
       c0124027 c0124160 e8915d9d e7361fec c01241b3 c027f5e0 e7361fd4 c027f6e0 
Call Trace: [<c0124593>]  [<c0124027>]  [<c0124160>]  [<e8915d9d>]  [<c01241b3>]
  [<e8915d9d>]  [<c0124160>]  [<c01072d9>]  [<e8915d9d>] 
Code: ff 4e 00 0f 94 c0 84 c0 75 0d 8d 65 f4 5b 5e 5f c9 c3 90 8d 


>>EIP; c0124709 <put_namespace+9/71>   <=====

Trace; c0124593 <use_init_fs_context+33/1a0>
Trace; c0124027 <exec_usermodehelper+27/160>
Trace; c0124160 <exec_modprobe+0/a0>
Trace; e8915d9d <END_OF_CODE+2862f969/????>
Trace; c01241b3 <exec_modprobe+53/a0>
Trace; e8915d9d <END_OF_CODE+2862f969/????>
Trace; c0124160 <exec_modprobe+0/a0>
Trace; c01072d9 <kernel_thread_helper+5/c>
Trace; e8915d9d <END_OF_CODE+2862f969/????>

Code;  c0124709 <put_namespace+9/71>
00000000 <_EIP>:
Code;  c0124709 <put_namespace+9/71>   <=====
   0:   ff 4e 00                  decl   0x0(%esi)   <=====
Code;  c012470c <put_namespace+c/71>
   3:   0f 94 c0                  sete   %al
Code;  c012470f <put_namespace+f/71>
   6:   84 c0                     test   %al,%al
Code;  c0124711 <put_namespace+11/71>
   8:   75 0d                     jne    17 <_EIP+0x17>
Code;  c0124713 <put_namespace+13/71>
   a:   8d 65 f4                  lea    0xfffffff4(%ebp),%esp
Code;  c0124716 <put_namespace+16/71>
   d:   5b                        pop    %ebx
Code;  c0124717 <put_namespace+17/71>
   e:   5e                        pop    %esi
Code;  c0124718 <put_namespace+18/71>
   f:   5f                        pop    %edi
Code;  c0124719 <put_namespace+19/71>
  10:   c9                        leave  
Code;  c012471a <put_namespace+1a/71>
  11:   c3                        ret    
Code;  c012471b <put_namespace+1b/71>
  12:   90                        nop    
Code;  c012471c <put_namespace+1c/71>
  13:   8d 00                     lea    (%eax),%eax


1 warning and 1 error issued.  Results may not be reliable.
