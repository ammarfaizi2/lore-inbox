Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268902AbUJPVle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268902AbUJPVle (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 17:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268899AbUJPVle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 17:41:34 -0400
Received: from imap.gmx.net ([213.165.64.20]:19079 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268892AbUJPVlP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 17:41:15 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U3
Date: Sat, 16 Oct 2004 23:44:35 +0200
User-Agent: KMail/1.7
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Daniel Walker <dwalker@mvista.com>,
       Bill Huey <bhuey@lnxw.com>, Andrew Morton <akpm@osdl.org>,
       Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Andrew Rodland <arodland@entermail.net>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <200410162230.14363.dominik.karall@gmx.net> <1097958703.2148.27.camel@krustophenia.net>
In-Reply-To: <1097958703.2148.27.camel@krustophenia.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1275700.K2t8TAhOHm";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200410162344.41533.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1275700.K2t8TAhOHm
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 16 October 2004 22:31, Lee Revell wrote:
> On Sat, 2004-10-16 at 16:30, Dominik Karall wrote:
> > sorry, i tried to reproduce this bug, but can't. i even don't know _whe=
n_
> > this bug occurred, as i just wanted to take a look in the dmesg output
> > after loading sg module. but it does not depend on sg, as i unloaded it
> > and tried again to load.
>
> The trace looks like mplayer reading from a FAT filesystem.  Can you
> reproduce the problem if you do whatever you were doing with mplayer
> again?
>
> Lee

i could reproduce it now, but only once. it appeared when i started an avi=
=20
movie from my fat32 partition. mplayer stopped at buffering 2% and does not=
=20
play the movie. i tried to start mplayer again and reproduce it, but the bu=
g=20
does not appear again. mplayer only stopped at 2% buffering and does nothin=
g=20
more. it seems like the file couldn't be read clearly now from the fat32=20
partition, as it does not work with xine and others too.
here is the bug i get now:

=2D-----------[ cut here ]------------
kernel BUG at fs/fat/cache.c:150!
invalid operand: 0000 [#2]
PREEMPT
Modules linked in: sg sr_mod ipx p8022 psnap llc nvidia snd_mixer_oss sd_mo=
d=20
tda9887 tuner saa7134 video_buf v4l2_common v4l1_compat ir_common videodev=
=20
8139too sis900 crc32 ehci_hcd usb_storage scsi_mod ohci_hcd usbcore=20
snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc=
=20
ohci1394 ieee1394 i2c_sis96x i2c_core
CPU:    0
EIP:    0060:[<c01a0b53>]    Tainted: P      VLI
EFLAGS: 00210202   (2.6.9-rc4-mm1-vp-u3)
EIP is at fat_cache_add+0x135/0x151
eax: 00000001   ebx: cf57136c   ecx: cf57127c   edx: cf571301
esi: c1e53c50   edi: cd0d63c8   ebp: cd0d6418   esp: c1e53c1c
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process mplayer (pid: 29320, threadinfo=3Dc1e53000 task=3Dc6abca20)
Stack: cd0d6418 c1e53c88 cf785800 00000001 cd0d63c8 c01a11bb c1e53c88 c1e53=
c8c
       00000000 00000000 00000000 0003ffff cd0d6418 00000000 00000000 00000=
001
       00093710 cd0d6418 cd0d63c8 cf785800 cee1d800 c01a12c1 c1e53c8c 00000=
000
Call Trace:
 [<c01a11bb>] fat_get_cluster+0x11f/0x1de
 [<c01a12c1>] fat_bmap_cluster+0x47/0x98
 [<c01a13f1>] fat_bmap+0xdf/0x101
 [<c01a36e8>] fat_get_block+0x30/0x198
 [<c0152866>] alloc_buffer_head+0x33/0x52
 [<c01501ea>] create_buffers+0x51/0x86
 [<c015141c>] block_read_full_page+0x1bd/0x2cc
 [<c01a36b8>] fat_get_block+0x0/0x198
 [<c0132f0c>] add_to_page_cache+0x58/0x6e
 [<c013a0e4>] read_pages+0xbe/0x15e
 [<c013a49c>] do_page_cache_readahead+0x120/0x19b
 [<c013a606>] page_cache_readahead+0xef/0x1f8
 [<c01336ab>] do_generic_mapping_read+0x133/0x54b
 [<c013c911>] lru_cache_add+0xd/0x4f
 [<c0133d53>] __generic_file_aio_read+0x1a3/0x218
 [<c0133ac3>] file_read_actor+0x0/0xed
 [<c0133ec5>] generic_file_read+0x9c/0xba
 [<c012b84c>] _mutex_lock+0x20/0x36
 [<c01244c8>] do_sigaction+0x1dc/0x1f7
 [<c012b468>] autoremove_wake_function+0x0/0x43
 [<c012b84c>] _mutex_lock+0x20/0x36
 [<c0167974>] dnotify_parent+0x35/0x95
 [<c014e0a9>] vfs_read+0xcd/0x126
 [<c014e36f>] sys_read+0x41/0x6a
 [<c0103f7b>] syscall_call+0x7/0xb
Code: f2 89 e8 e8 9f fe ff ff 85 c0 89 c3 74 2a 83 6f 20 01 8b 04 24 39 00 =
75=20
24 8b 14 24 a1 74 0b 3c c0 e8 9c b1 f9 ff e9 40 ff ff ff <0f> 0b 96 00 e5 b=
7=20
2d c0 e9 2f ff ff ff 8b 1c 24 eb 88 0f 0b 48


best regards,
dominik

--nextPart1275700.K2t8TAhOHm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQCVAwUAQXGWSQvcoSHvsHMnAQIGHwP9FK98h6MA6M++0jrC/tfojx+wpht5TaKQ
B23JeyUlwT7J5Mst5cGU3mgAnUmvvauCmOU7gvmLtiCi5hBt8Ja4GfCXLoijWfTR
/ZrEdKTrJXwWDYrELpqXlq0FBh26X0jj1Hc5WONfVoZg5LIKvLPZbfU+qZFhEXOA
rAfCv4A+vr8=
=ka+p
-----END PGP SIGNATURE-----

--nextPart1275700.K2t8TAhOHm--
