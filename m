Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750943AbWCENEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbWCENEN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 08:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWCENEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 08:04:13 -0500
Received: from nproxy.gmail.com ([64.233.182.205]:27264 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750943AbWCENEN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 08:04:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=c+BGZVyBiQ0AI6iBqMTx2KHiESTKQCwz6yY4vHagN2zUv8cWbwEHbTCpSyZkn3oD9iWZM8+ehD61zOfciTmv0Yx0uSp1/U7OgVQl+FB/RmyC4zZ12wybsxonAaRKsZ4wynA4VU8AWEaLCu/jmd9u5waQXEQ29BTw5fChsFssSMw=
Message-ID: <8766c4ce0603050504h24b445c5t@mail.gmail.com>
Date: Sun, 5 Mar 2006 14:04:11 +0100
From: "Miguel Blanco" <mblancom@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: problem mounting a jffs2 filesystem
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 Trying to mount a jffs2 file system in my desktop PC:
 ...
 $ modprobe mtdram total_size=6144 erase_size=128
 $ modprobe mtdblock
 ...
 $ dd if=fw.wsw of=data.jffs2 ibs=1 obs=1M count=5888K skip=6292872
 $ jffs2dump -b -c -e data-le.jffs2 data.jffs2
 $ dd if=data-le.jffs2 of=/dev/mtdblock0
 $ mkdir data
 $ mount -t jffs2 /dev/mtdblock0 data

 I get a mount error:
     "2942 Violación de segmento" (in spanish and "segment violation"
in english :-) )

 and dmesg says (relevant part I think):

 divide error: 0000 [#1]
 last sysfs file: /block/mtdblock0/dev
 Modules linked in: jffs2 zlib_deflate mtdblock mtd_blkdevs mtdram
mtdpart mtdcor e parport_pc lp parport autofs4 dm_mod video button
battery ac ipv6 ohci1394 iee e1394 uhci_hcd ehci_hcd i2c_i801 i2c_core
snd_intel8x0 snd_ac97_codec snd_ac97_b us snd_seq_dummy snd_seq_oss
snd_seq_midi_event snd_seq snd_seq_device snd_pcm_o ss snd_mixer_oss
snd_pcm snd_timer snd soundcore snd_page_alloc 8139cp 8139too m ii
floppy sr_mod ext3 jbd aic7xxx scsi_transport_spi sd_mod scsi_mod
 CPU:    0
 EIP:    0060:[<e118deef>]    Not tainted VLI
 EFLAGS: 00210246   (2.6.15-1.1830_FC4)
 EIP is at jffs2_scan_medium+0xdf/0x55e [jffs2]
 eax: 0000fff4   ebx: d2c5fa00   ecx: dffef180   edx: 00000000
 esi: d07d24e0   edi: d07d28d0   ebp: d3c98a80   esp: d0995d80
 ds: 007b   es: 007b   ss: 0068
 Process mount (pid: 2942, threadinfo=d0995000 task=d311b030)
 Stack: 00000000 d3c98a80 d0995da4 00000080 00000030 00000002 00000000 00000000
        00600000 e0b58000 d2c5fa00 00000030 d2c5fa00 00000000 e119107a d2c5fa00
        d3c98338 fffffff4 c0152c19 ffffffff e119611d 000000d0 00000000 d2c5fa00
 Call Trace:
  [<e119107a>] jffs2_build_filesystem+0x1a
/0x306 [jffs2]     [<c0152c19>] __vmall oc+0xf/0x13
  [<e119611d>] jffs2_sum_init+0x3d/0xbf [jffs2]     [<e1191609>]
jffs2_do_mount_f s+0x1cc/0x233 [jffs2]
  [<e119300c>] jffs2_do_fill_super+0xa8/0x1cb [jffs2]     [<e1193647>]
jffs2_sb_s et+0x0/0x1d [jffs2]
  [<e119385f>] jffs2_get_sb_mtd+0x1fb/0x22c [jffs2]     [<e11939b5>]
jffs2_get_sb +0xe7/0x192 [jffs2]
  [<c017502b>] alloc_vfsmnt+0x9b/0xc2     [<c0174f79>] get_fs_type+0x8d/0xa4
  [<c0161d29>] do_kern_mount+0xaf/0x147     [<c0176437>] do_new_mount+0x6b/0x90
  [<c0176a37>] do_mount+0x1b1/0x1cc     [<c01422e0>] __alloc_pages+0x57/0x2ed
  [<c017683d>] copy_mount_options+0x4d/0x96     [<c0176db4>] sys_mount+0x72/0xa4
  [<c0102e75>] syscall_call+0x7/0xb
 Code: 8b 93 b0 00 00 00 8b 42 18 01 43 7c 8b 43 78 2b 42 18 89 43 78
c7 42 18 00  00 00 00 8b b3 b0 00 00 00 85 f6 74 24 8b 46 20 31 d2
<f7> b3 84 01 00 00 85 d2  74 15 01 56 1c 01 53 7c 8b 83 b0 00 00
 Continuing in 1 seconds.
  <6>loop: loaded (max 8 devices)


 this is with Fedora 4 kernel 2.6.15-1.1830 (and later kernels).
2.6.14.1.1656 is OK!

 I know is a vendor kernel, but the 2.6.15 ChangeLog contains a lot of
changes related
 to mtd devices and jffs2 filesystems, so I think it could be a mainline bug.

 Let me know if you need more information.

 Thank you,
 Miguel.
