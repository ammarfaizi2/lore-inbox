Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319772AbSIMUOn>; Fri, 13 Sep 2002 16:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319773AbSIMUOn>; Fri, 13 Sep 2002 16:14:43 -0400
Received: from mail.cs.nmsu.edu ([128.123.64.3]:62703 "EHLO mail.cs.nmsu.edu")
	by vger.kernel.org with ESMTP id <S319772AbSIMUOk>;
	Fri, 13 Sep 2002 16:14:40 -0400
Date: Fri, 13 Sep 2002 14:19:09 -0600 (MDT)
From: Joel Votaw <jovotaw@cs.nmsu.edu>
X-X-Sender: jovotaw@quito
To: Urban Widmark <urban@teststation.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Oops, maybe smbfs on SMP system?  Kernel is RedHat's 2.4.18-10smp
In-Reply-To: <Pine.LNX.4.44.0209130007040.20947-100000@cola.enlightnet.local>
Message-ID: <Pine.LNX.4.44.0209130926290.2841-100000@quito>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Sep 2002, Urban Widmark wrote:

> On Thu, 12 Sep 2002, Joel Votaw wrote:
>
> > smb_retry: no connection process
>
> This means that your smbmount process has terminated (crashed?). You could
> try some things with that, eg upgrading samba to the latest 2.2.x, running
> it with a higher debug level (4, check your smbmount.log), add more debug
> printouts to the smbmount main loop, getting a core dump from it.

I upped the debug level from 1 to 5, which appears to give a ton of
information.  I didn't see any interesting messages from debug=1; the
relevant areas from smbmount.log are below.  I enabled core dumps just
now -- RedHat 7.3 has them disabled for bash by default.  So with luck
I should have more information if this happens again.

I upgraded to kernel 2.4.19 just in case that was the problem, and I'll
upgrade Samba in the next few days.


> I believe this is at umount time.

That's what I thought too.  Interestingly, however, I think the log file
of my backup script from the second crash indicated that that crash
happened when the filesystem was first mounted.  I accidently deleted
that log though so I can't check it.... :-(


> And if smb_delete_inode wants to
> actually close something and smb_retry is failing it won't be able to.
>
> I need to find out if/why that would cause the busy message. When the
> connection closes any open files are closed, so closing shouldn't be a
> problem.
>
> Did you get either of these the second time?

No.  I've included more of /var/log/messages (and also
/var/log/samba/smbmount.log) below, in case there's something useful
in them that I overlooked.


> > VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice
> > day...
>
> Kabooom!

Yup!  It's actually nice to have a bit of humor in the middle of one's
server crashing.

	-Joel




======================= Crash #1 ===================================

----------------------- /var/log/samba/smbmount.log #1 -------------

[2002/09/05 11:58:47, 0] client/smbmount.c:send_fs_socket(386)
  mount.smbfs: entering daemon mode for service \\pc22\usr, pid=17752
[2002/09/05 11:58:47, 0] client/smbmount.c:send_fs_socket(386)
  mount.smbfs: entering daemon mode for service \\pc15\c$, pid=17762
[2002/09/05 11:58:47, 0] client/smbmount.c:send_fs_socket(386)
  mount.smbfs: entering daemon mode for service \\pc52\c$, pid=17770
[2002/09/05 11:58:48, 0] client/smbmount.c:send_fs_socket(386)
  mount.smbfs: entering daemon mode for service \\pc96\c$, pid=17787
[2002/09/05 11:58:48, 0] client/smbmount.c:send_fs_socket(386)
  mount.smbfs: entering daemon mode for service \\pc34\c$, pid=17796
[2002/09/05 11:58:48, 0] client/smbmount.c:send_fs_socket(386)
  mount.smbfs: entering daemon mode for service \\pc23\user, pid=17804


----------------------- /var/log/messages #1 -----------------------

Sep  4 20:46:13 files2 kernel: smb_proc_readdir_long: name=\usr\usr\???????\*, result=-2, rcls=1, err=123
Sep  4 20:46:13 files2 kernel: smb_proc_readdir_long: name=\usr\usr\sch\*, result=-13, rcls=1, err=5
Sep  4 20:46:13 files2 kernel: smb_proc_readdir_long: name=\usr\mentor_guide\*, result=-13, rcls=1, err=5
Sep  5 06:59:05 files2 kernel: raid5: multiple 0 requests for sector 196608024
Sep  5 06:59:25 files2 kernel: raid5: multiple 0 requests for sector 256464264
Sep  5 11:56:35 files2 kernel: smb_retry: no connection process
Sep  5 11:56:37 files2 last message repeated 2 times
Sep  5 11:56:37 files2 kernel: smb_delete_inode: could not close inode 2
Sep  5 11:56:37 files2 kernel: VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...
Sep  5 11:58:50 files2 kernel: Unable to handle kernel paging request at virtual address 740a6279
Sep  5 11:58:50 files2 kernel:  printing eip:
Sep  5 11:58:50 files2 kernel: c01588d3
Sep  5 11:58:50 files2 kernel: *pde = 00000000
Sep  5 11:58:50 files2 kernel: Oops: 0000
Sep  5 11:58:50 files2 kernel: smbfs nfs lockd sunrpc tg3 eepro100 ide-cd cdrom st usb-ohci usbcore ext3 jbd
Sep  5 11:58:50 files2 kernel: CPU:    0
Sep  5 11:58:50 files2 kernel: EIP:    0010:[<c01588d3>]    Not tainted
Sep  5 11:58:50 files2 kernel: EFLAGS: 00010206
Sep  5 11:58:50 files2 kernel:
Sep  5 11:58:50 files2 kernel: EIP is at iput [kernel] 0x43 (2.4.18-10smp)
Sep  5 11:58:50 files2 kernel: eax: 740a6269   ebx: c9111da0   ecx: f4bfcbd0   edx: c9111db0
Sep  5 11:58:50 files2 kernel: esi: c26cc400   edi: 740a6269   ebp: 00000041   esp: f7ed3f5c
Sep  5 11:58:51 files2 kernel: ds: 0018   es: 0018   ss: 0018
Sep  5 11:58:51 files2 kernel: Process kswapd (pid: 7, stackpage=f7ed3000)
Sep  5 11:58:51 files2 kernel: Stack: f4bfcbb8 f4bfcba0 c9111da0 c0155fa6 c9111da0 00000375 000000c3 ffffffff
Sep  5 11:58:51 files2 kernel:        c02f3c28 00000375 00000185 00000493 c01381e8 000001d0 00000556 00000000
Sep  5 11:58:51 files2 kernel:        00000185 c01563d0 0000230c c0138b3c 00000006 000001d0 000001d0 f7ed2000
Sep  5 11:58:51 files2 kernel: Call Trace: [<c0155fa6>] prune_dcache [kernel] 0xe6
Sep  5 11:58:51 files2 kernel: [<c01381e8>] page_launder [kernel] 0x168
Sep  5 11:58:51 files2 kernel: [<c01563d0>] shrink_dcache_memory [kernel] 0x20
Sep  5 11:58:51 files2 kernel: [<c0138b3c>] do_try_to_free_pages [kernel] 0x1c
Sep  5 11:58:51 files2 kernel: [<c0138e31>] kswapd [kernel] 0x101
Sep  5 11:58:52 files2 kernel: [<c0105000>] stext [kernel] 0x0
Sep  5 11:58:52 files2 kernel: [<c0107286>] kernel_thread [kernel] 0x26
Sep  5 11:58:52 files2 kernel: [<c0138d30>] kswapd [kernel] 0x0
Sep  5 11:58:52 files2 kernel:
Sep  5 11:58:58 files2 kernel:
Sep  5 11:58:59 files2 kernel: Code: 8b 47 10 85 c0 74 04 53 ff d0 58 68 bc 49 2f c0 8d 43 2c 50
Sep  5 12:40:28 files2 syslogd 1.4.1: restart.
Sep  5 12:40:28 files2 syslog: syslogd startup succeeded
Sep  5 12:40:28 files2 kernel: klogd 1.4.1, log source = /proc/kmsg started.
Sep  5 12:40:28 files2 kernel: Linux version 2.4.18-10smp (bhcompile@stripples.devel.redhat.com) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #1 SMP Wed Aug 7 11:17:48 EDT 2002



======================= Crash #2 ===================================

----------------------- /var/log/samba/smbmount.log #2 -------------

[2002/09/12 04:58:19, 0] client/smbmount.c:send_fs_socket(386)
  mount.smbfs: entering daemon mode for service \\pc43\c$, pid=3230
[2002/09/12 04:59:07, 0] client/smbmount.c:send_fs_socket(386)
  mount.smbfs: entering daemon mode for service \\pc74\c$, pid=3274
[2002/09/12 04:59:43, 0] client/smbmount.c:send_fs_socket(386)
  mount.smbfs: entering daemon mode for service \\pc74\c$, pid=3311
[2002/09/12 05:03:23, 0] client/smbmount.c:send_fs_socket(386)
  mount.smbfs: entering daemon mode for service \\pc67\c$, pid=3361
[2002/09/12 05:04:07, 0] client/smbmount.c:send_fs_socket(386)
  mount.smbfs: entering daemon mode for service \\pc67\c$, pid=3398
[2002/09/12 05:07:14, 0] client/smbmount.c:send_fs_socket(386)
  mount.smbfs: entering daemon mode for service \\pc3\c$, pid=3442


----------------------- /var/log/messages #2 -----------------------

Sep 12 03:47:23 files2 kernel: smb_proc_readdir_long: name=\usr\usr\???????\*, result=-2, rcls=1, err=123
Sep 12 03:47:23 files2 kernel: smb_proc_readdir_long: name=\usr\usr\sch\*, result=-13, rcls=1, err=5
Sep 12 03:47:23 files2 kernel: smb_proc_readdir_long: name=\usr\mentor_guide\*, result=-13, rcls=1, err=5
Sep 12 03:55:52 files2 kernel: smb_proc_readdir_long: name=\Cygwin\home\tim\Mail\*, result=-13, rcls=1, err=5
Sep 12 04:01:22 files2 kernel: smb_proc_readdir_long: name=\Projects\sahara30\production\production\production\*, result=-13, rcls=1, err=5
Sep 12 05:00:35 files2 kernel: smb_open: Mail/Inbox.snm open failed, result=-26
Sep 12 05:00:37 files2 kernel: smb_open: Mail/Inbox.snm open failed, result=-26
Sep 12 05:00:37 files2 kernel: smb_readpage_sync: Mail/Inbox.snm open failed, error=-26
Sep 12 05:37:05 files2 kernel: ------------[ cut here ]------------
Sep 12 05:37:05 files2 kernel: kernel BUG at inode.c:1066!
Sep 12 05:37:05 files2 kernel: invalid operand: 0000
Sep 12 05:37:05 files2 kernel: smbfs nfs lockd sunrpc tg3 eepro100 ide-cd cdrom st usb-ohci usbcore ext3 jbd
Sep 12 05:37:05 files2 kernel: CPU:    1
Sep 12 05:37:05 files2 kernel: EIP:    0010:[<c01588bf>]    Not tainted
Sep 12 05:37:05 files2 kernel: EFLAGS: 00010286
Sep 12 05:37:05 files2 kernel:
Sep 12 05:37:05 files2 kernel: EIP is at iput [kernel] 0x2f (2.4.18-10smp)
Sep 12 05:37:05 files2 kernel: eax: 0000001c   ebx: d94fe420   ecx: c02f25e0   edx: 00008f60
Sep 12 05:37:05 files2 kernel: esi: f7d1c000   edi: 00000000   ebp: 00000051   esp: f7ed3f54
Sep 12 05:37:05 files2 kernel: ds: 0018   es: 0018   ss: 0018
Sep 12 05:37:05 files2 kernel: Process kswapd (pid: 7, stackpage=f7ed3000)
Sep 12 05:37:13 files2 kernel: Stack: c024a65f 0000042a ddd49e58 ddd49e40 d94fe420 c0155fa6 d94fe420 0000038e
Sep 12 05:37:13 files2 kernel:        00000098 ffffffff c02f3c28 0000038e 0000016c 000003cd c01381e8 000001d0
Sep 12 05:37:13 files2 kernel:        00000465 00000000 0000016c c01563d0 000020a0 c0138b3c 00000006 000001d0
Sep 12 05:37:13 files2 kernel: Call Trace: [<c0155fa6>] prune_dcache [kernel] 0xe6
Sep 12 05:37:13 files2 kernel: [<c01381e8>] page_launder [kernel] 0x168
Sep 12 05:37:13 files2 kernel: [<c01563d0>] shrink_dcache_memory [kernel] 0x20
Sep 12 05:37:14 files2 kernel: [<c0138b3c>] do_try_to_free_pages [kernel] 0x1c
Sep 12 05:37:14 files2 kernel: [<c0138e31>] kswapd [kernel] 0x101
Sep 12 05:37:14 files2 kernel: [<c0105000>] stext [kernel] 0x0
Sep 12 05:37:14 files2 kernel: [<c0107286>] kernel_thread [kernel] 0x26
Sep 12 05:37:14 files2 kernel: [<c0138d30>] kswapd [kernel] 0x0
Sep 12 05:37:14 files2 kernel:
Sep 12 05:37:14 files2 kernel:
Sep 12 05:37:14 files2 kernel: Code: 0f 0b 5a 59 85 f6 74 08 8b 46 20 85 c0 0f 45 f8 85 ff 74 0b
Sep 12 10:21:30 files2 syslogd 1.4.1: restart.
Sep 12 10:21:30 files2 syslog: syslogd startup succeeded
Sep 12 10:21:30 files2 syslog: klogd startup succeeded
Sep 12 10:21:30 files2 kernel: klogd 1.4.1, log source = /proc/kmsg started.
Sep 12 10:21:30 files2 kernel: Linux version 2.4.18-10smp (bhcompile@stripples.devel.redhat.com) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #1 SMP Wed Aug 7 11:17:48 EDT 2002



