Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275042AbRJQI3m>; Wed, 17 Oct 2001 04:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274990AbRJQI3d>; Wed, 17 Oct 2001 04:29:33 -0400
Received: from mumm.ibr.cs.tu-bs.de ([134.169.34.33]:20412 "EHLO
	mumm.ibr.cs.tu-bs.de") by vger.kernel.org with ESMTP
	id <S275042AbRJQI3R>; Wed, 17 Oct 2001 04:29:17 -0400
To: linux-kernel@vger.kernel.org
Subject: Fwd: 2.2.14-ac1: Oops when accessing directory via nfs
From: Joerg Diederich <dieder@ibr.cs.tu-bs.de>
Date: 17 Oct 2001 10:29:49 +0200
Message-ID: <yj8zo6qr7nm.fsf@zwickel.ibr.cs.tu-bs.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

Additionally, I ran the Oops through ksymoops with the following result:


ksymoops 2.4.3 on i686 2.4.12-ac1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.12-ac1/ (default)
     -m /boot/System.map-2.4.12-ac1 (specified)

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c01cdd30, System.map says c0151230.  Ignoring ksyms_base entry
Oct 15 23:32:32 agitator kernel: c01604fc
Oct 15 23:32:32 agitator kernel: Oops: 0000
Oct 15 23:32:32 agitator kernel: CPU:    0
Oct 15 23:32:32 agitator kernel: EIP:    0010:[nfs_xdr_readdirres+172/224]    No
Oct 15 23:32:32 agitator kernel: EFLAGS: 00010296
Oct 15 23:32:32 agitator kernel: eax: 01000000   ebx: fe203ff8   ecx: fe204000  
Oct 15 23:32:32 agitator kernel: esi: fe204000   edi: 00000080   ebp: e64ba144  
Oct 15 23:32:32 agitator kernel: ds: 0018   es: 0018   ss: 0018
Oct 15 23:32:32 agitator kernel: Process apache (pid: 23179, stackpage=db32b000)
Oct 15 23:32:32 agitator kernel: Stack: db32bcf8 f1486a54 c0160450 c022b097 e64b
a144 c3de8240 db32bda0 db32bd4c 
Oct 15 23:32:32 agitator kernel:        db32bcb8 db32bd60 db32bcf8 c022e01c db32
bcf8 db32bcf8 fffffff5 db32bcf8 
Oct 15 23:32:32 agitator kernel:        f1486a54 db32a000 00000000 db32a000 db32
bd64 db32bd64 c022e287 db32bcf8 
Oct 15 23:32:32 agitator kernel: Call Trace: [nfs_xdr_readdirres+0/224] [call_de
Oct 15 23:32:32 agitator kernel: Code: 8b 11 0f ca 8d 42 03 24 fc 8d 4c 01 08 81
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 11                     mov    (%ecx),%edx
Code;  00000002 Before first symbol
   2:   0f ca                     bswap  %edx
Code;  00000004 Before first symbol
   4:   8d 42 03                  lea    0x3(%edx),%eax
Code;  00000006 Before first symbol
   7:   24 fc                     and    $0xfc,%al
Code;  00000008 Before first symbol
   9:   8d 4c 01 08               lea    0x8(%ecx,%eax,1),%ecx
Code;  0000000c Before first symbol
   d:   81 00 00 00 00 00         addl   $0x0,(%eax)


1 warning issued.  Results may not be reliable.


------- Start of forwarded message -------
From: Joerg Diederich <dieder@ibr.cs.tu-bs.de>
Newsgroups: ibr.mailinglists.linux-kernel
Subject: 2.2.14-ac1: Oops when accessing directory via nfs
Date: 17 Oct 2001 10:13:52 +0200
Organization: <unknown>
Message-ID: <200110170805.f9H85Nv08971@zwickel.ibr.cs.tu-bs.de>
To: linux-kernel@vger.kernel.org

Hi!

we get an 100%-ile reproducible Oops when accessing a certain
directory via nfs. 

NFS client: Athlon 1400, 2x 60 GB HDD (RAID 1, lvm), kernel 2.4.12-ac1

NFS server: DEC System 5000 Modell 200, Ultrix 4.4

Before the nfs client machine 'oopses', there is always the message

NFS: short packet in readdir reply!

in the syslog (mostly 3 times) and sometimes even the message:

 NFS: giant filename in readdir 

with varying 'len'. 


With Redhat-kernel 2.2.19-6.2.7 as NFS client, there is still the same
'short packet' message in the log, but no 'giant'-message and there is
no Oops and the directory is shown correctly.

One Oops message from the syslog is attached (they all look similar).

I can provide more information if necessary (e.g., mounting the
directory via nfs to other test machines is possible. Please, contact
me if this is necessary to track down the problem).

A fsck on the nfs server did not encounter any problems with the
filesystem.


Best regards,

/J"org
----
J"org Diederich
Institute of Operating Systems and Computer Networks, 
Technical University Braunschweig, Germany
Email: dieder@ibr.cs.tu-bs.de


--------------------

 kernel:  printing eip:
 kernel: c01604fc
 kernel: Oops: 0000
 kernel: CPU:    0
 kernel: EIP:    0010:[nfs_xdr_readdirres+172/224]    No
t tainted
 kernel: EFLAGS: 00010296
 kernel: eax: 01000000   ebx: fe203ff8   ecx: fe204000  
 edx: 0000000e
 kernel: esi: fe204000   edi: 00000080   ebp: e64ba144  
 esp: db32bc70
 kernel: ds: 0018   es: 0018   ss: 0018
 kernel: Process apache (pid: 23179, stackpage=db32b000)
 kernel: Stack: db32bcf8 f1486a54 c0160450 c022b097 e64b
a144 c3de8240 db32bda0 db32bd4c 
 kernel:        db32bcb8 db32bd60 db32bcf8 c022e01c db32
bcf8 db32bcf8 fffffff5 db32bcf8 
 kernel:        f1486a54 db32a000 00000000 db32a000 db32
bd64 db32bd64 c022e287 db32bcf8 
 kernel: Call Trace: [nfs_xdr_readdirres+0/224] [call_de
code+295/352] [__rpc_execute+172/704] [rpc_execute+87/112] [rpc_call_sync+125/17
6] 
 kernel:    [rpc_run_timer+0/96] [nfs_proc_readdir+161/2
08] [nfs_readdir_filler+240/592] [read_cache_page+133/400] [filldir64+0/368] [nf
s_readdir+253/1296] 
 kernel:    [nfs_readdir_filler+0/592] [nfs_decode_diren
t+0/144] [vfs_readdir+97/144] [filldir64+0/368] [sys_getdents64+79/272] [filldir
64+0/368] 
 kernel:    [system_call+51/56] 
 kernel: 
 kernel: Code: 8b 11 0f ca 8d 42 03 24 fc 8d 4c 01 08 81
 fa ff 00 00 00 77 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
------- End of forwarded message -------
