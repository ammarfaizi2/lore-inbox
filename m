Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271935AbTG2Rmi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 13:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266141AbTG2Rmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 13:42:38 -0400
Received: from [213.69.232.58] ([213.69.232.58]:1290 "HELO schottelius.org")
	by vger.kernel.org with SMTP id S271935AbTG2RmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 13:42:22 -0400
Date: Tue, 29 Jul 2003 19:40:50 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Wiktor Wodecki <wodecki@gmx.de>
Cc: Steve Lord <lord@sgi.com>, Nico Schottelius <nico-kernel@schottelius.org>,
       scholz@wdt.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test2 usb stack crashed was: Re: bug in 2.6.0test2
Message-ID: <20030729174050.GA14547@schottelius.org>
References: <20030728115902.GA18993@schottelius.org> <1059425249.6601.10.camel@jen.americas.sgi.com> <20030728222641.GE10741@schottelius.org> <1059478999.1749.18.camel@laptop.americas.sgi.com> <20030729155251.GB667@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <20030729155251.GB667@gmx.de>
User-Agent: Mutt/1.4i
X-Operating-System: Linux flapp 2.6.0-test2
X-Free86: doesn't compile currently
X-Replacement: please tell me some (working)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We've some more information, but tomorrow. My co-worker
is too tired now :)

Nico

Wiktor Wodecki [Tue, Jul 29, 2003 at 05:52:51PM +0200]:
> Hello,
>=20
> On Tue, Jul 29, 2003 at 06:43:17AM -0500, Steve Lord wrote:
> > On Mon, 2003-07-28 at 17:26, Nico Schottelius wrote:
> > > Steve Lord [Mon, Jul 28, 2003 at 03:47:30PM -0500]:
> > > >=20
> > > > Something else went wrong before you crashed:
> > > >=20
> > > > bio too big device loop0 (2 > 0)
> > > >=20
> > > > This means you cannot use any bio larger than zero to this device,
> > >=20
> > > assume i didn't understand very much you told me..what is a bio?
> > > how do I use it? and why is it too big here?
> >=20
> > It looks like the loop device may not be correctly initialized yet,
> > no I/O is possible to it yet.
> >=20
> > >=20
> > > > which is probably why ext2 said this, since it caught the error when
> > > > building the bio.
> > >=20
> > > ext2? I am wondering..afai understood that, the root wasn't even
> > > decrypted, how can the kernel try to ext2-mount it?
> > >=20
> > > > EXT2-fs: unable to read superblock
> > > >=20
> > > > XFS didn't catch the error building the bio and submitted it, at
> > > > which point the I/O tripped the BUG. I can fix this part, but
> > > > the original problem is something I know nothing about.
> > >=20
> > > ..or better why does it start mounting/before decrypt?
> > >=20
> >=20
> > I have never used a crypto loop device, so I cannot what is really
> > going on. Some initialization step may be missing in the loop device
> > which means it is not usable, the mount it happening because the
> > kernel was told to mount it. If you are not specifying a filesystem
> > type, then possibly what is happening is it is attempting to open
> > the device as different filesystems, these all fail, until xfs
> > which does not detect the underlying error on the loop device,
> > and issues the IO which causes the BUG.
>=20
> I just experienced a similar bug.
> I disconnected by accident the usb hob from power and the write crashed:
>=20
> Jul 29 17:00:38 kakerlak kernel: SCSI error : <1 0 0 0> return code =3D
> 0x70000
> Jul 29 17:00:38 kakerlak kernel: end_request: I/O error, dev sda, sector
> 11218
> Jul 29 17:00:38 kakerlak kernel: Buffer I/O error on device sda1,
> logical block 11155
> Jul 29 17:00:38 kakerlak kernel: error on device sda1, logical block
> 52829
> Jul 29 17:00:38 kakerlak kernel: Buffer I/O error on device sda1,
> logical block 52830
> Jul 29 17:00:38 kakerlak kernel: Buffer I/O error on device sda1,
> logical block 52831
> Jul 29 17:00:38 kakerlak kernel: Buffer I/O error on device sda1,
> logical block 52832
> Jul 29 17:00:38 kakerlak kernel: Buffer I/O error on device sda1,
> logical block 52833
> ...
> Jul 29 17:00:39 kakerlak kernel: Buffer I/O error on device sda1,
> logical block 52882
> Jul 29 17:00:39 kakerlak kernel: scsi1 (0:0): rejecting I/O to offline
> device
> Jul 29 17:00:39 kakerlak kernel: Buffer I/O error on device sda1,
> logical block 52883
> ...
> ul 29 17:00:40 kakerlak kernel: FAT: Filesystem panic (dev sda1)
> Jul 29 17:00:40 kakerlak kernel:     unable to read i-node block (i_pos
> 7987)
> Jul 29 17:00:40 kakerlak kernel:     File system has been set read-only
> Jul 29 17:00:40 kakerlak kernel: usb 1-2.3: USB disconnect, address 3
> Jul 29 17:00:40 kakerlak kernel: usb 1-2.4: USB disconnect, address 4
> Jul 29 17:00:40 kakerlak kernel: bio too big device sda1 (1 > 0)
> Jul 29 17:00:40 kakerlak kernel: FAT: bread(block 52) in fat_access
> failed
> Jul 29 17:00:40 kakerlak kernel: bio too big device sda1 (1 > 0)
>=20
> nothing wrong here, was my fault
> After powering on the usb hub again:
>=20
> Jul 29 17:00:41 kakerlak kernel: hub 1-0:0: debounce: port 2: delay
> 100ms stable 4 status 0x101
> Jul 29 17:00:41 kakerlak kernel: hub 1-0:0: new USB device on port 2,
> assigned address 6
> Jul 29 17:00:41 kakerlak kernel: hub 1-2:0: USB hub found
> Jul 29 17:00:41 kakerlak kernel: hub 1-2:0: 4 ports detected
> Jul 29 17:00:41 kakerlak kernel: hub 1-2:0: debounce: port 1: delay
> 100ms stable 4 status 0x101
> Jul 29 17:00:41 kakerlak kernel: hub 1-2:0: new USB device on port 1,
> assigned address 7
> Jul 29 17:00:41 kakerlak kernel: scsi2 : SCSI emulation for USB Mass
> Storage devices
> Jul 29 17:00:41 kakerlak kernel:   Vendor: 3SYSTEM   Model: USB FLASH
> DISK    Rev: 1.00
> Jul 29 17:00:41 kakerlak kernel:   Type:   Direct-Access
> ANSI SCSI revision: 02
> Jul 29 17:00:41 kakerlak kernel: SCSI device sda: 256000 512-byte hdwr
> sectors (131 MB)
> Jul 29 17:00:41 kakerlak kernel: sda: Write Protect is off
> Jul 29 17:00:41 kakerlak kernel: sda: Mode Sense: 00 0e 00 00
> Jul 29 17:00:41 kakerlak kernel: sda: cache data unavailable
> Jul 29 17:00:41 kakerlak kernel: sda: assuming drive cache: write
> through
> Jul 29 17:00:41 kakerlak kernel: Unable to handle kernel NULL pointer
> dereference at virtual address 00000000
> Jul 29 17:00:41 kakerlak kernel:  printing eip:=20
> Jul 29 17:00:41 kakerlak kernel: c026cc89
> Jul 29 17:00:41 kakerlak kernel: *pde =3D 00000000
> Jul 29 17:00:41 kakerlak kernel: Oops: 0000 [#1]
> Jul 29 17:00:41 kakerlak kernel: CPU:    0
> Jul 29 17:00:41 kakerlak kernel: EIP:    0060:[scsi_device_get+25/112]
> Not tainted
> Jul 29 17:00:41 kakerlak kernel: EFLAGS: 00010292
> Jul 29 17:00:41 kakerlak kernel: EIP is at scsi_device_get+0x19/0x70
> Jul 29 17:00:41 kakerlak kernel: eax: 00000000   ebx: ca35d800   ecx:
> cc2fb200   edx: c933b380
> Jul 29 17:00:41 kakerlak kernel: esi: 00000001   edi: d3423840   ebp:
> cc2fb200   esp: d3e01aec
> Jul 29 17:00:41 kakerlak kernel: ds: 007b   es: 007b   ss: 0068
> Jul 29 17:00:42 kakerlak kernel: Process khubd (pid: 5, threadinfo=3Dd3e0=
0000 task=3Dd3f8e040)
> Jul 29 17:00:42 kakerlak kernel: Stack: d3e00000 ca35d800 c02908c2 ca35d8=
00 d3c4d400 d3e00000 c0290880 d3c64140
> Jul 29 17:00:42 kakerlak kernel:        00000000 c015b7bc cc2fb200 d3e01c=
14 d3e00000 d3ccd800 c0108260 d3c64158
> Jul 29 17:00:42 kakerlak kernel:        d3e00000 00000000 d3c64140 000000=
01 d3e01c14 d3c4d400 c015b89d d3c64140
> Jul 29 17:00:42 kakerlak kernel: Call Trace:=20
> Jul 29 17:00:42 kakerlak kernel:  [sd_open+66/288] sd_open+0x42/0x120
> Jul 29 17:00:42 kakerlak kernel:  [sd_open+0/288] sd_open+0x0/0x120
> Jul 29 17:00:42 kakerlak kernel:  [do_open+908/1008] do_open+0x38c/0x3f0
> Jul 29 17:00:42 kakerlak kernel:  [__up_wakeup+8/40] __up_wakeup+0x8/0x28
> Jul 29 17:00:42 kakerlak kernel:  [blkdev_get+125/160] blkdev_get+0x7d/0x=
a0
> Jul 29 17:00:42 kakerlak kernel:  [register_disk+191/352] register_disk+0=
xbf/0x160
> Jul 29 17:00:42 kakerlak kernel:  [add_disk+78/96] add_disk+0x4e/0x60
> Jul 29 17:00:42 kakerlak kernel:  [exact_match+0/16] exact_match+0x0/0x10
> Jul 29 17:00:42 kakerlak kernel:  [exact_lock+0/32] exact_lock+0x0/0x20
> Jul 29 17:00:42 kakerlak kernel:  [sd_probe+456/720] sd_probe+0x1c8/0x2d0
> Jul 29 17:00:42 kakerlak kernel:  [bus_match+69/128] bus_match+0x45/0x80
> Jul 29 17:00:42 kakerlak kernel:  [device_attach+67/128] device_attach+0x=
43/0x80
> Jul 29 17:00:42 kakerlak kernel:  [bus_add_device+100/176] bus_add_device=
+0x64/0xb0
> Jul 29 17:00:42 kakerlak kernel:  [device_add+205/256] device_add+0xcd/0x=
100
> Jul 29 17:00:42 kakerlak kernel:  [scsi_device_register+213/464] scsi_dev=
ice_register+0xd5/0x1d0
> Jul 29 17:00:42 kakerlak kernel:  [_end+389556744/1068411384] slave_confi=
gure+0x0/0x10 [usb_storage]
> Jul 29 17:00:42 kakerlak kernel:  [scsi_add_lun+675/928] scsi_add_lun+0x2=
a3/0x3a0
> Jul 29 17:00:42 kakerlak kernel:  [scsi_probe_and_add_lun+157/304] scsi_p=
robe_and_add_lun+0x9d/0x130
> Jul 29 17:00:42 kakerlak kernel:  [scsi_scan_target+80/208] scsi_scan_tar=
get+0x50/0xd0
> Jul 29 17:00:42 kakerlak kernel:  [scsi_scan_host+57/96] scsi_scan_host+0=
x39/0x60
> Jul 29 17:00:42 kakerlak kernel:  [_end+389567101/1068411384] storage_pro=
be+0x125/0x190 [usb_storage]
> Jul 29 17:00:42 kakerlak kernel:  [sysfs_create+113/160] sysfs_create+0x7=
1/0xa0
> Jul 29 17:00:42 kakerlak kernel:  [usb_device_probe+118/160] usb_device_p=
robe+0x76/0xa0
> Jul 29 17:00:42 kakerlak kernel:  [bus_match+69/128] bus_match+0x45/0x80
> Jul 29 17:00:42 kakerlak kernel:  [device_attach+67/128] device_attach+0x=
43/0x80
> Jul 29 17:00:42 kakerlak kernel:  [bus_add_device+100/176] bus_add_device=
+0x64/0xb0
> Jul 29 17:00:42 kakerlak kernel:  [device_add+205/256] device_add+0xcd/0x=
100
> Jul 29 17:00:42 kakerlak kernel:  [usb_new_device+980/1312] usb_new_devic=
e+0x3d4/0x520
> Jul 29 17:00:42 kakerlak kernel:  [hub_port_connect_change+436/800] hub_p=
ort_connect_change+0x1b4/0x320
> Jul 29 17:00:42 kakerlak kernel:  [hub_events+720/848] hub_events+0x2d0/0=
x350
> Jul 29 17:00:42 kakerlak kernel:  [hub_thread+45/240] hub_thread+0x2d/0xf0
> Jul 29 17:00:42 kakerlak kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/=
0x14
> Jul 29 17:00:42 kakerlak kernel:  [default_wake_function+0/48] default_wa=
ke_function+0x0/0x30
> Jul 29 17:00:42 kakerlak kernel:  [hub_thread+0/240] hub_thread+0x0/0xf0
> Jul 29 17:00:42 kakerlak kernel:  [kernel_thread_helper+5/12] kernel_thre=
ad_helper+0x5/0xc
> Jul 29 17:00:42 kakerlak kernel:=20
> Jul 29 17:00:42 kakerlak kernel: Code: 8b 10 85 d2 74 2f b8 00 e0 ff ff 2=
1 e0 ff 40 14 83 3a 02 74=20
> Jul 29 17:01:47 kakerlak kernel: bio too big device sda1 (1 > 0)=20
> Jul 29 17:01:47 kakerlak kernel: FAT: Directory bread(block 499) failed
> Jul 29 17:01:47 kakerlak kernel: bio too big device sda1 (1 > 0)
> Jul 29 17:01:47 kakerlak kernel: FAT: Directory bread(block 500) failed
> ...
> Jul 29 17:01:57 kakerlak kernel: buffer layer error at fs/buffer.c:2800
> Jul 29 17:01:57 kakerlak kernel: Call Trace:=20
> Jul 29 17:01:57 kakerlak kernel:  [drop_buffers+179/192] drop_buffers+0xb=
3/0xc0
> Jul 29 17:01:57 kakerlak kernel:  [try_to_free_buffers+71/208] try_to_fre=
e_buffers+0x47/0xd0
> Jul 29 17:01:57 kakerlak kernel:  [block_invalidatepage+174/224] block_in=
validatepage+0xae/0xe0
> Jul 29 17:01:57 kakerlak kernel:  [do_invalidatepage+39/48] do_invalidate=
page+0x27/0x30
> Jul 29 17:01:57 kakerlak kernel:  [truncate_complete_page+123/128] trunca=
te_complete_page+0x7b/0x80
> Jul 29 17:01:57 kakerlak kernel:  [truncate_inode_pages+240/656] truncate=
_inode_pages+0xf0/0x290
> Jul 29 17:01:57 kakerlak kernel:  [invalidate_inode_buffers+17/112] inval=
idate_inode_buffers+0x11/0x70
> Jul 29 17:01:57 kakerlak kernel:  [dispose_list+151/160] dispose_list+0x9=
7/0xa0
> Jul 29 17:01:57 kakerlak kernel:  [invalidate_inodes+154/192] invalidate_=
inodes+0x9a/0xc0
> Jul 29 17:01:57 kakerlak kernel:  [generic_shutdown_super+121/400] generi=
c_shutdown_super+0x79/0x190
> Jul 29 17:01:57 kakerlak kernel:  [kill_block_super+29/80] kill_block_sup=
er+0x1d/0x50
> Jul 29 17:01:57 kakerlak kernel:  [deactivate_super+94/192] deactivate_su=
per+0x5e/0xc0
> Jul 29 17:01:57 kakerlak kernel:  [sys_umount+63/144] sys_umount+0x3f/0x90
> Jul 29 17:01:57 kakerlak kernel:  [sys_oldumount+23/32] sys_oldumount+0x1=
7/0x20
> Jul 29 17:01:57 kakerlak kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> ... (repeating a couple of times)
>=20
> Maybe my error can help to trace that down. I cannot reproduce, tho
>=20
> After that the usb stack was dead. It's not a module, so I didn't tried
> to unload it.
>=20
> --=20
> Regards,
>=20
> Wiktor Wodecki



--=20
echo God bless America | sed 's/.*\(A.*$\)/Why \1?/'
pgp: new id: 0x8D0E27A4 | ftp.schottelius.org/pub/familiy/nico/pgp-key.new

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE/JrGitnlUggLJsX0RAkihAJ9lXr1fNviBVvP7mwiY7hRmyJUP3QCdFWSo
qFYcmhwyBx7za+G6J/QFe2c=
=H5gC
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
