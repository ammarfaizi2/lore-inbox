Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262034AbSI3MI0>; Mon, 30 Sep 2002 08:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262035AbSI3MI0>; Mon, 30 Sep 2002 08:08:26 -0400
Received: from gusi.leathercollection.ph ([202.163.192.10]:18059 "EHLO
	gusi.leathercollection.ph") by vger.kernel.org with ESMTP
	id <S262034AbSI3MIW>; Mon, 30 Sep 2002 08:08:22 -0400
Date: Mon, 30 Sep 2002 20:13:24 +0800
From: Federico Sevilla III <jijo@free.net.ph>
To: Linux-XFS Mailing List <linux-xfs@oss.sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: kernel panic "killing interrupt handler" and kernel BUG at sched.c:468
Message-ID: <20020930121323.GA7250@leathercollection.ph>
Mail-Followup-To: Linux-XFS Mailing List <linux-xfs@oss.sgi.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Organization: The Leather Collection, Inc.
X-Organization-URL: http://www.leathercollection.ph
X-Personal-URL: http://jijo.free.net.ph
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CdrF4e02JqNVZeln
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi everyone,

On our server that had been running for 55 days with this 2.4.19-xfs
kernel (XFS CVS snapshot 20020809 patched with RML's preempt patches for
2.4.19-rc3 and sys-magic 20020314 from Randy Dunlap, built using GCC
3.1.1 running Debian GNU/Linux), I hit a kernel panic in the process
running the distributed-net client.  I had been running the
distributed-net client -- and everything else on the server -- with no
significant changes recently. The server wasn't under any significantly
different load, either.

I copied the oops by hand onto another computer and am attaching a
ksymoops output of that as kernel-panic.out. I rebooted and a few
minutes after all the initialization had completed I hit another kernel
panic, again because of the distributed-net client process. The oops
(passed through ksymoops) is attached as kernel-panic-2.out.

After copying the oops message, I attempted to sync the disks using the
(Alt + SysRq + S) key combination and after the sync messages I hit a
kernel BUG at sched.c:568. In my sched.c (different from the XFS tree
only because of RML's preempt patch) line 568 is in the "asmlinkage void
schedule(void)" function. The oops (passed through ksymoops) is attached
as kernel-bug.out.

Some other notes that may be significant to mention:

    - system is an Intel Pentium III with 512MB RAM and a 3ware 6400 IDE
      RAID controller,
    - system has one small ext2 partition for /boot, one ReiserFS
      partition for Squid cache, and 5 XFS partitions,
    - system is an NFS server, with NFSv3 enabled in the kernel and
      running nfs-kernel-server 1.0.2,
    - system is not exclusively an NFS server, it's a Samba, mail, IRC
      server as well, and runs lm-sensors,
    - this happened during a lull in the load because everyone was on
      their way home at the end of our work day.

I am recompiling the kernel now, using a current CVS snapshot of the XFS
tree, and using Debian Sid's current default gcc (2.95.4 20011002)
instead of gcc 3.1.1 like before, and without RML's preempt patch (the
SysMagic patch does not touch sched.c and probably didn't have anything
to do with this). I turned off distributed-net as soon as I rebooted
this third time, and the system's alive so far and was able to recompile
the kernel. I will turn it back on when I boot with the new kernel and
will send a follow-up if the kernel panics again.

Pointers as to what probably caused this are welcome. If this is a "new"
issue I hope the decoded oops messages will be help. Thank you everyone
for your time.

 --> Jijo

--=20
Federico Sevilla III   :  http://jijo.free.net.ph
Network Administrator  :  The Leather Collection, Inc.
GnuPG Key ID           :  0x93B746BE

--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kernel-bug.out"
Content-Transfer-Encoding: quoted-printable

ksymoops 2.4.6 on i686 2.4.19-xfs.  Options used
     -V (specified)
     -k /proc/ksyms (specified)
     -l /proc/modules (specified)
     -o /lib/modules/2.4.19-xfs/ (specified)
     -m /boot/System.map-2.4.19-xfs (specified)

kernel BUG at sched.c:568!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c011b96a>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000018   ebx: 00000004   ecx: dcfda000   edx: 00000001
esi: db41c000   edi: ce9d0d28   ebp: db41dce0   esp: db41dcb8
ds: 0018   es: 0018   ss: 0018
Process distributed-net (pid: 598, stackpage=3Ddb41d000)
Stack: c0338daa dd287dc0 df2e5600 00000292 db41c000 00000000 00000001 ce9d0=
ce0
       db41c000 ce9d0d28 db41dcec c01428cd 00000000 00000000 db41c000 dd00d=
d18
       ce9d0d28 ce9d0ce0 ce9d0ce0 00000000 00000808 c0142c07 ce9d0ce0 db41c=
000
Call Trace:    [<c01428cd>] [<c0142c07>] [<c0142c43>] [<c0142cca>] [<c0142e=
42>]
  [<0c25f77b>] [<c025f87d>] [<c011e823>] [<c0122597>] [<c011a980>] [<c01098=
56>]
  [<c011ac44>] [<c0246afd>] [<c02bdc99>] [<c02476b2>] [<c02493ed>] [<c02480=
ff>]
  [<c011a980>] [<c01092bc>] [<c02bc5ea>] [<c0246976>] [<c02bc971>] [<c02bcf=
16>]
  [<c02bcff1>] [<c010a755>] [<c010a99f>] [<c010d273>]
Code: 0f 0b 38 02 a2 8d 33 c0 e9 6f fc ff ff 0f 0b 31 02 a2 8d 33


>>EIP; c011b96a <schedule+3ea/410>   <=3D=3D=3D=3D=3D

>>ecx; dcfda000 <_end+1cbcdc7c/2049dcdc>
>>esi; db41c000 <_end+1b00fc7c/2049dcdc>
>>edi; ce9d0d28 <_end+e5c49a4/2049dcdc>
>>ebp; db41dce0 <_end+1b01195c/2049dcdc>
>>esp; db41dcb8 <_end+1b011934/2049dcdc>

Trace; c01428cd <__wait_on_buffer+6d/a0>
Trace; c0142c07 <wait_for_buffers+c7/d0>
Trace; c0142c43 <wait_for_locked_buffers+33/50>
Trace; c0142cca <sync_buffers+6a/70>
Trace; c0142e42 <fsync_dev+62/a0>
Trace; 0c25f77b Before first symbol
Trace; c025f87d <do_emergency_sync+fd/120>
Trace; c011e823 <panic+103/130>
Trace; c0122597 <do_exit+257/260>
Trace; c011a980 <do_page_fault+0/500>
Trace; c0109856 <die+86/90>
Trace; c011ac44 <do_page_fault+2c4/500>
Trace; c0246afd <tty_default_put_char+2d/40>
Trace; c02bdc99 <serial_write_room+29/f0>
Trace; c02476b2 <opost+22/1b0>
Trace; c02493ed <n_tty_receive_char+13d/6a0>
Trace; c02480ff <n_tty_receive_buf+17f/4b0>
Trace; c011a980 <do_page_fault+0/500>
Trace; c01092bc <error_code+34/40>
Trace; c02bc5ea <process_transfer+4a/310>
Trace; c0246976 <tty_flip_buffer_push+36/40>
Trace; c02bc971 <process_interrupt+c1/270>
Trace; c02bcf16 <process_urb+286/2c0>
Trace; c02bcff1 <uhci_interrupt+a1/1a0>
Trace; c010a755 <handle_IRQ_event+45/70>
Trace; c010a99f <do_IRQ+8f/f0>
Trace; c010d273 <call_do_IRQ+5/a>

Code;  c011b96a <schedule+3ea/410>
00000000 <_EIP>:
Code;  c011b96a <schedule+3ea/410>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c011b96c <schedule+3ec/410>
   2:   38 02                     cmp    %al,(%edx)
Code;  c011b96e <schedule+3ee/410>
   4:   a2 8d 33 c0 e9            mov    %al,0xe9c0338d
Code;  c011b973 <schedule+3f3/410>
   9:   6f                        outsl  %ds:(%esi),(%dx)
Code;  c011b974 <schedule+3f4/410>
   a:   fc                        cld   =20
Code;  c011b975 <schedule+3f5/410>
   b:   ff                        (bad) =20
Code;  c011b976 <schedule+3f6/410>
   c:   ff 0f                     decl   (%edi)
Code;  c011b978 <schedule+3f8/410>
   e:   0b 31                     or     (%ecx),%esi
Code;  c011b97a <schedule+3fa/410>
  10:   02 a2 8d 33 00 00         add    0x338d(%edx),%ah

 <0>Kernel panic: Aiee, killing interrupt handler!

--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kernel-panic.out"
Content-Transfer-Encoding: quoted-printable

ksymoops 2.4.6 on i686 2.4.19-xfs.  Options used
     -V (specified)
     -k /proc/ksyms (specified)
     -l /proc/modules (specified)
     -o /lib/modules/2.4.19-xfs/ (specified)
     -m /boot/System.map-2.4.19-xfs (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000028
c02bc5ea
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<C02BC5EA>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000001   ebx: dfcce3e0   ecx: dfcce3c0   edx: 00000000
esi: dfcce380   edi: c0010200   ebp: dfcce3a8   esp: d1899ee4
ds: 0018   es: 0018   ss: 0018
Process distributed-net (pid: 22272, stackpage=3Dd1899000)
Stack: 00000008 c0246976 c354f130 c037e504 dfcce3c0 c15db660 dfcce3a0 dfcce=
3c0
       dfcce380 c64f51e0 00000000 c15db67c c15db660 c15db660 dfc285a0 c02bc=
f16
       c15db660 dfc285a0 00000001 d1898000 d328a000 d1899f48 00000000 c15db=
67c
Call Trace:    [<c0246979>] [<c02bcf16>] [<c02bcff1>] [<c010a755>] [<c010a9=
9f>]
  [<c010d273>]
Code: 8b 44 82 24 89 f9 c7 44 24 14 00 00 00 00 c1 e9 0f 83 e1 0f


>>EIP; c02bc5ea <process_transfer+4a/310>   <=3D=3D=3D=3D=3D

>>ebx; dfcce3e0 <_end+1f8c205c/2049dcdc>
>>ecx; dfcce3c0 <_end+1f8c203c/2049dcdc>
>>esi; dfcce380 <_end+1f8c1ffc/2049dcdc>
>>ebp; dfcce3a8 <_end+1f8c2024/2049dcdc>
>>esp; d1899ee4 <_end+1148db60/2049dcdc>

Trace; c0246979 <tty_flip_buffer_push+39/40>
Trace; c02bcf16 <process_urb+286/2c0>
Trace; c02bcff1 <uhci_interrupt+a1/1a0>
Trace; c010a755 <handle_IRQ_event+45/70>
Trace; c010a99f <do_IRQ+8f/f0>
Trace; c010d273 <call_do_IRQ+5/a>

Code;  c02bc5ea <process_transfer+4a/310>
00000000 <_EIP>:
Code;  c02bc5ea <process_transfer+4a/310>   <=3D=3D=3D=3D=3D
   0:   8b 44 82 24               mov    0x24(%edx,%eax,4),%eax   <=3D=3D=
=3D=3D=3D
Code;  c02bc5ee <process_transfer+4e/310>
   4:   89 f9                     mov    %edi,%ecx
Code;  c02bc5f0 <process_transfer+50/310>
   6:   c7 44 24 14 00 00 00      movl   $0x0,0x14(%esp,1)
Code;  c02bc5f7 <process_transfer+57/310>
   d:   00=20
Code;  c02bc5f8 <process_transfer+58/310>
   e:   c1 e9 0f                  shr    $0xf,%ecx
Code;  c02bc5fb <process_transfer+5b/310>
  11:   83 e1 0f                  and    $0xf,%ecx

 <0>Kernel panic: Aiee, killing interrupt handler!

--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kernel-panic-2.out"
Content-Transfer-Encoding: quoted-printable

ksymoops 2.4.6 on i686 2.4.19-xfs.  Options used
     -V (specified)
     -k /proc/ksyms (specified)
     -l /proc/modules (specified)
     -o /lib/modules/2.4.19-xfs/ (specified)
     -m /boot/System.map-2.4.19-xfs (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000028
c02bc5ea
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c02bc5ea>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000001   ebx: dfcce3e0   ecx: dfcce3c0   edx: 00000000
esi: dfcce380   edi: c0010200   ebp: dfcce3a8   esp: d1899ee4
ds: 0018   es: 0018   ss: 0018
Process distributed-net (pid: 598, stackpage=3Ddb41d000)
Stack: 00000005 c0246976 d935c130 c037e504 c02bc971 d935c000 dfc285a0 dfcce=
3c0
       dfcce380 dfc1a1a0 00000000 c15db67c c15db660 c15db660 dfc28420 c02bc=
f16
       c15db660 dfc28420 00000001 db41c000 d5c1c000 db41df48 00000000 c15db=
67c
Call Trace:    [<c0246976>] [<c02bc971>] [<c02bcf16>] [<c02bcff1>] [<c010a7=
55>]
  [<c010a99f>] [<c010d273>]
Code: 8b 44 82 24 89 f9 c7 44 24 14 00 00 00 00 c1 e9 0f 83 e1 0f


>>EIP; c02bc5ea <process_transfer+4a/310>   <=3D=3D=3D=3D=3D

>>ebx; dfcce3e0 <_end+1f8c205c/2049dcdc>
>>ecx; dfcce3c0 <_end+1f8c203c/2049dcdc>
>>esi; dfcce380 <_end+1f8c1ffc/2049dcdc>
>>ebp; dfcce3a8 <_end+1f8c2024/2049dcdc>
>>esp; d1899ee4 <_end+1148db60/2049dcdc>

Trace; c0246976 <tty_flip_buffer_push+36/40>
Trace; c02bc971 <process_interrupt+c1/270>
Trace; c02bcf16 <process_urb+286/2c0>
Trace; c02bcff1 <uhci_interrupt+a1/1a0>
Trace; c010a755 <handle_IRQ_event+45/70>
Trace; c010a99f <do_IRQ+8f/f0>
Trace; c010d273 <call_do_IRQ+5/a>

Code;  c02bc5ea <process_transfer+4a/310>
00000000 <_EIP>:
Code;  c02bc5ea <process_transfer+4a/310>   <=3D=3D=3D=3D=3D
   0:   8b 44 82 24               mov    0x24(%edx,%eax,4),%eax   <=3D=3D=
=3D=3D=3D
Code;  c02bc5ee <process_transfer+4e/310>
   4:   89 f9                     mov    %edi,%ecx
Code;  c02bc5f0 <process_transfer+50/310>
   6:   c7 44 24 14 00 00 00      movl   $0x0,0x14(%esp,1)
Code;  c02bc5f7 <process_transfer+57/310>
   d:   00=20
Code;  c02bc5f8 <process_transfer+58/310>
   e:   c1 e9 0f                  shr    $0xf,%ecx
Code;  c02bc5fb <process_transfer+5b/310>
  11:   83 e1 0f                  and    $0xf,%ecx

 <0>Kernel panic: Aiee, killing interrupt handler!

--M9NhX3UHpAaciwkO--

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9mD/j5rCBSJO3Rr4RAn0pAJ937zwgt7TGpIa3OYinqXNLHLDpMgCfZpcN
Bgh+ibOJComFFjGMY1D2B7A=
=Svc2
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
