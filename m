Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbVHGD4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbVHGD4l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 23:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbVHGD4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 23:56:41 -0400
Received: from mail.autoweb.net ([198.172.237.26]:8082 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S1750825AbVHGD4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 23:56:40 -0400
Date: Sat, 6 Aug 2005 23:56:30 -0400
From: Ryan Anderson <ryan@michonline.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Oops in 2.6.13-rc5-git-current (0d317fb72fe3cf0f611608cf3a3015bbe6cd2a66)
Message-ID: <20050807035630.GA5271@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


I shortened this a bit, but the unaltered log is attached (grep kernel
/var/log/syslog at least)

I had a hard drive fail (I heard it start clicking), but things seemed
to be up so I didn't notice the oops right away.  I started an rsync to
pull an extra copy of my /home/ onto another machine.  When that locked
up, I looked at the console of this machine and saw the slab corruption,
at which point I rebooted.

Oh, userspace is Debian/sid, if it matters.

The log between those two points in time is below:

hdb: irq timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
ide0: reset: success
Unable to handle kernel paging request at virtual address 6b6b6b6b
 printing eip:
c0188d15
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
Modules linked in: ppp_deflate bsd_comp ppp_async ppp_generic slhc radeon esp6 ah6 wp512 tgr192 tea khazad michael_mic cast6 cast5 arc4 anubis nfsd exportfs lp binfmt_misc ipv6 tsdev evdev analog parport_pc parport 8250_pnp 8250 serial_core via_agp serpent aes_i586 crypto_null snd_via82xx gameport snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore uhci_hcd via_ircc irda dm_mod r8169 raid5 xor tulip via drm agpgart cpuid smbfs usbkbd usbcore trm290 triflex sc1200 ns87415 it821x cy82c693 cs5530 cs5520 atiixp raid1 md_mod
CPU:    0
EIP:    0060:[inotify_inode_queue_event+85/336]    Not tainted VLI
EFLAGS: 00010206   (2.6.13-rc5-g0d317fb7) 
EIP is at inotify_inode_queue_event+0x55/0x150
eax: 6b6b6b6b   ebx: 6b6b6b63   ecx: 00000000   edx: 00000066
esi: c3effe34   edi: ce8c76ac   ebp: d4bb864c   esp: d8655eb0
ds: 007b   es: 007b   ss: 0068
Process nfsd (pid: 3750, threadinfo=d8654000 task=d6155020)
Stack: 00000286 00000286 00000000 00000400 d4bb8760 d4bb8768 00000000 c3effe34 
       ce8c76ac d4bb864c c0170626 00000000 c3effe34 d6608ad4 db74b17c c3effe34 
       e0cfe9a4 00000013 e0d01b34 c0dd91b4 ce8c76ac ffffc000 d66092dc d66093c4 
Call Trace:
 [vfs_unlink+358/560] vfs_unlink+0x166/0x230
 [pg0+544348580/1067586560] nfsd_unlink+0x104/0x230 [nfsd]
 [pg0+544361268/1067586560] nfsd_cache_lookup+0x1c4/0x3c0 [nfsd]
 [pg0+544371728/1067586560] nfsd3_proc_remove+0x80/0xc0 [nfsd]
 [pg0+544381018/1067586560] nfs3svc_decode_diropargs+0x8a/0x100 [nfsd]
 [pg0+544380880/1067586560] nfs3svc_decode_diropargs+0x0/0x100 [nfsd]
 [pg0+544321698/1067586560] nfsd_dispatch+0x82/0x1f0 [nfsd]
 [svc_authenticate+112/336] svc_authenticate+0x70/0x150
 [svc_process+960/1648] svc_process+0x3c0/0x670
 [pg0+544323105/1067586560] nfsd+0x1a1/0x350 [nfsd]
 [ret_from_fork+6/20] ret_from_fork+0x6/0x14
 [pg0+544322688/1067586560] nfsd+0x0/0x350 [nfsd]
 [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Code: 01 00 00 b8 ce c4 40 c0 89 54 24 14 ba 66 00 00 00 e8 50 ea f8 ff ff 8b 1c 01 00 00 0f 88 ae 03 00 00 8b 83 14 01 00 00 8d 58 f8 <8b> 6b 08 83 ed 08 39 44 24 10 75 1c e9 aa 00 00 00 8b 55 08 8d 
 hdb: irq timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
ide0: reset timed-out, status=0xd0
hdb: status error: status=0x7f { DriveReady DeviceFault SeekComplete DataRequest CorrectedError Index Error }
hdb: status error: error=0x7f { DriveStatusError UncorrectableError SectorIdNotFound TrackZeroNotFound AddrMarkNotFound }, LBAsect=260013951, sector=23920575
ide: failed opcode was: unknown
hdb: drive not ready for command
ide0: reset: success
hdb: irq timeout: status=0xd0 { Busy }
ide: failed opcode was: unknown
ide0: reset timed-out, status=0xd0
hdb: status error: status=0x7f { DriveReady DeviceFault SeekComplete DataRequest CorrectedError Index Error }
hdb: status error: error=0x7f { DriveStatusError UncorrectableError SectorIdNotFound TrackZeroNotFound AddrMarkNotFound }, LBAsect=260013951, sector=15413575
ide: failed opcode was: unknown
hdb: drive not ready for command
ide0: reset timed-out, status=0xd0
end_request: I/O error, dev hdb, sector 15413575
raid5: Disk failure on hdb1, disabling device. Operation continuing on 2 devices
end_request: I/O error, dev hdb, sector 23920575
RAID5 conf printout:
 --- rd:3 wd:2 fd:1
 disk 0, o:1, dev:hdc1
 disk 1, o:1, dev:hdd3
 disk 2, o:0, dev:hdb1
RAID5 conf printout:
 --- rd:3 wd:2 fd:1
 disk 0, o:1, dev:hdc1
 disk 1, o:1, dev:hdd3
end_request: I/O error, dev hdb, sector 190578257
raid5: Disk failure on hdb3, disabling device. Operation continuing on 2 devices
end_request: I/O error, dev hdb, sector 190578265
end_request: I/O error, dev hdb, sector 190578273
end_request: I/O error, dev hdb, sector 190578281
end_request: I/O error, dev hdb, sector 240107281
RAID5 conf printout:
 --- rd:3 wd:2 fd:1
 disk 0, o:1, dev:hdc3
 disk 1, o:1, dev:hdd1
 disk 2, o:0, dev:hdb3
RAID5 conf printout:
 --- rd:3 wd:2 fd:1
 disk 0, o:1, dev:hdc3
 disk 1, o:1, dev:hdd1
end_request: I/O error, dev hdb, sector 25976977
raid1: Disk failure on hdb2, disabling device. 
^IOperation continuing on 1 devices
RAID1 conf printout:
 --- wd:1 rd:2
 disk 0, wo:1, o:0, dev:hdb2
 disk 1, wo:0, o:1, dev:hdd2
RAID1 conf printout:
 --- wd:1 rd:2
 disk 1, wo:0, o:1, dev:hdd2
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
[drm] Loading R200 Microcode
Slab corruption: start=d4bb85c0, len=464
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [destroy_inode+63/80](destroy_inode+0x3f/0x50)
1a0: 6b 6b 6b 6b 6b 6b 6b 6b 6a 6b 6b 6b 6b 6b 6b 6b
Prev obj: start=d4bb83e4, len=464
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [ext3_alloc_inode+15/48](ext3_alloc_inode+0xf/0x30)
000: c2 b6 3c 00 00 00 00 00 00 00 00 00 00 00 00 00
010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Next obj: start=d4bb879c, len=464
Redzone: 0x170fc2a5/0x170fc2a5.
Last user: [ext3_alloc_inode+15/48](ext3_alloc_inode+0xf/0x30)
000: c1 b6 3c 00 00 00 00 00 00 00 00 00 00 00 00 00
010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00a

-- 

Ryan Anderson
  sometimes Pug Majere

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="all.kernel"

Aug  6 18:27:59 mythical kernel: agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
Aug  6 18:27:59 mythical kernel: agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
Aug  6 18:27:59 mythical kernel: agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
Aug  6 18:27:59 mythical kernel: [drm] Loading R200 Microcode
Aug  6 18:30:28 mythical kernel: agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
Aug  6 18:30:28 mythical kernel: agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
Aug  6 18:30:28 mythical kernel: agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
Aug  6 18:30:28 mythical kernel: [drm] Loading R200 Microcode
Aug  6 19:43:27 mythical kernel: end_request: I/O error, dev fd0, sector 0
Aug  6 19:48:38 mythical kernel: nfsd: last server has exited
Aug  6 19:48:38 mythical kernel: nfsd: unexporting all filesystems
Aug  6 19:48:38 mythical kernel: Kernel logging (proc) stopped.
Aug  6 19:48:38 mythical kernel: Kernel log daemon terminating.
Aug  6 20:07:02 mythical kernel: klogd 1.4.1#17, log source = /proc/kmsg started.
Aug  6 20:07:02 mythical kernel: Inspecting /boot/System.map-2.6.13-rc5-g0d317fb7
Aug  6 20:07:02 mythical kernel: Loaded 32884 symbols from /boot/System.map-2.6.13-rc5-g0d317fb7.
Aug  6 20:07:02 mythical kernel: Symbols match kernel version 2.6.13.
Aug  6 20:07:02 mythical kernel: No module symbols loaded - kernel modules not enabled. 
Aug  6 20:07:02 mythical kernel: decryption
Aug  6 20:07:02 mythical kernel: failed to load transform for serpent ECB
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing tnepres ECB encryption
Aug  6 20:07:02 mythical kernel: failed to load transform for tnepres ECB
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing tnepres ECB decryption
Aug  6 20:07:02 mythical kernel: failed to load transform for tnepres ECB
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing aes ECB encryption
Aug  6 20:07:02 mythical kernel: failed to load transform for aes ECB
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing aes ECB decryption
Aug  6 20:07:02 mythical kernel: failed to load transform for aes ECB
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing cast5 ECB encryption
Aug  6 20:07:02 mythical kernel: failed to load transform for cast5 ECB
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing cast5 ECB decryption
Aug  6 20:07:02 mythical kernel: failed to load transform for cast5 ECB
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing cast6 ECB encryption
Aug  6 20:07:02 mythical kernel: failed to load transform for cast6 ECB
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing cast6 ECB decryption
Aug  6 20:07:02 mythical kernel: failed to load transform for cast6 ECB
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing arc4 ECB encryption
Aug  6 20:07:02 mythical kernel: failed to load transform for arc4 ECB
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing arc4 ECB decryption
Aug  6 20:07:02 mythical kernel: failed to load transform for arc4 ECB
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing tea ECB encryption
Aug  6 20:07:02 mythical kernel: failed to load transform for tea ECB
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing tea ECB decryption
Aug  6 20:07:02 mythical kernel: failed to load transform for tea ECB
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing xtea ECB encryption
Aug  6 20:07:02 mythical kernel: failed to load transform for xtea ECB
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing xtea ECB decryption
Aug  6 20:07:02 mythical kernel: failed to load transform for xtea ECB
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing khazad ECB encryption
Aug  6 20:07:02 mythical kernel: failed to load transform for khazad ECB
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing khazad ECB decryption
Aug  6 20:07:02 mythical kernel: failed to load transform for khazad ECB
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing anubis ECB encryption
Aug  6 20:07:02 mythical kernel: failed to load transform for anubis ECB
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing anubis ECB decryption
Aug  6 20:07:02 mythical kernel: failed to load transform for anubis ECB
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing anubis CBC encryption
Aug  6 20:07:02 mythical kernel: failed to load transform for anubis CBC
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing anubis CBC decryption
Aug  6 20:07:02 mythical kernel: failed to load transform for anubis CBC
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing sha384
Aug  6 20:07:02 mythical kernel: test 1:
Aug  6 20:07:02 mythical kernel: cb00753f45a35e8bb5a03d699ac65007272c32ab0eded1631a8b605a43ff5bed8086072ba1e7cc2358baeca134c825a7
Aug  6 20:07:02 mythical kernel: pass
Aug  6 20:07:02 mythical kernel: test 2:
Aug  6 20:07:02 mythical kernel: 3391fdddfc8dc7393707a65b1b4709397cf8b1d162af05abfe8f450de5f36bc6b0455a8520bc4e6f5fe95b1fe3c8452b
Aug  6 20:07:02 mythical kernel: pass
Aug  6 20:07:02 mythical kernel: test 3:
Aug  6 20:07:02 mythical kernel: 09330c33f71147e83d192fc782cd1b4753111b173b3b05d22fa08086e3b0f712fcc7c71a557e2db966c3e9fa91746039
Aug  6 20:07:02 mythical kernel: pass
Aug  6 20:07:02 mythical kernel: test 4:
Aug  6 20:07:02 mythical kernel: 3d208973ab3508dbbd7e2c2862ba290ad3010e4978c198dc4d8fd014e582823a89e16f9b2a7bbc1ac938e2d199e8bea4
Aug  6 20:07:02 mythical kernel: pass
Aug  6 20:07:02 mythical kernel: testing sha384 across pages
Aug  6 20:07:02 mythical kernel: test 1:
Aug  6 20:07:02 mythical kernel: 3d208973ab3508dbbd7e2c2862ba290ad3010e4978c198dc4d8fd014e582823a89e16f9b2a7bbc1ac938e2d199e8bea4
Aug  6 20:07:02 mythical kernel: pass
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing sha512
Aug  6 20:07:02 mythical kernel: test 1:
Aug  6 20:07:02 mythical kernel: ddaf35a193617abacc417349ae20413112e6fa4e89a97ea20a9eeee64b55d39a2192992a274fc1a836ba3c23a3feebbd454d4423643ce80e2a9ac94fa54ca49f
Aug  6 20:07:02 mythical kernel: pass
Aug  6 20:07:02 mythical kernel: test 2:
Aug  6 20:07:02 mythical kernel: 204a8fc6dda82f0a0ced7beb8e08a41657c16ef468b228a8279be331a703c33596fd15c13b1b07f9aa1d3bea57789ca031ad85c7a71dd70354ec631238ca3445
Aug  6 20:07:02 mythical kernel: pass
Aug  6 20:07:02 mythical kernel: test 3:
Aug  6 20:07:02 mythical kernel: 8e959b75dae313da8cf4f72814fc143f8f7779c6eb9f7fa17299aeadb6889018501d289e4900f7e4331b99dec4b5433ac7d329eeb6dd26545e96e55b874be909
Aug  6 20:07:02 mythical kernel: pass
Aug  6 20:07:02 mythical kernel: test 4:
Aug  6 20:07:02 mythical kernel: 930d0cefcb30ff1133b6898121f1cf3d27578afcafe8677c5257cf069911f75d8f5831b56ebfda67b278e66dff8b84fe2b2870f742a580d8edb41987232850c9
Aug  6 20:07:02 mythical kernel: pass
Aug  6 20:07:02 mythical kernel: testing sha512 across pages
Aug  6 20:07:02 mythical kernel: test 1:
Aug  6 20:07:02 mythical kernel: 930d0cefcb30ff1133b6898121f1cf3d27578afcafe8677c5257cf069911f75d8f5831b56ebfda67b278e66dff8b84fe2b2870f742a580d8edb41987232850c9
Aug  6 20:07:02 mythical kernel: pass
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing wp512
Aug  6 20:07:02 mythical kernel: failed to load transform for wp512
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing wp384
Aug  6 20:07:02 mythical kernel: failed to load transform for wp384
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing wp256
Aug  6 20:07:02 mythical kernel: failed to load transform for wp256
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing tgr192
Aug  6 20:07:02 mythical kernel: failed to load transform for tgr192
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing tgr160
Aug  6 20:07:02 mythical kernel: failed to load transform for tgr160
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing tgr128
Aug  6 20:07:02 mythical kernel: failed to load transform for tgr128
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing deflate compression
Aug  6 20:07:02 mythical kernel: test 1:
Aug  6 20:07:02 mythical kernel: f3cacfcc53282d56c8cb2f5748cc4b5128ce482c4a5528c9485528ce4f2b290771bc082b0100
Aug  6 20:07:02 mythical kernel: pass (ratio 70:38)
Aug  6 20:07:02 mythical kernel: test 2:
Aug  6 20:07:02 mythical kernel: 5d8d310ec2301004bfb22fc81f10040989c2853f70b12ff824db67d947c1ef49681251ae7667d62719881ade85ab21f2085d161e20042dadf318a215852d69c4428323b66c89719befcf8b9fcf33ca2fed62a94c80ff13af5237ed0e526b5902d94ee87a761d0298fe8a8783a34f568ab89e8e5c57d3a079fa02
Aug  6 20:07:02 mythical kernel: pass (ratio 191:122)
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing deflate decompression
Aug  6 20:07:02 mythical kernel: test 1:
Aug  6 20:07:02 mythical kernel: 5468697320646f63756d656e7420646573637269626573206120636f6d7072657373696f6e206d6574686f64206261736564206f6e20746865204445464c415445636f6d7072657373696f6e20616c676f726974686d2e20205468697320646f63756d656e7420646566696e657320746865206170706c69636174696f6e206f6620746865204445464c41544520616c676f726974686d20746f20746865204950205061796c6f616420436f6d7072657373696f6e2050726f746f636f6c2e
Aug  6 20:07:02 mythical kernel: pass (ratio 122:191)
Aug  6 20:07:02 mythical kernel: test 2:
Aug  6 20:07:02 mythical kernel: 4a6f696e207573206e6f7720616e642073686172652074686520736f667477617265204a6f696e207573206e6f7720616e642073686172652074686520736f66747761726520
Aug  6 20:07:02 mythical kernel: pass (ratio 38:70)
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing crc32c
Aug  6 20:07:02 mythical kernel: failed to load transform for crc32c
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing hmac_md5
Aug  6 20:07:02 mythical kernel: test 1:
Aug  6 20:07:02 mythical kernel: 9294727a3638bb1c13f48ef8158bfc9d
Aug  6 20:07:02 mythical kernel: pass
Aug  6 20:07:02 mythical kernel: test 2:
Aug  6 20:07:02 mythical kernel: 750c783e6ab0b503eaa86e310a5db738
Aug  6 20:07:02 mythical kernel: pass
Aug  6 20:07:02 mythical kernel: test 3:
Aug  6 20:07:02 mythical kernel: 56be34521d144c88dbb8c733f0e8b3f6
Aug  6 20:07:02 mythical kernel: pass
Aug  6 20:07:02 mythical kernel: test 4:
Aug  6 20:07:02 mythical kernel: 697eaf0aca3a3aea3a75164746ffaa79
Aug  6 20:07:02 mythical kernel: pass
Aug  6 20:07:02 mythical kernel: test 5:
Aug  6 20:07:02 mythical kernel: 56461ef2342edc00f9bab995690efd4c
Aug  6 20:07:02 mythical kernel: pass
Aug  6 20:07:02 mythical kernel: test 6:
Aug  6 20:07:02 mythical kernel: 6b1ab7fe4bd7bf8f0b62e6ce61b9d0cd
Aug  6 20:07:02 mythical kernel: pass
Aug  6 20:07:02 mythical kernel: test 7:
Aug  6 20:07:02 mythical kernel: 6f630fad67cda0ee1fb1f562db3aa53e
Aug  6 20:07:02 mythical kernel: pass
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing hmac_md5 across pages
Aug  6 20:07:02 mythical kernel: test 1:
Aug  6 20:07:02 mythical kernel: 750c783e6ab0b503eaa86e310a5db738
Aug  6 20:07:02 mythical kernel: pass
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing hmac_sha1
Aug  6 20:07:02 mythical kernel: test 1:
Aug  6 20:07:02 mythical kernel: b617318655057264e28bc0b6fb378c8ef146be00
Aug  6 20:07:02 mythical kernel: pass
Aug  6 20:07:02 mythical kernel: test 2:
Aug  6 20:07:02 mythical kernel: effcdf6ae5eb2fa2d27416d5f184df9c259a7c79
Aug  6 20:07:02 mythical kernel: pass
Aug  6 20:07:02 mythical kernel: test 3:
Aug  6 20:07:02 mythical kernel: 125d7342b9ac11cd91a39af48aa17b4f63f175d3
Aug  6 20:07:02 mythical kernel: pass
Aug  6 20:07:02 mythical kernel: test 4:
Aug  6 20:07:02 mythical kernel: 4c9007f4026250c6bc8414f9bf50c86c2d7235da
Aug  6 20:07:02 mythical kernel: pass
Aug  6 20:07:02 mythical kernel: test 5:
Aug  6 20:07:02 mythical kernel: 4c1a03424b55e07fe7f27be1d58bb9324a9a5a04
Aug  6 20:07:02 mythical kernel: pass
Aug  6 20:07:02 mythical kernel: test 6:
Aug  6 20:07:02 mythical kernel: aa4ae5e15272d00e95705637ce8a3b55ed402112
Aug  6 20:07:02 mythical kernel: pass
Aug  6 20:07:02 mythical kernel: test 7:
Aug  6 20:07:02 mythical kernel: e8e99d0f45237d786d6bbaa7965c7808bbff1a91
Aug  6 20:07:02 mythical kernel: pass
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing hmac_sha1 across pages
Aug  6 20:07:02 mythical kernel: test 1:
Aug  6 20:07:02 mythical kernel: effcdf6ae5eb2fa2d27416d5f184df9c259a7c79
Aug  6 20:07:02 mythical kernel: pass
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing hmac_sha256
Aug  6 20:07:02 mythical kernel: test 1:
Aug  6 20:07:02 mythical kernel: a21b1f5d4cf4f73a4dd939750f7a066a7f98cc131cb16a6692759021cfab8181
Aug  6 20:07:02 mythical kernel: pass
Aug  6 20:07:02 mythical kernel: test 2:
Aug  6 20:07:02 mythical kernel: 104fdc1257328f08184ba73131c53caee698e36119421149ea8c712456697d30
Aug  6 20:07:02 mythical kernel: pass
Aug  6 20:07:02 mythical kernel: test 3:
Aug  6 20:07:02 mythical kernel: 470305fc7e40fe34d3eeb3e773d95aab73acf0fd060447a5eb4595bf33a9d1a3
Aug  6 20:07:02 mythical kernel: pass
Aug  6 20:07:02 mythical kernel: test 4:
Aug  6 20:07:02 mythical kernel: 198a607eb44bfbc69903a0f1cf2bbdc5ba0aa3f3d9ae3c1c7a3b1696a0b68cf7
Aug  6 20:07:02 mythical kernel: pass
Aug  6 20:07:02 mythical kernel: test 5:
Aug  6 20:07:02 mythical kernel: 5bdcc146bf60754e6a042426089575c75a003f089d2739839dec58b964ec3843
Aug  6 20:07:02 mythical kernel: pass
Aug  6 20:07:02 mythical kernel: test 6:
Aug  6 20:07:02 mythical kernel: cdcb1220d1ecccea91e53aba3092f962e549fe6ce9ed7fdc43191fbde45c30b0
Aug  6 20:07:02 mythical kernel: pass
Aug  6 20:07:02 mythical kernel: test 7:
Aug  6 20:07:02 mythical kernel: d4633c17f6fb8d744c66dee0f8f074556ec4af55ef07998541468eb49bd2e917
Aug  6 20:07:02 mythical kernel: pass
Aug  6 20:07:02 mythical kernel: test 8:
Aug  6 20:07:02 mythical kernel: 7546af01841fc09b1ab9c3749a5f1c17d4f589668a587b2700a9c97c1193cf42
Aug  6 20:07:02 mythical kernel: pass
Aug  6 20:07:02 mythical kernel: test 9:
Aug  6 20:07:02 mythical kernel: 6953025ed96f0c09f80a96f78e6538dbe2e7b820e3dd970e7ddd39091b32352f
Aug  6 20:07:02 mythical kernel: pass
Aug  6 20:07:02 mythical kernel: test 10:
Aug  6 20:07:02 mythical kernel: 6355ac22e890d0a3c8481a5ca4825bc884d3e7a1ff98a2fc2ac7d8e064c3b2e6
Aug  6 20:07:02 mythical kernel: pass
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing hmac_sha256 across pages
Aug  6 20:07:02 mythical kernel: test 1:
Aug  6 20:07:02 mythical kernel: 5bdcc146bf60754e6a042426089575c75a003f089d2739839dec58b964ec3843
Aug  6 20:07:02 mythical kernel: pass
Aug  6 20:07:02 mythical kernel: 
Aug  6 20:07:02 mythical kernel: testing michael_mic
Aug  6 20:07:02 mythical kernel: failed to load transform for michael_mic
Aug  6 20:07:02 mythical kernel: ACPI: CPU0 (power states: C1[C1] C2[C2])
Aug  6 20:07:02 mythical kernel: ACPI: Thermal Zone [THRM] (68 C)
Aug  6 20:07:02 mythical kernel: isapnp: Scanning for PnP cards...
Aug  6 20:07:02 mythical kernel: isapnp: No Plug & Play device found
Aug  6 20:07:02 mythical kernel: Real Time Clock Driver v1.12
Aug  6 20:07:02 mythical kernel: pnp: the driver 'i8042 kbd' has been registered
Aug  6 20:07:02 mythical kernel: pnp: match found with the PnP device '00:0b' and the driver 'i8042 kbd'
Aug  6 20:07:02 mythical kernel: pnp: the driver 'i8042 aux' has been registered
Aug  6 20:07:02 mythical kernel: pnp: match found with the PnP device '00:0a' and the driver 'i8042 aux'
Aug  6 20:07:02 mythical kernel: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
Aug  6 20:07:02 mythical kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Aug  6 20:07:02 mythical kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Aug  6 20:07:02 mythical kernel: io scheduler noop registered
Aug  6 20:07:02 mythical kernel: io scheduler anticipatory registered
Aug  6 20:07:02 mythical kernel: io scheduler deadline registered
Aug  6 20:07:02 mythical kernel: io scheduler cfq registered
Aug  6 20:07:02 mythical kernel: Floppy drive(s): fd0 is 1.44M
Aug  6 20:07:02 mythical kernel: FDC 0 is a post-1991 82077
Aug  6 20:07:02 mythical kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Aug  6 20:07:02 mythical kernel: loop: loaded (max 8 devices)
Aug  6 20:07:02 mythical kernel: Compaq SMART2 Driver (v 2.6.0)
Aug  6 20:07:02 mythical kernel: HP CISS Driver (v 2.6.6)
Aug  6 20:07:02 mythical kernel: 8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
Aug  6 20:07:02 mythical kernel: 8139cp: pci dev 0000:00:0b.0 (id 10ec:8139 rev 10) is not an 8139C+ compatible chip
Aug  6 20:07:02 mythical kernel: 8139cp: Try the "8139too" driver instead.
Aug  6 20:07:02 mythical kernel: 8139too Fast Ethernet driver 0.9.27
Aug  6 20:07:02 mythical kernel: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
Aug  6 20:07:02 mythical kernel: PCI: setting IRQ 10 as level-triggered
Aug  6 20:07:02 mythical kernel: ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKD] -> GSI 10 (level, low) -> IRQ 10
Aug  6 20:07:02 mythical kernel: eth0: RealTek RTL8139 at 0xe0802000, 00:20:18:89:36:5f, IRQ 10
Aug  6 20:07:02 mythical kernel: eth0:  Identified 8139 chip type 'RTL-8139A'
Aug  6 20:07:02 mythical kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Aug  6 20:07:02 mythical kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Aug  6 20:07:02 mythical kernel: VP_IDE: IDE controller at PCI slot 0000:00:11.1
Aug  6 20:07:02 mythical kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
Aug  6 20:07:02 mythical kernel: PCI: setting IRQ 11 as level-triggered
Aug  6 20:07:02 mythical kernel: ACPI: PCI Interrupt 0000:00:11.1[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Aug  6 20:07:02 mythical kernel: PCI: Via IRQ fixup for 0000:00:11.1, from 255 to 11
Aug  6 20:07:02 mythical kernel: VP_IDE: chipset revision 6
Aug  6 20:07:02 mythical kernel: VP_IDE: not 100%% native mode: will probe irqs later
Aug  6 20:07:02 mythical kernel: VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci0000:00:11.1
Aug  6 20:07:02 mythical kernel:     ide0: BM-DMA at 0xd400-0xd407, BIOS settings: hda:DMA, hdb:DMA
Aug  6 20:07:02 mythical kernel:     ide1: BM-DMA at 0xd408-0xd40f, BIOS settings: hdc:DMA, hdd:DMA
Aug  6 20:07:02 mythical kernel: Probing IDE interface ide0...
Aug  6 20:07:02 mythical kernel: hda: WDC WD204BA, ATA DISK drive
Aug  6 20:07:02 mythical kernel: hdb: Maxtor 6Y120L0, ATA DISK drive
Aug  6 20:07:02 mythical kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Aug  6 20:07:02 mythical kernel: Probing IDE interface ide1...
Aug  6 20:07:02 mythical kernel: hdc: Maxtor 6Y120L4, ATA DISK drive
Aug  6 20:07:02 mythical kernel: hdd: ST3160023A, ATA DISK drive
Aug  6 20:07:02 mythical kernel: ide1 at 0x170-0x177,0x376 on irq 15
Aug  6 20:07:02 mythical kernel: pnp: the driver 'ide' has been registered
Aug  6 20:07:02 mythical kernel: hda: max request size: 128KiB
Aug  6 20:07:02 mythical kernel: hda: 39876480 sectors (20416 MB) w/2048KiB Cache, CHS=39560/16/63
Aug  6 20:07:02 mythical kernel: hda: cache flushes not supported
Aug  6 20:07:02 mythical kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
Aug  6 20:07:02 mythical kernel: hdb: max request size: 128KiB
Aug  6 20:07:02 mythical kernel: hdb: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=65535/16/63
Aug  6 20:07:02 mythical kernel: hdb: cache flushes supported
Aug  6 20:07:02 mythical kernel:  hdb: hdb1 hdb2 hdb3
Aug  6 20:07:02 mythical kernel: hdc: max request size: 1024KiB
Aug  6 20:07:02 mythical kernel: hdc: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=16383/255/63
Aug  6 20:07:02 mythical kernel: hdc: cache flushes supported
Aug  6 20:07:02 mythical kernel:  hdc: hdc1 hdc2 hdc3
Aug  6 20:07:02 mythical kernel: hdd: max request size: 1024KiB
Aug  6 20:07:02 mythical kernel: hdd: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63
Aug  6 20:07:02 mythical kernel: hdd: cache flushes supported
Aug  6 20:07:02 mythical kernel:  hdd: hdd1 hdd2 hdd3 hdd4 < hdd5 hdd6 >
Aug  6 20:07:02 mythical kernel: ide-floppy driver 0.99.newide
Aug  6 20:07:02 mythical kernel: 3ware Storage Controller device driver for Linux v1.26.02.001.
Aug  6 20:07:02 mythical kernel: mice: PS/2 mouse device common for all mice
Aug  6 20:07:02 mythical kernel: input: PC Speaker
Aug  6 20:07:02 mythical kernel: NET: Registered protocol family 2
Aug  6 20:07:02 mythical kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Aug  6 20:07:02 mythical kernel: IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
Aug  6 20:07:02 mythical kernel: TCP established hash table entries: 32768 (order: 6, 262144 bytes)
Aug  6 20:07:02 mythical kernel: TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
Aug  6 20:07:02 mythical kernel: TCP: Hash tables configured (established 32768 bind 32768)
Aug  6 20:07:02 mythical kernel: TCP reno registered
Aug  6 20:07:02 mythical kernel: TCP bic registered
Aug  6 20:07:02 mythical kernel: Initializing IPsec netlink socket
Aug  6 20:07:02 mythical kernel: NET: Registered protocol family 1
Aug  6 20:07:02 mythical kernel: NET: Registered protocol family 17
Aug  6 20:07:02 mythical kernel: NET: Registered protocol family 15
Aug  6 20:07:02 mythical kernel: Using IPI Shortcut mode
Aug  6 20:07:02 mythical kernel: RAMDISK: cramfs filesystem found at block 0
Aug  6 20:07:02 mythical kernel: RAMDISK: Loading 2044KiB [1 disk] into ram disk... |^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^Hdone.
Aug  6 20:07:02 mythical kernel: VFS: Mounted root (cramfs filesystem) readonly.
Aug  6 20:07:02 mythical kernel: Freeing unused kernel memory: 212k freed
Aug  6 20:07:02 mythical kernel: md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
Aug  6 20:07:02 mythical kernel: md: bitmap version 3.38
Aug  6 20:07:02 mythical kernel: md: raid1 personality registered as nr 3
Aug  6 20:07:02 mythical kernel: md: md1 stopped.
Aug  6 20:07:02 mythical kernel: md: bind<hdd2>
Aug  6 20:07:02 mythical kernel: md: bind<hdb2>
Aug  6 20:07:02 mythical kernel: raid1: raid set md1 active with 2 out of 2 mirrors
Aug  6 20:07:02 mythical kernel: md: md4 stopped.
Aug  6 20:07:02 mythical kernel: md: bind<hdc2>
Aug  6 20:07:02 mythical kernel: md: bind<hda1>
Aug  6 20:07:02 mythical kernel: raid1: raid set md4 active with 2 out of 2 mirrors
Aug  6 20:07:02 mythical kernel: input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
Aug  6 20:07:02 mythical kernel: ReiserFS: md4: warning: sh-2021: reiserfs_fill_super: can not find reiserfs on md4
Aug  6 20:07:02 mythical kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug  6 20:07:02 mythical kernel: kjournald starting.  Commit interval 5 seconds
Aug  6 20:07:02 mythical kernel: Adding 1028088k swap on /dev/md1.  Priority:-1 extents:1
Aug  6 20:07:02 mythical kernel: EXT3 FS on md4, internal journal
Aug  6 20:07:02 mythical kernel: usbcore: registered new driver usbfs
Aug  6 20:07:02 mythical kernel: usbcore: registered new driver hub
Aug  6 20:07:02 mythical kernel: usbcore: registered new driver usbkbd
Aug  6 20:07:02 mythical kernel: /home/ryan/dev/linux/linux-git/drivers/usb/input/usbkbd.c: :USB HID Boot Protocol keyboard driver
Aug  6 20:07:02 mythical kernel: Linux agpgart interface v0.101 (c) Dave Jones
Aug  6 20:07:02 mythical kernel: [drm] Initialized drm 1.0.0 20040925
Aug  6 20:07:02 mythical kernel: Linux Tulip driver version 1.1.13 (May 11, 2002)
Aug  6 20:07:02 mythical kernel: raid5: automatically using best checksumming function: pIII_sse
Aug  6 20:07:02 mythical kernel:    pIII_sse  :  3239.000 MB/sec
Aug  6 20:07:02 mythical kernel: raid5: using function: pIII_sse (3239.000 MB/sec)
Aug  6 20:07:02 mythical kernel: md: raid5 personality registered as nr 4
Aug  6 20:07:02 mythical kernel: device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
Aug  6 20:07:02 mythical kernel: md: md5 stopped.
Aug  6 20:07:02 mythical kernel: md: bind<hdd1>
Aug  6 20:07:02 mythical kernel: md: bind<hdb3>
Aug  6 20:07:02 mythical kernel: md: bind<hdc3>
Aug  6 20:07:02 mythical kernel: raid5: device hdc3 operational as raid disk 0
Aug  6 20:07:02 mythical kernel: raid5: device hdb3 operational as raid disk 2
Aug  6 20:07:02 mythical kernel: raid5: device hdd1 operational as raid disk 1
Aug  6 20:07:02 mythical kernel: raid5: allocated 3164kB for md5
Aug  6 20:07:02 mythical kernel: raid5: raid level 5 set md5 active with 3 out of 3 devices, algorithm 0
Aug  6 20:07:02 mythical kernel: RAID5 conf printout:
Aug  6 20:07:02 mythical kernel:  --- rd:3 wd:3 fd:0
Aug  6 20:07:02 mythical kernel:  disk 0, o:1, dev:hdc3
Aug  6 20:07:02 mythical kernel:  disk 1, o:1, dev:hdd1
Aug  6 20:07:02 mythical kernel:  disk 2, o:1, dev:hdb3
Aug  6 20:07:02 mythical kernel: md: md3 stopped.
Aug  6 20:07:02 mythical kernel: md: bind<hdd3>
Aug  6 20:07:02 mythical kernel: md: bind<hdb1>
Aug  6 20:07:02 mythical kernel: md: bind<hdc1>
Aug  6 20:07:02 mythical kernel: raid5: device hdc1 operational as raid disk 0
Aug  6 20:07:02 mythical kernel: raid5: device hdb1 operational as raid disk 2
Aug  6 20:07:02 mythical kernel: raid5: device hdd3 operational as raid disk 1
Aug  6 20:07:02 mythical kernel: raid5: allocated 3164kB for md3
Aug  6 20:07:02 mythical kernel: raid5: raid level 5 set md3 active with 3 out of 3 devices, algorithm 2
Aug  6 20:07:02 mythical kernel: RAID5 conf printout:
Aug  6 20:07:02 mythical kernel:  --- rd:3 wd:3 fd:0
Aug  6 20:07:02 mythical kernel:  disk 0, o:1, dev:hdc1
Aug  6 20:07:02 mythical kernel:  disk 1, o:1, dev:hdd3
Aug  6 20:07:02 mythical kernel:  disk 2, o:1, dev:hdb1
Aug  6 20:07:02 mythical kernel: md: md0 stopped.
Aug  6 20:07:02 mythical kernel: md: bind<hdd5>
Aug  6 20:07:02 mythical kernel: md: bind<hda5>
Aug  6 20:07:02 mythical kernel: raid1: raid set md0 active with 2 out of 2 mirrors
Aug  6 20:07:02 mythical kernel: md: md2 stopped.
Aug  6 20:07:02 mythical kernel: md: bind<hdd6>
Aug  6 20:07:02 mythical kernel: md: bind<hda7>
Aug  6 20:07:02 mythical kernel: raid1: raid set md2 active with 2 out of 2 mirrors
Aug  6 20:07:02 mythical kernel: kjournald starting.  Commit interval 5 seconds
Aug  6 20:07:02 mythical kernel: EXT3 FS on hda2, internal journal
Aug  6 20:07:02 mythical kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug  6 20:07:02 mythical kernel: kjournald starting.  Commit interval 5 seconds
Aug  6 20:07:02 mythical kernel: EXT3 FS on md2, internal journal
Aug  6 20:07:02 mythical kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug  6 20:07:02 mythical kernel: kjournald starting.  Commit interval 5 seconds
Aug  6 20:07:02 mythical kernel: EXT3 FS on md0, internal journal
Aug  6 20:07:02 mythical kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug  6 20:07:02 mythical kernel: kjournald starting.  Commit interval 5 seconds
Aug  6 20:07:02 mythical kernel: EXT3 FS on md3, internal journal
Aug  6 20:07:02 mythical kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug  6 20:07:02 mythical kernel: kjournald starting.  Commit interval 5 seconds
Aug  6 20:07:02 mythical kernel: EXT3 FS on md5, internal journal
Aug  6 20:07:02 mythical kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug  6 20:07:02 mythical kernel: irda_init()
Aug  6 20:07:02 mythical kernel: NET: Registered protocol family 23
Aug  6 20:07:02 mythical kernel: USB Universal Host Controller Interface driver v2.3
Aug  6 20:07:02 mythical kernel: ACPI: PCI Interrupt 0000:00:11.2[D] -> Link [LNKD] -> GSI 10 (level, low) -> IRQ 10
Aug  6 20:07:02 mythical kernel: uhci_hcd 0000:00:11.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
Aug  6 20:07:02 mythical kernel: uhci_hcd 0000:00:11.2: new USB bus registered, assigned bus number 1
Aug  6 20:07:02 mythical kernel: uhci_hcd 0000:00:11.2: irq 10, io base 0x0000d800
Aug  6 20:07:02 mythical kernel: hub 1-0:1.0: USB hub found
Aug  6 20:07:02 mythical kernel: hub 1-0:1.0: 2 ports detected
Aug  6 20:07:02 mythical kernel: ACPI: PCI Interrupt 0000:00:11.3[D] -> Link [LNKD] -> GSI 10 (level, low) -> IRQ 10
Aug  6 20:07:02 mythical kernel: uhci_hcd 0000:00:11.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
Aug  6 20:07:02 mythical kernel: uhci_hcd 0000:00:11.3: new USB bus registered, assigned bus number 2
Aug  6 20:07:02 mythical kernel: uhci_hcd 0000:00:11.3: irq 10, io base 0x0000dc00
Aug  6 20:07:02 mythical kernel: hub 2-0:1.0: USB hub found
Aug  6 20:07:02 mythical kernel: hub 2-0:1.0: 2 ports detected
Aug  6 20:07:02 mythical kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
Aug  6 20:07:02 mythical kernel: PCI: setting IRQ 5 as level-triggered
Aug  6 20:07:02 mythical kernel: ACPI: PCI Interrupt 0000:00:11.5[C] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
Aug  6 20:07:02 mythical kernel: PCI: Setting latency timer of device 0000:00:11.5 to 64
Aug  6 20:07:02 mythical kernel: agpgart: Detected VIA KT266/KY266x/KT333 chipset
Aug  6 20:07:02 mythical kernel: agpgart: AGP aperture is 128M @ 0xd0000000
Aug  6 20:07:02 mythical kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
Aug  6 20:07:02 mythical kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Aug  6 20:07:02 mythical kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Aug  6 20:07:02 mythical kernel: pnp: the driver 'serial' has been registered
Aug  6 20:07:02 mythical kernel: pnp: match found with the PnP device '00:07' and the driver 'serial'
Aug  6 20:07:02 mythical kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Aug  6 20:07:02 mythical kernel: pnp: match found with the PnP device '00:08' and the driver 'serial'
Aug  6 20:07:02 mythical kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Aug  6 20:07:02 mythical kernel: pnp: the driver 'parport_pc' has been registered
Aug  6 20:07:02 mythical kernel: pnp: match found with the PnP device '00:09' and the driver 'parport_pc'
Aug  6 20:07:02 mythical kernel: parport: PnPBIOS parport detected.
Aug  6 20:07:02 mythical kernel: parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
Aug  6 20:07:02 mythical kernel: ts: Compaq touchscreen protocol output
Aug  6 20:07:02 mythical kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug  6 20:07:02 mythical kernel: NET: Registered protocol family 10
Aug  6 20:07:02 mythical kernel: Disabled Privacy Extensions on device c04d6920(lo)
Aug  6 20:07:02 mythical kernel: IPv6 over IPv4 tunneling driver
Aug  6 20:07:10 mythical kernel: eth0: no IPv6 routers present
Aug  6 20:07:13 mythical kernel: lp0: using parport0 (interrupt-driven).
Aug  6 20:07:20 mythical l2tpd[3600]: This binary does not support kernel L2TP. 
Aug  6 20:07:26 mythical kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Aug  6 20:07:26 mythical kernel: NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
Aug  6 20:07:26 mythical kernel: NFSD: recovery directory /var/lib/nfs/v4recovery doesn't exist
Aug  6 20:07:26 mythical kernel: NFSD: starting 90-second grace period
Aug  6 20:07:36 mythical kernel: crc32c: Unknown symbol crc32c_le
Aug  6 20:07:36 mythical kernel: ipcomp6: Unknown symbol xfrm6_tunnel_free_spi
Aug  6 20:07:36 mythical kernel: ipcomp6: Unknown symbol xfrm6_tunnel_alloc_spi
Aug  6 20:07:36 mythical kernel: ipcomp6: Unknown symbol xfrm6_tunnel_spi_lookup
Aug  6 20:07:46 mythical ntpd[4127]: kernel time sync status 0040
Aug  6 20:07:57 mythical kernel: ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Aug  6 20:07:57 mythical kernel: [drm] Initialized radeon 1.16.0 20050311 on minor 0: ATI Technologies Inc RV280 [Radeon 9200 PRO]
Aug  6 20:07:57 mythical kernel: agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
Aug  6 20:07:57 mythical kernel: agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
Aug  6 20:07:57 mythical kernel: agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
Aug  6 20:07:57 mythical kernel: [drm] Loading R200 Microcode
Aug  6 20:10:52 mythical kernel: CSLIP: code copyright 1989 Regents of the University of California
Aug  6 20:10:52 mythical kernel: PPP generic driver version 2.4.2
Aug  6 20:10:53 mythical kernel: PPP BSD Compression module registered
Aug  6 20:10:53 mythical kernel: PPP Deflate Compression module registered
Aug  6 20:12:09 mythical ntpd[4127]: kernel time sync disabled 0041
Aug  6 20:15:21 mythical ntpd[4127]: kernel time sync enabled 0001
Aug  6 22:48:49 mythical kernel: hdb: irq timeout: status=0xd0 { Busy }
Aug  6 22:48:54 mythical kernel: ide: failed opcode was: unknown
Aug  6 22:48:54 mythical kernel: ide0: reset: success
Aug  6 22:48:57 mythical kernel: Unable to handle kernel paging request at virtual address 6b6b6b6b
Aug  6 22:48:57 mythical kernel:  printing eip:
Aug  6 22:48:57 mythical kernel: c0188d15
Aug  6 22:48:57 mythical kernel: *pde = 00000000
Aug  6 22:48:57 mythical kernel: Oops: 0000 [#1]
Aug  6 22:48:57 mythical kernel: PREEMPT 
Aug  6 22:48:57 mythical kernel: Modules linked in: ppp_deflate bsd_comp ppp_async ppp_generic slhc radeon esp6 ah6 wp512 tgr192 tea khazad michael_mic cast6 cast5 arc4 anubis nfsd exportfs lp binfmt_misc ipv6 tsdev evdev analog parport_pc parport 8250_pnp 8250 serial_core via_agp serpent aes_i586 crypto_null snd_via82xx gameport snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore uhci_hcd via_ircc irda dm_mod r8169 raid5 xor tulip via drm agpgart cpuid smbfs usbkbd usbcore trm290 triflex sc1200 ns87415 it821x cy82c693 cs5530 cs5520 atiixp raid1 md_mod
Aug  6 22:48:57 mythical kernel: CPU:    0
Aug  6 22:48:57 mythical kernel: EIP:    0060:[inotify_inode_queue_event+85/336]    Not tainted VLI
Aug  6 22:48:57 mythical kernel: EFLAGS: 00010206   (2.6.13-rc5-g0d317fb7) 
Aug  6 22:48:57 mythical kernel: EIP is at inotify_inode_queue_event+0x55/0x150
Aug  6 22:48:57 mythical kernel: eax: 6b6b6b6b   ebx: 6b6b6b63   ecx: 00000000   edx: 00000066
Aug  6 22:48:57 mythical kernel: esi: c3effe34   edi: ce8c76ac   ebp: d4bb864c   esp: d8655eb0
Aug  6 22:48:57 mythical kernel: ds: 007b   es: 007b   ss: 0068
Aug  6 22:48:57 mythical kernel: Process nfsd (pid: 3750, threadinfo=d8654000 task=d6155020)
Aug  6 22:48:57 mythical kernel: Stack: 00000286 00000286 00000000 00000400 d4bb8760 d4bb8768 00000000 c3effe34 
Aug  6 22:48:57 mythical kernel:        ce8c76ac d4bb864c c0170626 00000000 c3effe34 d6608ad4 db74b17c c3effe34 
Aug  6 22:48:57 mythical kernel:        e0cfe9a4 00000013 e0d01b34 c0dd91b4 ce8c76ac ffffc000 d66092dc d66093c4 
Aug  6 22:48:57 mythical kernel: Call Trace:
Aug  6 22:48:57 mythical kernel:  [vfs_unlink+358/560] vfs_unlink+0x166/0x230
Aug  6 22:48:57 mythical kernel:  [pg0+544348580/1067586560] nfsd_unlink+0x104/0x230 [nfsd]
Aug  6 22:48:57 mythical kernel:  [pg0+544361268/1067586560] nfsd_cache_lookup+0x1c4/0x3c0 [nfsd]
Aug  6 22:48:57 mythical kernel:  [pg0+544371728/1067586560] nfsd3_proc_remove+0x80/0xc0 [nfsd]
Aug  6 22:48:57 mythical kernel:  [pg0+544381018/1067586560] nfs3svc_decode_diropargs+0x8a/0x100 [nfsd]
Aug  6 22:48:57 mythical kernel:  [pg0+544380880/1067586560] nfs3svc_decode_diropargs+0x0/0x100 [nfsd]
Aug  6 22:48:57 mythical kernel:  [pg0+544321698/1067586560] nfsd_dispatch+0x82/0x1f0 [nfsd]
Aug  6 22:48:57 mythical kernel:  [svc_authenticate+112/336] svc_authenticate+0x70/0x150
Aug  6 22:48:57 mythical kernel:  [svc_process+960/1648] svc_process+0x3c0/0x670
Aug  6 22:48:57 mythical kernel:  [pg0+544323105/1067586560] nfsd+0x1a1/0x350 [nfsd]
Aug  6 22:48:57 mythical kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
Aug  6 22:48:57 mythical kernel:  [pg0+544322688/1067586560] nfsd+0x0/0x350 [nfsd]
Aug  6 22:48:57 mythical kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Aug  6 22:48:57 mythical kernel: Code: 01 00 00 b8 ce c4 40 c0 89 54 24 14 ba 66 00 00 00 e8 50 ea f8 ff ff 8b 1c 01 00 00 0f 88 ae 03 00 00 8b 83 14 01 00 00 8d 58 f8 <8b> 6b 08 83 ed 08 39 44 24 10 75 1c e9 aa 00 00 00 8b 55 08 8d 
Aug  6 22:51:34 mythical kernel:  hdb: irq timeout: status=0xd0 { Busy }
Aug  6 22:51:34 mythical kernel: ide: failed opcode was: unknown
Aug  6 22:52:05 mythical kernel: ide0: reset timed-out, status=0xd0
Aug  6 22:52:36 mythical kernel: hdb: status error: status=0x7f { DriveReady DeviceFault SeekComplete DataRequest CorrectedError Index Error }
Aug  6 22:52:36 mythical kernel: hdb: status error: error=0x7f { DriveStatusError UncorrectableError SectorIdNotFound TrackZeroNotFound AddrMarkNotFound }, LBAsect=260013951, sector=23920575
Aug  6 22:52:36 mythical kernel: ide: failed opcode was: unknown
Aug  6 22:52:36 mythical kernel: hdb: drive not ready for command
Aug  6 22:52:36 mythical kernel: ide0: reset: success
Aug  6 22:52:57 mythical kernel: hdb: irq timeout: status=0xd0 { Busy }
Aug  6 22:52:57 mythical kernel: ide: failed opcode was: unknown
Aug  6 22:53:28 mythical kernel: ide0: reset timed-out, status=0xd0
Aug  6 22:53:28 mythical kernel: hdb: status error: status=0x7f { DriveReady DeviceFault SeekComplete DataRequest CorrectedError Index Error }
Aug  6 22:53:28 mythical kernel: hdb: status error: error=0x7f { DriveStatusError UncorrectableError SectorIdNotFound TrackZeroNotFound AddrMarkNotFound }, LBAsect=260013951, sector=15413575
Aug  6 22:53:28 mythical kernel: ide: failed opcode was: unknown
Aug  6 22:53:28 mythical kernel: hdb: drive not ready for command
Aug  6 22:53:59 mythical kernel: ide0: reset timed-out, status=0xd0
Aug  6 22:54:00 mythical kernel: end_request: I/O error, dev hdb, sector 15413575
Aug  6 22:54:00 mythical kernel: raid5: Disk failure on hdb1, disabling device. Operation continuing on 2 devices
Aug  6 22:54:01 mythical kernel: end_request: I/O error, dev hdb, sector 23920575
Aug  6 22:54:01 mythical kernel: RAID5 conf printout:
Aug  6 22:54:01 mythical kernel:  --- rd:3 wd:2 fd:1
Aug  6 22:54:01 mythical kernel:  disk 0, o:1, dev:hdc1
Aug  6 22:54:01 mythical kernel:  disk 1, o:1, dev:hdd3
Aug  6 22:54:01 mythical kernel:  disk 2, o:0, dev:hdb1
Aug  6 22:54:01 mythical kernel: RAID5 conf printout:
Aug  6 22:54:01 mythical kernel:  --- rd:3 wd:2 fd:1
Aug  6 22:54:01 mythical kernel:  disk 0, o:1, dev:hdc1
Aug  6 22:54:01 mythical kernel:  disk 1, o:1, dev:hdd3
Aug  6 22:54:01 mythical kernel: end_request: I/O error, dev hdb, sector 190578257
Aug  6 22:54:01 mythical kernel: raid5: Disk failure on hdb3, disabling device. Operation continuing on 2 devices
Aug  6 22:54:02 mythical kernel: end_request: I/O error, dev hdb, sector 190578265
Aug  6 22:54:02 mythical kernel: end_request: I/O error, dev hdb, sector 190578273
Aug  6 22:54:02 mythical kernel: end_request: I/O error, dev hdb, sector 190578281
Aug  6 22:54:02 mythical kernel: end_request: I/O error, dev hdb, sector 240107281
Aug  6 22:54:02 mythical kernel: RAID5 conf printout:
Aug  6 22:54:02 mythical kernel:  --- rd:3 wd:2 fd:1
Aug  6 22:54:02 mythical kernel:  disk 0, o:1, dev:hdc3
Aug  6 22:54:02 mythical kernel:  disk 1, o:1, dev:hdd1
Aug  6 22:54:02 mythical kernel:  disk 2, o:0, dev:hdb3
Aug  6 22:54:02 mythical kernel: RAID5 conf printout:
Aug  6 22:54:02 mythical kernel:  --- rd:3 wd:2 fd:1
Aug  6 22:54:02 mythical kernel:  disk 0, o:1, dev:hdc3
Aug  6 22:54:02 mythical kernel:  disk 1, o:1, dev:hdd1
Aug  6 22:54:02 mythical kernel: end_request: I/O error, dev hdb, sector 25976977
Aug  6 22:54:02 mythical kernel: raid1: Disk failure on hdb2, disabling device. 
Aug  6 22:54:02 mythical kernel: ^IOperation continuing on 1 devices
Aug  6 22:54:02 mythical kernel: RAID1 conf printout:
Aug  6 22:54:02 mythical kernel:  --- wd:1 rd:2
Aug  6 22:54:02 mythical kernel:  disk 0, wo:1, o:0, dev:hdb2
Aug  6 22:54:02 mythical kernel:  disk 1, wo:0, o:1, dev:hdd2
Aug  6 22:54:02 mythical kernel: RAID1 conf printout:
Aug  6 22:54:02 mythical kernel:  --- wd:1 rd:2
Aug  6 22:54:02 mythical kernel:  disk 1, wo:0, o:1, dev:hdd2
Aug  6 22:55:38 mythical kernel: agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
Aug  6 22:55:38 mythical kernel: agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
Aug  6 22:55:38 mythical kernel: agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
Aug  6 22:55:38 mythical kernel: [drm] Loading R200 Microcode
Aug  6 22:57:15 mythical kernel: Slab corruption: start=d4bb85c0, len=464
Aug  6 22:57:15 mythical kernel: Redzone: 0x5a2cf071/0x5a2cf071.
Aug  6 22:57:15 mythical kernel: Last user: [destroy_inode+63/80](destroy_inode+0x3f/0x50)
Aug  6 22:57:15 mythical kernel: 1a0: 6b 6b 6b 6b 6b 6b 6b 6b 6a 6b 6b 6b 6b 6b 6b 6b
Aug  6 22:57:15 mythical kernel: Prev obj: start=d4bb83e4, len=464
Aug  6 22:57:15 mythical kernel: Redzone: 0x170fc2a5/0x170fc2a5.
Aug  6 22:57:15 mythical kernel: Last user: [ext3_alloc_inode+15/48](ext3_alloc_inode+0xf/0x30)
Aug  6 22:57:15 mythical kernel: 000: c2 b6 3c 00 00 00 00 00 00 00 00 00 00 00 00 00
Aug  6 22:57:15 mythical kernel: 010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Aug  6 22:57:15 mythical kernel: Next obj: start=d4bb879c, len=464
Aug  6 22:57:15 mythical kernel: Redzone: 0x170fc2a5/0x170fc2a5.
Aug  6 22:57:15 mythical kernel: Last user: [ext3_alloc_inode+15/48](ext3_alloc_inode+0xf/0x30)
Aug  6 22:57:15 mythical kernel: 000: c1 b6 3c 00 00 00 00 00 00 00 00 00 00 00 00 00
Aug  6 22:57:15 mythical kernel: 010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Aug  6 23:03:13 mythical kernel: Kernel logging (proc) stopped.
Aug  6 23:03:13 mythical kernel: Kernel log daemon terminating.
Aug  6 23:28:05 mythical kernel: klogd 1.4.1#17, log source = /proc/kmsg started.
Aug  6 23:28:05 mythical kernel: Inspecting /boot/System.map-2.6.12-rc3
Aug  6 23:28:05 mythical kernel: Loaded 33827 symbols from /boot/System.map-2.6.12-rc3.
Aug  6 23:28:05 mythical kernel: Symbols match kernel version 2.6.12.
Aug  6 23:28:05 mythical kernel: No module symbols loaded - kernel modules not enabled. 
Aug  6 23:28:05 mythical kernel: ing serpent ECB encryption 
Aug  6 23:28:05 mythical kernel: failed to load transform for serpent ECB
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing serpent ECB decryption 
Aug  6 23:28:05 mythical kernel: failed to load transform for serpent ECB
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing tnepres ECB encryption 
Aug  6 23:28:05 mythical kernel: failed to load transform for tnepres ECB
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing tnepres ECB decryption 
Aug  6 23:28:05 mythical kernel: failed to load transform for tnepres ECB
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing aes ECB encryption 
Aug  6 23:28:05 mythical kernel: failed to load transform for aes ECB
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing aes ECB decryption 
Aug  6 23:28:05 mythical kernel: failed to load transform for aes ECB
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing cast5 ECB encryption 
Aug  6 23:28:05 mythical kernel: failed to load transform for cast5 ECB
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing cast5 ECB decryption 
Aug  6 23:28:05 mythical kernel: failed to load transform for cast5 ECB
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing cast6 ECB encryption 
Aug  6 23:28:05 mythical kernel: failed to load transform for cast6 ECB
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing cast6 ECB decryption 
Aug  6 23:28:05 mythical kernel: failed to load transform for cast6 ECB
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing arc4 ECB encryption 
Aug  6 23:28:05 mythical kernel: failed to load transform for arc4 ECB
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing arc4 ECB decryption 
Aug  6 23:28:05 mythical kernel: failed to load transform for arc4 ECB
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing tea ECB encryption 
Aug  6 23:28:05 mythical kernel: failed to load transform for tea ECB
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing tea ECB decryption 
Aug  6 23:28:05 mythical kernel: failed to load transform for tea ECB
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing xtea ECB encryption 
Aug  6 23:28:05 mythical kernel: failed to load transform for xtea ECB
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing xtea ECB decryption 
Aug  6 23:28:05 mythical kernel: failed to load transform for xtea ECB
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing khazad ECB encryption 
Aug  6 23:28:05 mythical kernel: failed to load transform for khazad ECB
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing khazad ECB decryption 
Aug  6 23:28:05 mythical kernel: failed to load transform for khazad ECB
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing anubis ECB encryption 
Aug  6 23:28:05 mythical kernel: failed to load transform for anubis ECB
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing anubis ECB decryption 
Aug  6 23:28:05 mythical kernel: failed to load transform for anubis ECB
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing anubis CBC encryption 
Aug  6 23:28:05 mythical kernel: failed to load transform for anubis CBC
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing anubis CBC decryption 
Aug  6 23:28:05 mythical kernel: failed to load transform for anubis CBC
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing sha384
Aug  6 23:28:05 mythical kernel: test 1:
Aug  6 23:28:05 mythical kernel: cb00753f45a35e8bb5a03d699ac65007272c32ab0eded1631a8b605a43ff5bed8086072ba1e7cc2358baeca134c825a7
Aug  6 23:28:05 mythical kernel: pass
Aug  6 23:28:05 mythical kernel: test 2:
Aug  6 23:28:05 mythical kernel: 3391fdddfc8dc7393707a65b1b4709397cf8b1d162af05abfe8f450de5f36bc6b0455a8520bc4e6f5fe95b1fe3c8452b
Aug  6 23:28:05 mythical kernel: pass
Aug  6 23:28:05 mythical kernel: test 3:
Aug  6 23:28:05 mythical kernel: 09330c33f71147e83d192fc782cd1b4753111b173b3b05d22fa08086e3b0f712fcc7c71a557e2db966c3e9fa91746039
Aug  6 23:28:05 mythical kernel: pass
Aug  6 23:28:05 mythical kernel: test 4:
Aug  6 23:28:05 mythical kernel: 3d208973ab3508dbbd7e2c2862ba290ad3010e4978c198dc4d8fd014e582823a89e16f9b2a7bbc1ac938e2d199e8bea4
Aug  6 23:28:05 mythical kernel: pass
Aug  6 23:28:05 mythical kernel: testing sha384 across pages
Aug  6 23:28:05 mythical kernel: test 1:
Aug  6 23:28:05 mythical kernel: 3d208973ab3508dbbd7e2c2862ba290ad3010e4978c198dc4d8fd014e582823a89e16f9b2a7bbc1ac938e2d199e8bea4
Aug  6 23:28:05 mythical kernel: pass
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing sha512
Aug  6 23:28:05 mythical kernel: test 1:
Aug  6 23:28:05 mythical kernel: ddaf35a193617abacc417349ae20413112e6fa4e89a97ea20a9eeee64b55d39a2192992a274fc1a836ba3c23a3feebbd454d4423643ce80e2a9ac94fa54ca49f
Aug  6 23:28:05 mythical kernel: pass
Aug  6 23:28:05 mythical kernel: test 2:
Aug  6 23:28:05 mythical kernel: 204a8fc6dda82f0a0ced7beb8e08a41657c16ef468b228a8279be331a703c33596fd15c13b1b07f9aa1d3bea57789ca031ad85c7a71dd70354ec631238ca3445
Aug  6 23:28:05 mythical kernel: pass
Aug  6 23:28:05 mythical kernel: test 3:
Aug  6 23:28:05 mythical kernel: 8e959b75dae313da8cf4f72814fc143f8f7779c6eb9f7fa17299aeadb6889018501d289e4900f7e4331b99dec4b5433ac7d329eeb6dd26545e96e55b874be909
Aug  6 23:28:05 mythical kernel: pass
Aug  6 23:28:05 mythical kernel: test 4:
Aug  6 23:28:05 mythical kernel: 930d0cefcb30ff1133b6898121f1cf3d27578afcafe8677c5257cf069911f75d8f5831b56ebfda67b278e66dff8b84fe2b2870f742a580d8edb41987232850c9
Aug  6 23:28:05 mythical kernel: pass
Aug  6 23:28:05 mythical kernel: testing sha512 across pages
Aug  6 23:28:05 mythical kernel: test 1:
Aug  6 23:28:05 mythical kernel: 930d0cefcb30ff1133b6898121f1cf3d27578afcafe8677c5257cf069911f75d8f5831b56ebfda67b278e66dff8b84fe2b2870f742a580d8edb41987232850c9
Aug  6 23:28:05 mythical kernel: pass
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing wp512
Aug  6 23:28:05 mythical kernel: failed to load transform for wp512
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing wp384
Aug  6 23:28:05 mythical kernel: failed to load transform for wp384
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing wp256
Aug  6 23:28:05 mythical kernel: failed to load transform for wp256
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing tgr192
Aug  6 23:28:05 mythical kernel: failed to load transform for tgr192
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing tgr160
Aug  6 23:28:05 mythical kernel: failed to load transform for tgr160
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing tgr128
Aug  6 23:28:05 mythical kernel: failed to load transform for tgr128
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing deflate compression
Aug  6 23:28:05 mythical kernel: test 1:
Aug  6 23:28:05 mythical kernel: f3cacfcc53282d56c8cb2f5748cc4b5128ce482c4a5528c9485528ce4f2b290771bc082b0100
Aug  6 23:28:05 mythical kernel: pass (ratio 70:38)
Aug  6 23:28:05 mythical kernel: test 2:
Aug  6 23:28:05 mythical kernel: 5d8d310ec2301004bfb22fc81f10040989c2853f70b12ff824db67d947c1ef49681251ae7667d62719881ade85ab21f2085d161e20042dadf318a215852d69c4428323b66c89719befcf8b9fcf33ca2fed62a94c80ff13af5237ed0e526b5902d94ee87a761d0298fe8a8783a34f568ab89e8e5c57d3a079fa02
Aug  6 23:28:05 mythical kernel: pass (ratio 191:122)
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing deflate decompression
Aug  6 23:28:05 mythical kernel: test 1:
Aug  6 23:28:05 mythical kernel: 5468697320646f63756d656e7420646573637269626573206120636f6d7072657373696f6e206d6574686f64206261736564206f6e20746865204445464c415445636f6d7072657373696f6e20616c676f726974686d2e20205468697320646f63756d656e7420646566696e657320746865206170706c69636174696f6e206f6620746865204445464c41544520616c676f726974686d20746f20746865204950205061796c6f616420436f6d7072657373696f6e2050726f746f636f6c2e
Aug  6 23:28:05 mythical kernel: pass (ratio 122:191)
Aug  6 23:28:05 mythical kernel: test 2:
Aug  6 23:28:05 mythical kernel: 4a6f696e207573206e6f7720616e642073686172652074686520736f667477617265204a6f696e207573206e6f7720616e642073686172652074686520736f66747761726520
Aug  6 23:28:05 mythical kernel: pass (ratio 38:70)
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing crc32c
Aug  6 23:28:05 mythical kernel: failed to load transform for crc32c
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing hmac_md5
Aug  6 23:28:05 mythical kernel: test 1:
Aug  6 23:28:05 mythical kernel: 9294727a3638bb1c13f48ef8158bfc9d
Aug  6 23:28:05 mythical kernel: pass
Aug  6 23:28:05 mythical kernel: test 2:
Aug  6 23:28:05 mythical kernel: 750c783e6ab0b503eaa86e310a5db738
Aug  6 23:28:05 mythical kernel: pass
Aug  6 23:28:05 mythical kernel: test 3:
Aug  6 23:28:05 mythical kernel: 56be34521d144c88dbb8c733f0e8b3f6
Aug  6 23:28:05 mythical kernel: pass
Aug  6 23:28:05 mythical kernel: test 4:
Aug  6 23:28:05 mythical kernel: 697eaf0aca3a3aea3a75164746ffaa79
Aug  6 23:28:05 mythical kernel: pass
Aug  6 23:28:05 mythical kernel: test 5:
Aug  6 23:28:05 mythical kernel: 56461ef2342edc00f9bab995690efd4c
Aug  6 23:28:05 mythical kernel: pass
Aug  6 23:28:05 mythical kernel: test 6:
Aug  6 23:28:05 mythical kernel: 6b1ab7fe4bd7bf8f0b62e6ce61b9d0cd
Aug  6 23:28:05 mythical kernel: pass
Aug  6 23:28:05 mythical kernel: test 7:
Aug  6 23:28:05 mythical kernel: 6f630fad67cda0ee1fb1f562db3aa53e
Aug  6 23:28:05 mythical kernel: pass
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing hmac_md5 across pages
Aug  6 23:28:05 mythical kernel: test 1:
Aug  6 23:28:05 mythical kernel: 750c783e6ab0b503eaa86e310a5db738
Aug  6 23:28:05 mythical kernel: pass
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing hmac_sha1
Aug  6 23:28:05 mythical kernel: test 1:
Aug  6 23:28:05 mythical kernel: b617318655057264e28bc0b6fb378c8ef146be00
Aug  6 23:28:05 mythical kernel: pass
Aug  6 23:28:05 mythical kernel: test 2:
Aug  6 23:28:05 mythical kernel: effcdf6ae5eb2fa2d27416d5f184df9c259a7c79
Aug  6 23:28:05 mythical kernel: pass
Aug  6 23:28:05 mythical kernel: test 3:
Aug  6 23:28:05 mythical kernel: 125d7342b9ac11cd91a39af48aa17b4f63f175d3
Aug  6 23:28:05 mythical kernel: pass
Aug  6 23:28:05 mythical kernel: test 4:
Aug  6 23:28:05 mythical kernel: 4c9007f4026250c6bc8414f9bf50c86c2d7235da
Aug  6 23:28:05 mythical kernel: pass
Aug  6 23:28:05 mythical kernel: test 5:
Aug  6 23:28:05 mythical kernel: 4c1a03424b55e07fe7f27be1d58bb9324a9a5a04
Aug  6 23:28:05 mythical kernel: pass
Aug  6 23:28:05 mythical kernel: test 6:
Aug  6 23:28:05 mythical kernel: aa4ae5e15272d00e95705637ce8a3b55ed402112
Aug  6 23:28:05 mythical kernel: pass
Aug  6 23:28:05 mythical kernel: test 7:
Aug  6 23:28:05 mythical kernel: e8e99d0f45237d786d6bbaa7965c7808bbff1a91
Aug  6 23:28:05 mythical kernel: pass
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing hmac_sha1 across pages
Aug  6 23:28:05 mythical kernel: test 1:
Aug  6 23:28:05 mythical kernel: effcdf6ae5eb2fa2d27416d5f184df9c259a7c79
Aug  6 23:28:05 mythical kernel: pass
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing hmac_sha256
Aug  6 23:28:05 mythical kernel: test 1:
Aug  6 23:28:05 mythical kernel: a21b1f5d4cf4f73a4dd939750f7a066a7f98cc131cb16a6692759021cfab8181
Aug  6 23:28:05 mythical kernel: pass
Aug  6 23:28:05 mythical kernel: test 2:
Aug  6 23:28:05 mythical kernel: 104fdc1257328f08184ba73131c53caee698e36119421149ea8c712456697d30
Aug  6 23:28:05 mythical kernel: pass
Aug  6 23:28:05 mythical kernel: test 3:
Aug  6 23:28:05 mythical kernel: 470305fc7e40fe34d3eeb3e773d95aab73acf0fd060447a5eb4595bf33a9d1a3
Aug  6 23:28:05 mythical kernel: pass
Aug  6 23:28:05 mythical kernel: test 4:
Aug  6 23:28:05 mythical kernel: 198a607eb44bfbc69903a0f1cf2bbdc5ba0aa3f3d9ae3c1c7a3b1696a0b68cf7
Aug  6 23:28:05 mythical kernel: pass
Aug  6 23:28:05 mythical kernel: test 5:
Aug  6 23:28:05 mythical kernel: 5bdcc146bf60754e6a042426089575c75a003f089d2739839dec58b964ec3843
Aug  6 23:28:05 mythical kernel: pass
Aug  6 23:28:05 mythical kernel: test 6:
Aug  6 23:28:05 mythical kernel: cdcb1220d1ecccea91e53aba3092f962e549fe6ce9ed7fdc43191fbde45c30b0
Aug  6 23:28:05 mythical kernel: pass
Aug  6 23:28:05 mythical kernel: test 7:
Aug  6 23:28:05 mythical kernel: d4633c17f6fb8d744c66dee0f8f074556ec4af55ef07998541468eb49bd2e917
Aug  6 23:28:05 mythical kernel: pass
Aug  6 23:28:05 mythical kernel: test 8:
Aug  6 23:28:05 mythical kernel: 7546af01841fc09b1ab9c3749a5f1c17d4f589668a587b2700a9c97c1193cf42
Aug  6 23:28:05 mythical kernel: pass
Aug  6 23:28:05 mythical kernel: test 9:
Aug  6 23:28:05 mythical kernel: 6953025ed96f0c09f80a96f78e6538dbe2e7b820e3dd970e7ddd39091b32352f
Aug  6 23:28:05 mythical kernel: pass
Aug  6 23:28:05 mythical kernel: test 10:
Aug  6 23:28:05 mythical kernel: 6355ac22e890d0a3c8481a5ca4825bc884d3e7a1ff98a2fc2ac7d8e064c3b2e6
Aug  6 23:28:05 mythical kernel: pass
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing hmac_sha256 across pages
Aug  6 23:28:05 mythical kernel: test 1:
Aug  6 23:28:05 mythical kernel: 5bdcc146bf60754e6a042426089575c75a003f089d2739839dec58b964ec3843
Aug  6 23:28:05 mythical kernel: pass
Aug  6 23:28:05 mythical kernel: 
Aug  6 23:28:05 mythical kernel: testing michael_mic
Aug  6 23:28:05 mythical kernel: failed to load transform for michael_mic
Aug  6 23:28:05 mythical kernel: ACPI: CPU0 (power states: C1[C1] C2[C2])
Aug  6 23:28:05 mythical kernel: ACPI: Thermal Zone [THRM] (49 C)
Aug  6 23:28:05 mythical kernel: isapnp: Scanning for PnP cards...
Aug  6 23:28:05 mythical kernel: isapnp: No Plug & Play device found
Aug  6 23:28:05 mythical kernel: Real Time Clock Driver v1.12
Aug  6 23:28:05 mythical kernel: pnp: the driver 'i8042 kbd' has been registered
Aug  6 23:28:05 mythical kernel: pnp: match found with the PnP device '00:0a' and the driver 'i8042 kbd'
Aug  6 23:28:05 mythical kernel: pnp: the driver 'i8042 aux' has been registered
Aug  6 23:28:05 mythical kernel: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 10
Aug  6 23:28:05 mythical kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Aug  6 23:28:05 mythical kernel: io scheduler noop registered
Aug  6 23:28:05 mythical kernel: io scheduler anticipatory registered
Aug  6 23:28:05 mythical kernel: io scheduler deadline registered
Aug  6 23:28:05 mythical kernel: io scheduler cfq registered
Aug  6 23:28:05 mythical kernel: Floppy drive(s): fd0 is 1.44M
Aug  6 23:28:05 mythical kernel: FDC 0 is a post-1991 82077
Aug  6 23:28:05 mythical kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Aug  6 23:28:05 mythical kernel: loop: loaded (max 8 devices)
Aug  6 23:28:05 mythical kernel: Compaq SMART2 Driver (v 2.6.0)
Aug  6 23:28:05 mythical kernel: HP CISS Driver (v 2.6.6)
Aug  6 23:28:05 mythical kernel: 8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
Aug  6 23:28:05 mythical kernel: 8139cp: pci dev 0000:00:0b.0 (id 10ec:8139 rev 10) is not an 8139C+ compatible chip
Aug  6 23:28:05 mythical kernel: 8139cp: Try the "8139too" driver instead.
Aug  6 23:28:06 mythical kernel: 8139too Fast Ethernet driver 0.9.27
Aug  6 23:28:06 mythical kernel: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
Aug  6 23:28:06 mythical kernel: PCI: setting IRQ 10 as level-triggered
Aug  6 23:28:06 mythical kernel: ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKD] -> GSI 10 (level, low) -> IRQ 10
Aug  6 23:28:06 mythical kernel: eth0: RealTek RTL8139 at 0xe0802000, 00:20:18:89:36:5f, IRQ 10
Aug  6 23:28:06 mythical kernel: eth0:  Identified 8139 chip type 'RTL-8139A'
Aug  6 23:28:06 mythical kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Aug  6 23:28:06 mythical kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Aug  6 23:28:06 mythical kernel: VP_IDE: IDE controller at PCI slot 0000:00:11.1
Aug  6 23:28:06 mythical kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
Aug  6 23:28:06 mythical kernel: PCI: setting IRQ 11 as level-triggered
Aug  6 23:28:06 mythical kernel: ACPI: PCI Interrupt 0000:00:11.1[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Aug  6 23:28:06 mythical kernel: VP_IDE: chipset revision 6
Aug  6 23:28:06 mythical kernel: VP_IDE: not 100%% native mode: will probe irqs later
Aug  6 23:28:06 mythical kernel: VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci0000:00:11.1
Aug  6 23:28:06 mythical kernel:     ide0: BM-DMA at 0xd400-0xd407, BIOS settings: hda:DMA, hdb:pio
Aug  6 23:28:06 mythical kernel:     ide1: BM-DMA at 0xd408-0xd40f, BIOS settings: hdc:DMA, hdd:DMA
Aug  6 23:28:06 mythical kernel: Probing IDE interface ide0...
Aug  6 23:28:06 mythical kernel: hda: WDC WD204BA, ATA DISK drive
Aug  6 23:28:06 mythical kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Aug  6 23:28:06 mythical kernel: Probing IDE interface ide1...
Aug  6 23:28:06 mythical kernel: hdc: Maxtor 6Y120L4, ATA DISK drive
Aug  6 23:28:06 mythical kernel: hdd: ST3160023A, ATA DISK drive
Aug  6 23:28:06 mythical kernel: ide1 at 0x170-0x177,0x376 on irq 15
Aug  6 23:28:06 mythical kernel: pnp: the driver 'ide' has been registered
Aug  6 23:28:06 mythical kernel: Probing IDE interface ide2...
Aug  6 23:28:06 mythical kernel: Probing IDE interface ide3...
Aug  6 23:28:06 mythical kernel: Probing IDE interface ide4...
Aug  6 23:28:06 mythical kernel: Probing IDE interface ide5...
Aug  6 23:28:06 mythical kernel: hda: max request size: 128KiB
Aug  6 23:28:06 mythical kernel: hda: 39876480 sectors (20416 MB) w/2048KiB Cache, CHS=39560/16/63
Aug  6 23:28:06 mythical kernel: hda: cache flushes not supported
Aug  6 23:28:06 mythical kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 >
Aug  6 23:28:06 mythical kernel: hdc: max request size: 1024KiB
Aug  6 23:28:06 mythical kernel: hdc: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=16383/255/63
Aug  6 23:28:06 mythical kernel: hdc: cache flushes supported
Aug  6 23:28:06 mythical kernel:  /dev/ide/host0/bus1/target0/lun0: p1 p2 p3
Aug  6 23:28:06 mythical kernel: hdd: max request size: 1024KiB
Aug  6 23:28:06 mythical kernel: hdd: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63
Aug  6 23:28:06 mythical kernel: hdd: cache flushes supported
Aug  6 23:28:06 mythical kernel:  /dev/ide/host0/bus1/target1/lun0: p1 p2 p3 p4 < p5 p6 >
Aug  6 23:28:06 mythical kernel: ide-floppy driver 0.99.newide
Aug  6 23:28:06 mythical kernel: 3ware Storage Controller device driver for Linux v1.26.02.001.
Aug  6 23:28:06 mythical kernel: mice: PS/2 mouse device common for all mice
Aug  6 23:28:06 mythical kernel: input: PC Speaker
Aug  6 23:28:06 mythical kernel: NET: Registered protocol family 2
Aug  6 23:28:06 mythical kernel: IP: routing cache hash table of 4096 buckets, 32Kbytes
Aug  6 23:28:06 mythical kernel: TCP established hash table entries: 32768 (order: 6, 262144 bytes)
Aug  6 23:28:06 mythical kernel: TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
Aug  6 23:28:06 mythical kernel: TCP: Hash tables configured (established 32768 bind 32768)
Aug  6 23:28:06 mythical kernel: Initializing IPsec netlink socket
Aug  6 23:28:06 mythical kernel: NET: Registered protocol family 1
Aug  6 23:28:06 mythical kernel: NET: Registered protocol family 17
Aug  6 23:28:06 mythical kernel: NET: Registered protocol family 15
Aug  6 23:28:06 mythical kernel: PM: Checking swsusp image.
Aug  6 23:28:06 mythical kernel: PM: Resume from disk failed.
Aug  6 23:28:06 mythical kernel: RAMDISK: cramfs filesystem found at block 0
Aug  6 23:28:06 mythical kernel: RAMDISK: Loading 2280KiB [1 disk] into ram disk... |^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^Hdone.
Aug  6 23:28:06 mythical kernel: VFS: Mounted root (cramfs filesystem) readonly.
Aug  6 23:28:06 mythical kernel: Freeing unused kernel memory: 212k freed
Aug  6 23:28:06 mythical kernel: md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
Aug  6 23:28:06 mythical kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Aug  6 23:28:06 mythical kernel: md: raid1 personality registered as nr 3
Aug  6 23:28:06 mythical kernel: devfs_mk_dev: could not append to parent for md/1
Aug  6 23:28:06 mythical kernel: md: md1 stopped.
Aug  6 23:28:06 mythical kernel: md: bind<hdd2>
Aug  6 23:28:06 mythical kernel: raid1: raid set md1 active with 1 out of 2 mirrors
Aug  6 23:28:06 mythical kernel: devfs_mk_dev: could not append to parent for md/4
Aug  6 23:28:06 mythical kernel: md: md4 stopped.
Aug  6 23:28:06 mythical kernel: md: bind<hdc2>
Aug  6 23:28:06 mythical kernel: md: bind<hda1>
Aug  6 23:28:06 mythical kernel: raid1: raid set md4 active with 2 out of 2 mirrors
Aug  6 23:28:06 mythical kernel: ReiserFS: md4: warning: sh-2021: reiserfs_fill_super: can not find reiserfs on md4
Aug  6 23:28:06 mythical kernel: kjournald starting.  Commit interval 5 seconds
Aug  6 23:28:06 mythical kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug  6 23:28:06 mythical kernel: Adding 1028088k swap on /dev/md1.  Priority:-1 extents:1
Aug  6 23:28:06 mythical kernel: EXT3 FS on md4, internal journal
Aug  6 23:28:06 mythical kernel: usbcore: registered new driver usbfs
Aug  6 23:28:06 mythical kernel: usbcore: registered new driver hub
Aug  6 23:28:06 mythical kernel: usbcore: registered new driver usbkbd
Aug  6 23:28:06 mythical kernel: /home/ryan/dev/linux/linux-git/drivers/usb/input/usbkbd.c: :USB HID Boot Protocol keyboard driver
Aug  6 23:28:06 mythical kernel: Linux Tulip driver version 1.1.13 (May 11, 2002)
Aug  6 23:28:06 mythical kernel: raid5: automatically using best checksumming function: pIII_sse
Aug  6 23:28:06 mythical kernel:    pIII_sse  :  1436.000 MB/sec
Aug  6 23:28:06 mythical kernel: raid5: using function: pIII_sse (1436.000 MB/sec)
Aug  6 23:28:06 mythical kernel: md: raid5 personality registered as nr 4
Aug  6 23:28:06 mythical kernel: device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
Aug  6 23:28:06 mythical kernel: devfs_mk_dev: could not append to parent for md/5
Aug  6 23:28:06 mythical kernel: md: md5 stopped.
Aug  6 23:28:06 mythical kernel: md: bind<hdd1>
Aug  6 23:28:06 mythical kernel: md: bind<hdc3>
Aug  6 23:28:06 mythical kernel: raid5: device hdc3 operational as raid disk 0
Aug  6 23:28:06 mythical kernel: raid5: device hdd1 operational as raid disk 1
Aug  6 23:28:06 mythical kernel: raid5: allocated 3164kB for md5
Aug  6 23:28:06 mythical kernel: raid5: raid level 5 set md5 active with 2 out of 3 devices, algorithm 0
Aug  6 23:28:06 mythical kernel: RAID5 conf printout:
Aug  6 23:28:06 mythical kernel:  --- rd:3 wd:2 fd:1
Aug  6 23:28:06 mythical kernel:  disk 0, o:1, dev:hdc3
Aug  6 23:28:06 mythical kernel:  disk 1, o:1, dev:hdd1
Aug  6 23:28:06 mythical kernel: devfs_mk_dev: could not append to parent for md/3
Aug  6 23:28:06 mythical kernel: md: md3 stopped.
Aug  6 23:28:06 mythical kernel: md: bind<hdd3>
Aug  6 23:28:06 mythical kernel: md: bind<hdc1>
Aug  6 23:28:06 mythical kernel: raid5: device hdc1 operational as raid disk 0
Aug  6 23:28:06 mythical kernel: raid5: device hdd3 operational as raid disk 1
Aug  6 23:28:06 mythical kernel: raid5: allocated 3164kB for md3
Aug  6 23:28:06 mythical kernel: raid5: raid level 5 set md3 active with 2 out of 3 devices, algorithm 2
Aug  6 23:28:06 mythical kernel: RAID5 conf printout:
Aug  6 23:28:06 mythical kernel:  --- rd:3 wd:2 fd:1
Aug  6 23:28:06 mythical kernel:  disk 0, o:1, dev:hdc1
Aug  6 23:28:06 mythical kernel:  disk 1, o:1, dev:hdd3
Aug  6 23:28:06 mythical kernel: devfs_mk_dev: could not append to parent for md/0
Aug  6 23:28:06 mythical kernel: md: md0 stopped.
Aug  6 23:28:06 mythical kernel: md: bind<hdd5>
Aug  6 23:28:06 mythical kernel: md: bind<hda5>
Aug  6 23:28:06 mythical kernel: raid1: raid set md0 active with 2 out of 2 mirrors
Aug  6 23:28:06 mythical kernel: devfs_mk_dev: could not append to parent for md/2
Aug  6 23:28:06 mythical kernel: md: md2 stopped.
Aug  6 23:28:06 mythical kernel: md: bind<hdd6>
Aug  6 23:28:06 mythical kernel: md: bind<hda7>
Aug  6 23:28:06 mythical kernel: raid1: raid set md2 active with 2 out of 2 mirrors
Aug  6 23:28:06 mythical kernel: kjournald starting.  Commit interval 5 seconds
Aug  6 23:28:06 mythical kernel: EXT3 FS on hda2, internal journal
Aug  6 23:28:06 mythical kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug  6 23:28:06 mythical kernel: kjournald starting.  Commit interval 5 seconds
Aug  6 23:28:06 mythical kernel: EXT3 FS on md2, internal journal
Aug  6 23:28:06 mythical kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug  6 23:28:06 mythical kernel: kjournald starting.  Commit interval 5 seconds
Aug  6 23:28:06 mythical kernel: EXT3 FS on md0, internal journal
Aug  6 23:28:06 mythical kernel: EXT3-fs: recovery complete.
Aug  6 23:28:06 mythical kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug  6 23:28:06 mythical kernel: kjournald starting.  Commit interval 5 seconds
Aug  6 23:28:06 mythical kernel: EXT3 FS on md3, internal journal
Aug  6 23:28:06 mythical kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug  6 23:28:06 mythical kernel: kjournald starting.  Commit interval 5 seconds
Aug  6 23:28:06 mythical kernel: EXT3 FS on md5, internal journal
Aug  6 23:28:06 mythical kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug  6 23:28:06 mythical kernel: irda_init()
Aug  6 23:28:06 mythical kernel: NET: Registered protocol family 23
Aug  6 23:28:06 mythical kernel: USB Universal Host Controller Interface driver v2.2
Aug  6 23:28:06 mythical kernel: ACPI: PCI Interrupt 0000:00:11.2[D] -> Link [LNKD] -> GSI 10 (level, low) -> IRQ 10
Aug  6 23:28:06 mythical kernel: uhci_hcd 0000:00:11.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
Aug  6 23:28:06 mythical kernel: uhci_hcd 0000:00:11.2: new USB bus registered, assigned bus number 1
Aug  6 23:28:06 mythical kernel: uhci_hcd 0000:00:11.2: irq 10, io base 0x0000d800
Aug  6 23:28:06 mythical kernel: hub 1-0:1.0: USB hub found
Aug  6 23:28:06 mythical kernel: hub 1-0:1.0: 2 ports detected
Aug  6 23:28:06 mythical kernel: ACPI: PCI Interrupt 0000:00:11.3[D] -> Link [LNKD] -> GSI 10 (level, low) -> IRQ 10
Aug  6 23:28:06 mythical kernel: uhci_hcd 0000:00:11.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
Aug  6 23:28:06 mythical kernel: uhci_hcd 0000:00:11.3: new USB bus registered, assigned bus number 2
Aug  6 23:28:06 mythical kernel: uhci_hcd 0000:00:11.3: irq 10, io base 0x0000dc00
Aug  6 23:28:06 mythical kernel: hub 2-0:1.0: USB hub found
Aug  6 23:28:06 mythical kernel: hub 2-0:1.0: 2 ports detected
Aug  6 23:28:06 mythical kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
Aug  6 23:28:06 mythical kernel: PCI: setting IRQ 5 as level-triggered
Aug  6 23:28:06 mythical kernel: ACPI: PCI Interrupt 0000:00:11.5[C] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
Aug  6 23:28:06 mythical kernel: PCI: Setting latency timer of device 0000:00:11.5 to 64
Aug  6 23:28:06 mythical kernel: Linux agpgart interface v0.101 (c) Dave Jones
Aug  6 23:28:06 mythical kernel: agpgart: Detected VIA KT266/KY266x/KT333 chipset
Aug  6 23:28:06 mythical kernel: agpgart: AGP aperture is 128M @ 0xd0000000
Aug  6 23:28:06 mythical kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
Aug  6 23:28:06 mythical kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Aug  6 23:28:06 mythical kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Aug  6 23:28:06 mythical kernel: pnp: the driver 'serial' has been registered
Aug  6 23:28:06 mythical kernel: pnp: match found with the PnP device '00:07' and the driver 'serial'
Aug  6 23:28:06 mythical kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Aug  6 23:28:06 mythical kernel: pnp: match found with the PnP device '00:08' and the driver 'serial'
Aug  6 23:28:06 mythical kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Aug  6 23:28:06 mythical kernel: pnp: the driver 'parport_pc' has been registered
Aug  6 23:28:06 mythical kernel: pnp: match found with the PnP device '00:09' and the driver 'parport_pc'
Aug  6 23:28:06 mythical kernel: parport: PnPBIOS parport detected.
Aug  6 23:28:06 mythical kernel: parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
Aug  6 23:28:06 mythical kernel: ts: Compaq touchscreen protocol output
Aug  6 23:28:06 mythical kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Aug  6 23:28:06 mythical kernel: nfs warning: mount version older than kernel
Aug  6 23:28:06 mythical kernel: NET: Registered protocol family 10
Aug  6 23:28:06 mythical kernel: Disabled Privacy Extensions on device c04bab60(lo)
Aug  6 23:28:06 mythical kernel: IPv6 over IPv4 tunneling driver
Aug  6 23:28:14 mythical kernel: eth0: no IPv6 routers present
Aug  6 23:28:17 mythical kernel: lp0: using parport0 (interrupt-driven).
Aug  6 23:28:23 mythical l2tpd[3429]: This binary does not support kernel L2TP. 
Aug  6 23:28:37 mythical kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Aug  6 23:28:43 mythical kernel: crc32c: Unknown symbol crc32c_le
Aug  6 23:28:44 mythical kernel: ipcomp6: Unknown symbol xfrm6_tunnel_free_spi
Aug  6 23:28:44 mythical kernel: ipcomp6: Unknown symbol xfrm6_tunnel_alloc_spi
Aug  6 23:28:44 mythical kernel: ipcomp6: Unknown symbol xfrm6_tunnel_spi_lookup
Aug  6 23:28:53 mythical ntpd[3964]: kernel time sync status 0040
Aug  6 23:29:07 mythical kernel: [drm] Initialized drm 1.0.0 20040925
Aug  6 23:29:08 mythical kernel: ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Aug  6 23:29:08 mythical kernel: [drm] Initialized radeon 1.16.0 20050311 on minor 0: ATI Technologies Inc RV280 [Radeon 9200 PRO]
Aug  6 23:29:08 mythical kernel: agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
Aug  6 23:29:08 mythical kernel: agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
Aug  6 23:29:08 mythical kernel: agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
Aug  6 23:29:08 mythical kernel: [drm] Loading R200 Microcode
Aug  6 23:32:23 mythical ntpd[3964]: kernel time sync disabled 0041
Aug  6 23:33:22 mythical kernel: agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
Aug  6 23:33:22 mythical kernel: agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
Aug  6 23:33:22 mythical kernel: agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
Aug  6 23:33:22 mythical kernel: [drm] Loading R200 Microcode
Aug  6 23:34:10 mythical kernel: CSLIP: code copyright 1989 Regents of the University of California
Aug  6 23:34:10 mythical kernel: PPP generic driver version 2.4.2
Aug  6 23:34:11 mythical kernel: PPP BSD Compression module registered
Aug  6 23:34:11 mythical kernel: PPP Deflate Compression module registered

--r5Pyd7+fXNt84Ff3--
