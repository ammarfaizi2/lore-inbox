Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbVHOUu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbVHOUu0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 16:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbVHOUu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 16:50:26 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:32406 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S964959AbVHOUuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 16:50:25 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 15 Aug 2005 21:50:10 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: =?ISO-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@ribosome.natur.cuni.cz>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.13-rc6 ntfs oops
In-Reply-To: <4300B407.60409@ribosome.natur.cuni.cz>
Message-ID: <Pine.LNX.4.60.0508152125000.11229@hermes-1.csi.cam.ac.uk>
References: <4300B407.60409@ribosome.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1870869256-1784415663-1124139010=:11229"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1870869256-1784415663-1124139010=:11229
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Mon, 15 Aug 2005, [ISO-8859-2] Martin MOKREJ=A9 wrote:
>   I was just copying some data from ntfs partition to xfs and I got the f=
ollowing:
> Does someone need more info? Briefly, no SMP but HIGHMEm 4GB, i686 P4 mac=
hine, 32bit.

Yes, please.  Could you do (assuming your built kernel sources are in=20
/usr/src/linux-2.6.13-rc6):

cd /usr/src/linux-2.6.13-rc6/drivers/block

objdump -Sl ll_rw_blk.o | sed -e '0,/generic_make_request/d' |
sed -e '350,$d' | bzip2 -9 - > lrw.bz2

And then email me the file lrw.bz2?  Thanks!

Without the disassembly it is difficult to find out which source code line=
=20
exacatly triggers this oops...

> NTFS driver 2.1.23 [Flags: R/W MODULE].
> NTFS volume version 3.1.
> Unable to handle kernel NULL pointer dereference at virtual address 00000=
004
>  printing eip:
> c02da923
> *pde =3D 00000000
> Oops: 0000 [#1]
> PREEMPT DEBUG_PAGEALLOC
> Modules linked in: ntfs usb_storage radeon drm reiserfs snd_rtctimer snd_=
seq_virmidi snd_seq_midi snd_rawmidi snd_intel8x0 snd
> _ac97_codec snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm=
_oss snd_pcm snd_timer snd_page_alloc snd_mixer_oss s
> nd uhci_hcd ohci_hcd ehci_hcd intel_agp agpgart
> CPU:    0
> EIP:    0060:[<c02da923>]    Not tainted VLI
> EFLAGS: 00010202   (2.6.13-rc6)=20
> EIP is at generic_make_request+0x17/0x1e7
> eax: 00000000   ebx: 00000000   ecx: 00000001   edx: 00000001
> esi: d0a399e0   edi: 00000001   ebp: dd145cd0   esp: dd145c50
> ds: 007b   es: 007b   ss: 0068
> Process pdflush (pid: 3995, threadinfo=3Ddd144000 task=3Dd55e2b10)
> Stack: dd145c6c c0143f05 e0974a6c c290b880 00000000 c01439d7 c290b880 dd1=
45c94=20
>        c014588f f7735254 f7754ef8 00000046 f7735000 00011200 c290b880 000=
11200=20
>        00000246 dd145cac c0145c5d c013fc9a 00011200 00011210 c29a90cc dd1=
45cb4=20
> Call Trace:
>  [<c0103dd4>] show_stack+0x7a/0x90
>  [<c0103f59>] show_registers+0x156/0x1ce
>  [<c0104167>] die+0xf4/0x17e
>  [<c011779f>] do_page_fault+0x43a/0x619
>  [<c0103a33>] error_code+0x4f/0x54
>  [<c02dab48>] submit_bio+0x55/0xd5
>  [<c015fcb1>] submit_bh+0xcf/0x118
>  [<f9e62b22>] write_mft_record_nolock+0x274/0x616 [ntfs]
>  [<f9e61887>] ntfs_write_inode+0x235/0x43f [ntfs]
>  [<c017d142>] write_inode+0x49/0x4b
>  [<c017d23f>] __sync_single_inode+0xfb/0x1ff
>  [<c017d373>] __writeback_single_inode+0x30/0x149
>  [<c017d5e8>] sync_sb_inodes+0x15c/0x2a1
>  [<c017d819>] writeback_inodes+0xec/0x11c
>  [<c0142628>] wb_kupdate+0xb4/0x123
>  [<c0142efe>] __pdflush+0xd6/0x1e1
>  [<c0143027>] pdflush+0x1e/0x20
>  [<c01327fd>] kthread+0x8a/0xb7
>  [<c0101355>] kernel_thread_helper+0x5/0xb
> Code: 00 00 00 0f ab 47 0c 8b 5d f4 8b 75 f8 8b 7d fc 89 ec 5d c3 55 89 e=
5 57 56 89 c6 53 83 ec 74 8b 48 1c 8b 40 08 89 45 90=20
> c1 e9 09 <8b> 40 04 8b 50 40 8b 40 3c 0f ac d0 09 85 c0 74 54 39 c1 8b 16=
=20

Best regards,

=09Anton
--=20
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
--1870869256-1784415663-1124139010=:11229--
