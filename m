Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274951AbRJTXME>; Sat, 20 Oct 2001 19:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274990AbRJTXLz>; Sat, 20 Oct 2001 19:11:55 -0400
Received: from cs.wustl.edu ([128.252.165.15]:21962 "EHLO
	taumsauk.cs.wustl.edu") by vger.kernel.org with ESMTP
	id <S274951AbRJTXLd>; Sat, 20 Oct 2001 19:11:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15314.1146.502104.106511@samba.doc.wustl.edu>
Date: Sat, 20 Oct 2001 18:10:50 -0500
From: Krishnakumar B <kitty@cs.wustl.edu>
To: linux-kernel@vger.kernel.org
Subject: kswapd dies again (this time with linux-2.4.12-ac3)
X-Mailer: VM 6.96 under 21.4 (patch 4) "Artificial Intelligence" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I posted a message a while ago about kswapd becoming a zombie. I saw that
this was the case again today. I also noticed messages like these before
the oops:

VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...
nfs: server mail.cs.wustl.edu OK
nfs: server cs OK
nfs: server cs OK
VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...

Does this have something to do with NFS ? I have set a timeout of 60
seconds on the NFS mounted directories. So I am guessing that the Oops
occurs when a remote directory is unmounted.

Please Cc: me on replies as I am not subscribed to the list.

-kitty.



samba> ksymoops -v /u/scratch/downloads/kernel/linux-2.4.12-ac3/vmlinux -m /boot
/System.map oops.txt 
ksymoops 2.4.3 on i686 2.4.12-ac3.  Options used
     -v /u/scratch/downloads/kernel/linux-2.4.12-ac3/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.12-ac3/ (default)
     -m /boot/System.map (specified)

 WARNING: unexpected IO-APIC, please mail
cpu: 0, clocks: 1329979, slice: 443326
cpu: 1, clocks: 1329979, slice: 443326
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
ac97_codec: AC97  codec, id: 0x5452:0x4123 (TriTech TR?????)
Unable to handle kernel paging request at virtual address 0005006b
c014a7ec
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c014a7ec>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 0005003b   ebx: da467740   ecx: da467748   edx: dfe6ff94
esi: da467740   edi: c0234610   ebp: dfe6ffa8   esp: dfe6ff5c
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 6, stackpage=dfe6f000)
Stack: dfe6ff94 c0234610 c0149bfb dff9c470 da467740 dfe6ff94 c014a880 da467740 
       c60fc3c8 c60fc3c0 c014aaf4 dfe6ff94 00000000 000027eb dec67ac8 cfef5e48 
       00007224 000000c0 000000c0 0008e000 c014ab51 ffffd815 c012fd03 00000000 
Call Trace: [<c0149bfb>] [<c014a880>] [<c014aaf4>] [<c014ab51>] [<c012fd03>] 
   [<c012fd97>] [<c0105000>] [<c0105616>] [<c012fd30>] 
Code: 8b 40 30 85 c0 74 04 56 ff d0 58 8b 9e 04 01 00 00 85 db 74 

>>EIP; c014a7ec <clear_inode+bc/110>   <=====
Trace; c0149bfa <destroy_inode+1a/20>
Trace; c014a880 <dispose_list+40/60>
Trace; c014aaf4 <prune_icache+d4/110>
Trace; c014ab50 <shrink_icache_memory+20/40>
Trace; c012fd02 <do_try_to_free_pages+22/50>
Trace; c012fd96 <kswapd+66/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0105616 <kernel_thread+26/30>
Trace; c012fd30 <kswapd+0/c0>
Code;  c014a7ec <clear_inode+bc/110>
00000000 <_EIP>:
Code;  c014a7ec <clear_inode+bc/110>   <=====
   0:   8b 40 30                  mov    0x30(%eax),%eax   <=====
Code;  c014a7ee <clear_inode+be/110>
   3:   85 c0                     test   %eax,%eax
Code;  c014a7f0 <clear_inode+c0/110>
   5:   74 04                     je     b <_EIP+0xb> c014a7f6 <clear_inode+c6/110>
Code;  c014a7f2 <clear_inode+c2/110>
   7:   56                        push   %esi
Code;  c014a7f4 <clear_inode+c4/110>
   8:   ff d0                     call   *%eax
Code;  c014a7f6 <clear_inode+c6/110>
   a:   58                        pop    %eax
Code;  c014a7f6 <clear_inode+c6/110>
   b:   8b 9e 04 01 00 00         mov    0x104(%esi),%ebx
Code;  c014a7fc <clear_inode+cc/110>
  11:   85 db                     test   %ebx,%ebx
Code;  c014a7fe <clear_inode+ce/110>
  13:   74 00                     je     15 <_EIP+0x15> c014a800 <clear_inode+d0/110>


Other info:

samba> scripts/ver_linux 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux samba 2.4.12-ac3 #6 SMP Wed Oct 17 23:40:15 CDT 2001 i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11f
mount                  2.11f
modutils               2.4.6
e2fsprogs              1.23
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         loop emu10k1 sound ac97_codec soundcore nfs lockd sunrpc autofs4 3c59x ipchains mousedev hid input uhci usbcore


samba> uname -a
Linux samba 2.4.12-ac3 #6 SMP Wed Oct 17 23:40:15 CDT 2001 i686 unknown

samba> cat /proc/mounts 
/dev/root / ext3 rw 0 0
/proc /proc proc rw 0 0
usbdevfs /proc/bus/usb usbdevfs rw 0 0
/dev/hda1 /boot ext2 rw 0 0
/dev/hda7 /build ext3 rw 0 0
/dev/hdb1 /u ext3 rw 0 0
none /dev/pts devpts rw 0 0
tmpfs /dev/shm tmpfs rw 0 0
automount(pid750) /misc autofs rw 0 0
automount(pid794) /pkg autofs rw 0 0
automount(pid769) /net autofs rw 0 0
automount(pid830) /- autofs rw 0 0
automount(pid854) /home autofs rw 0 0
automount(pid898) /project autofs rw 0 0
automount(pid923) /apt1 autofs rw 0 0
automount(pid945) /apt2 autofs rw 0 0
cs:/export/apt1 /apt1/cs nfs rw,nosuid,v3,rsize=32768,wsize=32768,hard,intr,udp,lock,addr=cs 0 0
mail.cs.wustl.edu:/export/mail /net/mail nfs rw,sync,nosuid,v3,rsize=32768,wsize=32768,acregmin=0,acregmax=0,acdirmin=0,acdirmax=0,hard,intr,udp,noac,lock,addr=mail.cs.wustl.edu 0 0
nfs.cs.wustl.edu:/export/home /home/cs nfs rw,nosuid,v3,rsize=32768,wsize=32768,hard,intr,udp,lock,addr=nfs.cs.wustl.edu 0 0

-- 
Krishnakumar B <kitty at cs dot wustl dot edu>
Distributed Object Computing Laboratory, Washington University in St.Louis
