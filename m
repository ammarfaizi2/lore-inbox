Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129040AbQKMLmC>; Mon, 13 Nov 2000 06:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129050AbQKMLlm>; Mon, 13 Nov 2000 06:41:42 -0500
Received: from proxy.ovh.net ([213.244.20.42]:9226 "HELO proxy.ovh.net")
	by vger.kernel.org with SMTP id <S129040AbQKMLlh>;
	Mon, 13 Nov 2000 06:41:37 -0500
Message-ID: <3A0FD365.A8F2BC02@ovh.net>
Date: Mon, 13 Nov 2000 12:41:25 +0100
From: octave klaba <oles@ovh.net>
X-Mailer: Mozilla 4.73 [en] (Win98; I)
X-Accept-Language: fr,en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: oops 2.2.17
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
we had a synflood attack and the memory was full. 
kernel tried to kill the process and it was done

[...]
VM: killing process httpd
VM: killing process inetd
VM: killing process inetd
VM: killing process httpd
[...]

but the server did not work any more. We tried to
reboot it and when init 6 was over we had 3 oops.

We have a 2.2.18pre + andrea's patch which have the
same synflood problem. dmesg writes
Unable to load interpreter /lib/ld-linux.so.2
Unable to load interpreter /lib/ld-linux.so.2
Unable to load interpreter /lib/ld-linux.so.2
Unable to load interpreter /lib/ld-linux.so.2
Unable to load interpreter /lib/ld-linux.so.2

Octave


Unmounting file systems Unable to handle kernel paging request at virtual
current->tss.cr3 = 19b70000, %cr3 = 19b70000
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c011fc4b>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010006
eax: 00000001   ebx: c01fb9c0   ecx: ffffffff   edx: 00000000
esi: 0001e6f5   edi: 0000f37a   ebp: 00000203   esp: ce9abeec
ds: 0018   es: 0018   ss: 0018
Process umount (pid: 10626, process nr: 110, stackpage=ce9ab000)
Stack: 00000000 00000000 ffffffff c011a504 d2903870 ce9abf68 00000822 00003007 
       d29038e8 d64d4338 d29038e8 c012eedb d2903870 00000000 da0ea888 c012ef51 
       d2903870 dfe7503c ce9abf68 00000000 c012f047 ce9abf68 dfe7503c dfe75000 
Call Trace: [<c011a504>] [<c012eedb>] [<c012ef51>] [<c012f047>] [<c01266be>]
[<c0126753>] [<c0126847>] 
       [<c01079bc>] 
Code: 0f bb 3a 19 c0 85 c0 74 3a ff 4b 0c 8b 44 24 10 f7 d8 31 f0 

>>EIP; c011fc4b <__free_pages+b7/120>   <=====
Trace; c011a504 <truncate_inode_pages+a4/13c>
Trace; c012eedb <clear_inode+13/70>
Trace; c012ef51 <dispose_list+19/50>
Trace; c012f047 <invalidate_inodes+3b/48>
Trace; c01266be <do_umount+ea/128>
Trace; c0126753 <umount_dev+57/a0>
Trace; c0126847 <sys_umount+ab/b8>
Trace; c01079bc <system_call+34/38>
Code;  c011fc4b <__free_pages+b7/120>
00000000 <_EIP>:
Code;  c011fc4b <__free_pages+b7/120>   <=====
   0:   0f bb 3a                  btc    %edi,(%edx)   <=====
Code;  c011fc4e <__free_pages+ba/120>
   3:   19 c0                     sbb    %eax,%eax
Code;  c011fc50 <__free_pages+bc/120>
   5:   85 c0                     test   %eax,%eax
Code;  c011fc52 <__free_pages+be/120>
   7:   74 3a                     je     43 <_EIP+0x43> c011fc8e <__free_pages+fa/120>
Code;  c011fc54 <__free_pages+c0/120>
   9:   ff 4b 0c                  decl   0xc(%ebx)
Code;  c011fc57 <__free_pages+c3/120>
   c:   8b 44 24 10               mov    0x10(%esp,1),%eax
Code;  c011fc5b <__free_pages+c7/120>
  10:   f7 d8                     neg    %eax
Code;  c011fc5d <__free_pages+c9/120>
  12:   31 f0                     xor    %esi,%eax

Unable to handle kernel paging request at virtual address 00001cfc
current->tss.cr3 = 00101000, %cr3 = 00101000
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c011fc4b>]
EFLAGS: 00010006
eax: 00000001   ebx: c01fb9c0   ecx: ffffffff   edx: 00000000
esi: 0001cfd3   edi: 0000e7e9   ebp: 00000203   esp: ce9abdc0
ds: 0018   es: 0018   ss: 0018
Process umount (pid: 10626, process nr: 110, stackpage=ce9ab000)
Stack: ce51f140 00000000 ffffffff c0120617 00000000 0004f000 c011851e dcfd3000 
       c3326620 0804f000 c1c1cd20 00001000 dcfd3000 00000000 00050000 d9b70080 
       00000000 08050000 d9b70080 c011a0be c1c1cd20 0804f000 00001000 c1c1cd20 
Call Trace: [<c0120617>] [<c011851e>] [<c011a0be>] [<c0110b9f>] [<c01153cb>]
[<c0107edb>] [<c0107ee0>] 
       [<c01ae116>] [<c01afb0e>] [<c010d140>] [<c01afb0e>] [<c0107acd>]
[<c011fc4b>] [<c011a504>] [<c012eedb>] 
       [<c012ef51>] [<c012f047>] [<c01266be>] [<c0126753>] [<c0126847>]
[<c01079bc>] 
Code: 0f bb 3a 19 c0 85 c0 74 3a ff 4b 0c 8b 44 24 10 f7 d8 31 f0 

>>EIP; c011fc4b <__free_pages+b7/120>   <=====
Trace; c0120617 <free_page_and_swap_cache+5f/64>
Trace; c011851e <zap_page_range+13e/1bc>
Trace; c011a0be <exit_mmap+ae/108>
Trace; c0110b9f <mmput+1b/34>
Trace; c01153cb <do_exit+b3/26c>
Trace; c0107edb <die+33/38>
Trace; c0107ee0 <die_if_no_fixup+0/40>
Trace; c01ae116 <stext_lock+11a6/2cb0>
Trace; c01afb0e <stext_lock+2b9e/2cb0>
Trace; c010d140 <do_page_fault+2c4/3b0>
Trace; c01afb0e <stext_lock+2b9e/2cb0>
Trace; c0107acd <error_code+2d/34>
Trace; c011fc4b <__free_pages+b7/120>
Trace; c011a504 <truncate_inode_pages+a4/13c>
Trace; c012eedb <clear_inode+13/70>
Trace; c012ef51 <dispose_list+19/50>
Trace; c012f047 <invalidate_inodes+3b/48>
Trace; c01266be <do_umount+ea/128>
Trace; c0126753 <umount_dev+57/a0>
Trace; c0126847 <sys_umount+ab/b8>
Trace; c01079bc <system_call+34/38>
Code;  c011fc4b <__free_pages+b7/120>
00000000 <_EIP>:
Code;  c011fc4b <__free_pages+b7/120>   <=====
   0:   0f bb 3a                  btc    %edi,(%edx)   <=====
Code;  c011fc4e <__free_pages+ba/120>
   3:   19 c0                     sbb    %eax,%eax
Code;  c011fc50 <__free_pages+bc/120>
   5:   85 c0                     test   %eax,%eax
Code;  c011fc52 <__free_pages+be/120>
   7:   74 3a                     je     43 <_EIP+0x43> c011fc8e <__free_pages+fa/120>
Code;  c011fc54 <__free_pages+c0/120>
   9:   ff 4b 0c                  decl   0xc(%ebx)
Code;  c011fc57 <__free_pages+c3/120>
   c:   8b 44 24 10               mov    0x10(%esp,1),%eax
Code;  c011fc5b <__free_pages+c7/120>
  10:   f7 d8                     neg    %eax
Code;  c011fc5d <__free_pages+c9/120>
  12:   31 f0                     xor    %esi,%eax

Unable to handle kernel NULL pointer dereference at virtual address 00000150
current->tss.cr3 = 1fe51000, %cr3 = 1fe51000
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c011fc4b>]
EFLAGS: 00010006
eax: 00000001   ebx: c01fb9c0   ecx: ffffffff   edx: 00000000
esi: 0000153a   edi: 00000a9d   ebp: 00000202   esp: dffebf0c
ds: 0018   es: 0018   ss: 0018
Process init (pid: 1, process nr: 1, stackpage=dffeb000)
Stack: 00000000 00000287 ffffffff c011fcd8 c012be2b 00000000 00000400 c153a000 
       00000000 c012c13d c153a000 d74fb874 0000000b d74fb878 0000002a 00000104 
       0000000b dffea000 00000000 00000000 c153a000 c012c54a 0000000b dffebfa8 
Call Trace: [<c011fcd8>] [<c012be2b>] [<c012c13d>] [<c012c54a>] [<c01079bc>] 
Code: 0f bb 3a 19 c0 85 c0 74 3a ff 4b 0c 8b 44 24 10 f7 d8 31 f0 

>>EIP; c011fc4b <__free_pages+b7/120>   <=====
Trace; c011fcd8 <free_pages+24/28>
Trace; c012be2b <free_wait+63/6c>
Trace; c012c13d <do_select+1ed/204>
Trace; c012c54a <sys_select+3f6/550>
Trace; c01079bc <system_call+34/38>
Code;  c011fc4b <__free_pages+b7/120>
00000000 <_EIP>:
Code;  c011fc4b <__free_pages+b7/120>   <=====
   0:   0f bb 3a                  btc    %edi,(%edx)   <=====
Code;  c011fc4e <__free_pages+ba/120>
   3:   19 c0                     sbb    %eax,%eax
Code;  c011fc50 <__free_pages+bc/120>
   5:   85 c0                     test   %eax,%eax
Code;  c011fc52 <__free_pages+be/120>
   7:   74 3a                     je     43 <_EIP+0x43> c011fc8e <__free_pages+fa/120>
Code;  c011fc54 <__free_pages+c0/120>
   9:   ff 4b 0c                  decl   0xc(%ebx)
Code;  c011fc57 <__free_pages+c3/120>
   c:   8b 44 24 10               mov    0x10(%esp,1),%eax
Code;  c011fc5b <__free_pages+c7/120>
  10:   f7 d8                     neg    %eax
Code;  c011fc5d <__free_pages+c9/120>
  12:   31 f0                     xor    %esi,%eax

Unable to handle kernel paging request at virtual address 00001b14
current->tss.cr3 = 00101000, %cr3 = 00101000
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c011fc4b>]
EFLAGS: 00010006
eax: 00000001   ebx: c01fb9c0   ecx: ffffffff   edx: 00000000
esi: 0001b17d   edi: 0000d8be   ebp: 00000207   esp: dffebde0
ds: 0018   es: 0018   ss: 0018
Process init (pid: 1, process nr: 1, stackpage=dffeb000)
Stack: dfe3b13c 00000000 ffffffff c0120617 00000001 0004e000 c011851e db17d000 
       dfe500a0 0804e000 dfe52060 00002000 db17d000 00000000 00050000 dfe51080 
       00000000 08050000 dfe51080 c011a0be dfe52060 0804e000 00002000 dfe52060 
Call Trace: [<c0120617>] [<c011851e>] [<c011a0be>] [<c0110b9f>] [<c01153cb>]
[<c0107edb>] [<c0107ee0>] 
       [<c01ae116>] [<c01afb0e>] [<c010d140>] [<c01afb0e>] [<c0107acd>]
[<c011fc4b>] [<c011fcd8>] [<c012be2b>] 
       [<c012c13d>] [<c012c54a>] [<c01079bc>] 
Code: 0f bb 3a 19 c0 85 c0 74 3a ff 4b 0c 8b 44 24 10 f7 d8 31 f0 

>>EIP; c011fc4b <__free_pages+b7/120>   <=====
Trace; c0120617 <free_page_and_swap_cache+5f/64>
Trace; c011851e <zap_page_range+13e/1bc>
Trace; c011a0be <exit_mmap+ae/108>
Trace; c0110b9f <mmput+1b/34>
Trace; c01153cb <do_exit+b3/26c>
Trace; c0107edb <die+33/38>
Trace; c0107ee0 <die_if_no_fixup+0/40>
Trace; c01ae116 <stext_lock+11a6/2cb0>
Trace; c01afb0e <stext_lock+2b9e/2cb0>
Trace; c010d140 <do_page_fault+2c4/3b0>
Trace; c01afb0e <stext_lock+2b9e/2cb0>
Trace; c0107acd <error_code+2d/34>
Trace; c011fc4b <__free_pages+b7/120>
Trace; c011fcd8 <free_pages+24/28>
Trace; c012be2b <free_wait+63/6c>
Trace; c012c13d <do_select+1ed/204>
Trace; c012c54a <sys_select+3f6/550>
Trace; c01079bc <system_call+34/38>
Code;  c011fc4b <__free_pages+b7/120>
00000000 <_EIP>:
Code;  c011fc4b <__free_pages+b7/120>   <=====
   0:   0f bb 3a                  btc    %edi,(%edx)   <=====
Code;  c011fc4e <__free_pages+ba/120>
   3:   19 c0                     sbb    %eax,%eax
Code;  c011fc50 <__free_pages+bc/120>
   5:   85 c0                     test   %eax,%eax
Code;  c011fc52 <__free_pages+be/120>
   7:   74 3a                     je     43 <_EIP+0x43> c011fc8e <__free_pages+fa/120>
Code;  c011fc54 <__free_pages+c0/120>
   9:   ff 4b 0c                  decl   0xc(%ebx)
Code;  c011fc57 <__free_pages+c3/120>
   c:   8b 44 24 10               mov    0x10(%esp,1),%eax
Code;  c011fc5b <__free_pages+c7/120>
  10:   f7 d8                     neg    %eax
Code;  c011fc5d <__free_pages+c9/120>
  12:   31 f0                     xor    %esi,%eax


3 warnings issued.  Results may not be reliable.

Amicalement,
oCtAvE 

"Peu importe ce qu'il y a de l'autre côté.
Tout ce qu'on laisse ici n'est qu'une histoire
dont on se souviendra ou pas."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
