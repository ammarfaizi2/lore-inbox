Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262754AbUDDUGe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 16:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262753AbUDDUGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 16:06:32 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:5772 "EHLO
	albatross.madduck.net") by vger.kernel.org with ESMTP
	id S262731AbUDDUGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 16:06:16 -0400
Date: Sun, 4 Apr 2004 20:15:25 +0200
From: martin f krafft <madduck@madduck.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2 * Assertion failure, 2 * BUG
Message-ID: <20040404181525.GA7811@diamond.madduck.net>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
X-OS: Debian GNU/Linux testing/unstable kernel 2.6.2-fishbowl i686
X-Mailer: Mutt 1.5.5.1+cvs20040105i (2003-11-05)
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

I have just been surprised by the two Assertion failures and
subsequent kernel BUGs I quoted below, on a machine running 2.6.4
(k7) while doing a lot of disk I/O (the machine has a software RAID
spanning three IDE disks, two on the onboard VIA 82Cxx controller
and another one on a PDC2069).

The strange thing is that the machine still appears to be somewhat
responsive, generating log messages from iptables on the console,
allowing console switching, typing, etc. For instance, it is
possible to SIGINT a process in an SSH session with ctrl-c, but no
shell is presented afterwards. Yet, the terminal still echoes
characters, which suggests that the undderlying socket connection
must still be alive.

However, SysRq requests (such as s-u-b) do not yield any result,
however. Not even a console message.

Furthermore, the disk I/O LED on the computer case is flashing
disco-style, indicating that there is a lot of writing going on.
This *may* be a RAID reconstruction from a previous unclean reboot
that the kernel can still perform.

I would greatly appreciate any hints as to what could have caused
the error. Also, if you need specs about the system, don't hesitate
to ask.

  Assertion failure in journal_add_journal_head() at fs/jbd/journal.c:1679:=
 "(((&bh->b_count)->counter) > 0) || (bh->b_page && bh->b_page->mapping)"
  ------------[ cut here ]------------
  kernel BUG at fs/jbd/journal.c:1679!
  invalid operand: 0000 [#1]
  PREEMPT=20
  CPU:    0
  EIP:    0060:[__crc_utf8_wctomb+5786673/6417782]    Not tainted
  EFLAGS: 00010286
  EIP is at journal_add_journal_head+0xda/0x110 [jbd]
  eax: 00000096   ebx: ce2f3348   ecx: c0344860   edx: c02b0cf8
  esi: d0aba360   edi: 00000000   ebp: 00000000   esp: c1bc1d28
  ds: 007b   es: 007b   ss: 0068
  Process pdflush (pid: 5, threadinfo=3Dc1bc0000 task=3Dc1a3e040)
  Stack: f8877560 f887645e f8877ef5 0000068f f8877ae0 f5b8fc80 c1bc0000 f72=
ed3e4=20
        00001000 f886f3a7 ce2f3348 c015c14a c122b0a0 00000000 c1bc0000 0000=
0000=20
        00001000 f72ed3e4 ce2f3348 00001000 f88b1b23 f72ed3e4 ce2f3348 ce2f=
3348=20
  Call Trace:
  [__crc_utf8_wctomb+5759646/6417782] journal_dirty_data+0x57/0x1f0 [jbd]
  [__block_write_full_page+490/1040] __block_write_full_page+0x1ea/0x410
  [__crc_utf8_wctomb+6031898/6417782] ext3_journal_dirty_data+0x23/0x70 [ex=
t3]
  [block_write_full_page+228/240] block_write_full_page+0xe4/0xf0
  [__crc_utf8_wctomb+6031455/6417782] walk_page_buffers+0x68/0x70 [ext3]
  [__crc_utf8_wctomb+6033422/6417782] ext3_ordered_writepage+0x167/0x1d0 [e=
xt3]
  [__crc_utf8_wctomb+6033031/6417782] journal_dirty_data_fn+0x0/0x20 [ext3]
  [mpage_writepages+526/768] mpage_writepages+0x20e/0x300
  [mpage_writepages+526/768] mpage_writepages+0x20e/0x300
  [__crc_utf8_wctomb+6033063/6417782] ext3_ordered_writepage+0x0/0x1d0 [ext=
3]
  [do_writepages+54/64] do_writepages+0x36/0x40
  [__sync_single_inode+212/544] __sync_single_inode+0xd4/0x220
  [sync_sb_inodes+415/608] sync_sb_inodes+0x19f/0x260
  [writeback_inodes+77/160] writeback_inodes+0x4d/0xa0
  [background_writeout+123/192] background_writeout+0x7b/0xc0
  [__pdflush+202/448] __pdflush+0xca/0x1c0
  [pdflush+0/32] pdflush+0x0/0x20
  [pdflush+15/32] pdflush+0xf/0x20
  [background_writeout+0/192] background_writeout+0x0/0xc0
  [pdflush+0/32] pdflush+0x0/0x20
  [kthread+165/176] kthread+0xa5/0xb0
  [kthread+0/176] kthread+0x0/0xb0
  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc

  Code: 0f 0b 8f 06 f5 7e 87 f8 e9 55 ff ff ff 8b 7b 28 e9 79 ff ff=20
  <6>note: pdflush[5] exited with preempt_count 1
  Assertion failure in journal_start() at fs/jbd/transaction.c:274: "handle=
->h_transaction->t_journal =3D=3D journal"
  ------------[ cut here ]------------
  kernel BUG at fs/jbd/transaction.c:274!
  invalid operand: 0000 [#2]
  PREEMPT=20
  CPU:    0
  EIP:    0060:[__crc_utf8_wctomb+5755944/6417782]   Not tainted
  EFLAGS: 00010286
  EIP is at journal_start+0x61/0xd0 [jbd]
  eax: 00000073   ebx: f72ed3e4   ecx: 00000001   edx: c02b0cf8
  esi: c1bc0000   edi: f5b8fe80   ebp: 00000001   esp: c1bc1924
  ds: 007b   es: 007b   ss: 0068
  Process pdflush (pid: 5, threadinfo=3Dc1bc0000 task=3Dc1a3e040)
  Stack: f8876500 f88760a2 f8877ba7 00000112 f8876580 00000001 f72ed3e4 f56=
546d4=20
        f88b45a2 f5b8fe80 00000002 00000001 f56546d4 f6511400 c01798db f565=
46d4=20
        f56546d4 40704df7 30f6c815 00000001 c0173896 f56546d4 00000001 c1bc=
1984=20
  Call Trace:
  [__crc_utf8_wctomb+6042777/6417782] ext3_dirty_inode+0x32/0x90 [ext3]
  [__mark_inode_dirty+219/224] __mark_inode_dirty+0xdb/0xe0
  [inode_update_time+198/208] inode_update_time+0xc6/0xd0
  [generic_file_aio_write_nolock+591/2768] generic_file_aio_write_nolock+0x=
24f/0xad0
  [complement_pos+32/400] complement_pos+0x20/0x190
  [__crc_utf8_wctomb+5905668/6417782] ide_build_sglist+0x3d/0xb0 [ide_core]
  [__delay+18/32] __delay+0x12/0x20
  [generic_file_aio_write+119/160] generic_file_aio_write+0x77/0xa0
  [__crc_utf8_wctomb+6021019/6417782] ext3_file_write+0x44/0xc0 [ext3]
  [do_sync_write+139/192] do_sync_write+0x8b/0xc0
  [poke_blanked_console+111/192] poke_blanked_console+0x6f/0xc0
  [vt_console_print+525/752] vt_console_print+0x20d/0x2f0
  [__call_console_drivers+87/96] __call_console_drivers+0x57/0x60
  [do_acct_process+635/656] do_acct_process+0x27b/0x290
  [acct_process+70/140] acct_process+0x46/0x8c
  [do_exit+143/1040] do_exit+0x8f/0x410
  [do_invalid_op+0/208] do_invalid_op+0x0/0xd0
  [die+249/256] die+0xf9/0x100
  [do_invalid_op+201/208] do_invalid_op+0xc9/0xd0
  [__crc_utf8_wctomb+5786673/6417782] journal_add_journal_head+0xda/0x110 [=
jbd]
  [__wake_up_common+49/96] __wake_up_common+0x31/0x60
  [error_code+45/56] error_code+0x2d/0x38
  [__crc_utf8_wctomb+5786673/6417782] journal_add_journal_head+0xda/0x110 [=
jbd]
  [__crc_utf8_wctomb+5759646/6417782] journal_dirty_data+0x57/0x1f0 [jbd]
  [__block_write_full_page+490/1040] __block_write_full_page+0x1ea/0x410
  [__crc_utf8_wctomb+6031898/6417782] ext3_journal_dirty_data+0x23/0x70 [ex=
t3]
  [block_write_full_page+228/240] block_write_full_page+0xe4/0xf0
  [__crc_utf8_wctomb+6031455/6417782] walk_page_buffers+0x68/0x70 [ext3]
  [__crc_utf8_wctomb+6033422/6417782] ext3_ordered_writepage+0x167/0x1d0 [e=
xt3]
  [__crc_utf8_wctomb+6033031/6417782] journal_dirty_data_fn+0x0/0x20 [ext3]
  [mpage_writepages+526/768] mpage_writepages+0x20e/0x300
  [mpage_writepages+526/768] mpage_writepages+0x20e/0x300
  [__crc_utf8_wctomb+6033063/6417782] ext3_ordered_writepage+0x0/0x1d0 [ext=
3]
  [do_writepages+54/64] do_writepages+0x36/0x40
  [__sync_single_inode+212/544] __sync_single_inode+0xd4/0x220
  [sync_sb_inodes+415/608] sync_sb_inodes+0x19f/0x260
  [writeback_inodes+77/160] writeback_inodes+0x4d/0xa0
  [background_writeout+123/192] background_writeout+0x7b/0xc0
  [__pdflush+202/448] __pdflush+0xca/0x1c0
  [pdflush+0/32] pdflush+0x0/0x20
  [pdflush+15/32] pdflush+0xf/0x20
  [background_writeout+0/192] background_writeout+0x0/0xc0
  [pdflush+0/32] pdflush+0x0/0x20
  [kthread+165/176] kthread+0xa5/0xb0
  [kthread+0/176] kthread+0x0/0xb0
  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc

  Code: 0f 0b 12 01 a7 7b 87 f8 ff 43 08 89 d8 8b 5c 24 14 8b 74 24=20
  <6>note: pdflush[5] exited with preempt_count 1
  bad: scheduling while atomic!
  Call Trace:
  [schedule+1402/1408] schedule+0x57a/0x580
  [set_cursor+119/144] set_cursor+0x77/0x90
  [vt_console_print+488/752] vt_console_print+0x1e8/0x2f0
  [__down+134/256] __down+0x86/0x100
  [default_wake_function+0/32] default_wake_function+0x0/0x20
  [__delay+18/32] __delay+0x12/0x20
  [__down_failed+8/12] __down_failed+0x8/0xc
  [.text.lock.filemap+5/105] .text.lock.filemap+0x5/0x69
  [__crc_utf8_wctomb+5907975/6417782] __ide_dma_write+0xd0/0xe0 [ide_core]
  [__crc_utf8_wctomb+6021019/6417782] ext3_file_write+0x44/0xc0 [ext3]
  [do_sync_write+139/192] do_sync_write+0x8b/0xc0
  [poke_blanked_console+111/192] poke_blanked_console+0x6f/0xc0
  [vt_console_print+525/752] vt_console_print+0x20d/0x2f0
  [__call_console_drivers+87/96] __call_console_drivers+0x57/0x60
  [do_acct_process+635/656] do_acct_process+0x27b/0x290
  [acct_process+70/140] acct_process+0x46/0x8c
  [do_exit+143/1040] do_exit+0x8f/0x410
  [do_invalid_op+0/208] do_invalid_op+0x0/0xd0
  [die+249/256] die+0xf9/0x100
  [do_invalid_op+201/208] do_invalid_op+0xc9/0xd0
  [__crc_utf8_wctomb+5755944/6417782] journal_start+0x61/0xd0 [jbd]
  [__call_console_drivers+87/96] __call_console_drivers+0x57/0x60
  [__wake_up_common+49/96] __wake_up_common+0x31/0x60
  [error_code+45/56] error_code+0x2d/0x38
  [__crc_utf8_wctomb+5755944/6417782] journal_start+0x61/0xd0 [jbd]
  [__crc_utf8_wctomb+6042777/6417782] ext3_dirty_inode+0x32/0x90 [ext3]
  [__mark_inode_dirty+219/224] __mark_inode_dirty+0xdb/0xe0
  [inode_update_time+198/208] inode_update_time+0xc6/0xd0
  [generic_file_aio_write_nolock+591/2768] generic_file_aio_write_nolock+0x=
24f/0xad0
  [complement_pos+32/400] complement_pos+0x20/0x190
  [__crc_utf8_wctomb+5905668/6417782] ide_build_sglist+0x3d/0xb0 [ide_core]
  [__delay+18/32] __delay+0x12/0x20
  [generic_file_aio_write+119/160] generic_file_aio_write+0x77/0xa0
  [__crc_utf8_wctomb+6021019/6417782] ext3_file_write+0x44/0xc0 [ext3]
  [do_sync_write+139/192] do_sync_write+0x8b/0xc0
  [poke_blanked_console+111/192] poke_blanked_console+0x6f/0xc0
  [vt_console_print+525/752] vt_console_print+0x20d/0x2f0
  [__call_console_drivers+87/96] __call_console_drivers+0x57/0x60
  [do_acct_process+635/656] do_acct_process+0x27b/0x290
  [acct_process+70/140] acct_process+0x46/0x8c
  [do_exit+143/1040] do_exit+0x8f/0x410
  [do_invalid_op+0/208] do_invalid_op+0x0/0xd0
  [die+249/256] die+0xf9/0x100
  [do_invalid_op+201/208] do_invalid_op+0xc9/0xd0
  [__crc_utf8_wctomb+5786673/6417782] journal_add_journal_head+0xda/0x110 [=
jbd]
  [__wake_up_common+49/96] __wake_up_common+0x31/0x60
  [error_code+45/56] error_code+0x2d/0x38
  [__crc_utf8_wctomb+5786673/6417782] journal_add_journal_head+0xda/0x110 [=
jbd]
  [__crc_utf8_wctomb+5759646/6417782] journal_dirty_data+0x57/0x1f0 [jbd]
  [__block_write_full_page+490/1040] __block_write_full_page+0x1ea/0x410
  [__crc_utf8_wctomb+6031898/6417782] ext3_journal_dirty_data+0x23/0x70 [ex=
t3]
  [block_write_full_page+228/240] block_write_full_page+0xe4/0xf0
  [__crc_utf8_wctomb+6031455/6417782] walk_page_buffers+0x68/0x70 [ext3]
  [__crc_utf8_wctomb+6033422/6417782] ext3_ordered_writepage+0x167/0x1d0 [e=
xt3]
  [__crc_utf8_wctomb+6033031/6417782] journal_dirty_data_fn+0x0/0x20 [ext3]
  [mpage_writepages+526/768] mpage_writepages+0x20e/0x300
  [mpage_writepages+526/768] mpage_writepages+0x20e/0x300
  [__crc_utf8_wctomb+6033063/6417782] ext3_ordered_writepage+0x0/0x1d0 [ext=
3]
  [do_writepages+54/64] do_writepages+0x36/0x40
  [__sync_single_inode+212/544] __sync_single_inode+0xd4/0x220
  [sync_sb_inodes+415/608] sync_sb_inodes+0x19f/0x260
  [writeback_inodes+77/160] writeback_inodes+0x4d/0xa0
  [background_writeout+123/192] background_writeout+0x7b/0xc0
  [__pdflush+202/448] __pdflush+0xca/0x1c0
  [pdflush+0/32] pdflush+0x0/0x20
  [pdflush+15/32] pdflush+0xf/0x20
  [background_writeout+0/192] background_writeout+0x0/0xc0
  [pdflush+0/32] pdflush+0x0/0x20
  [kthread+165/176] kthread+0xa5/0xb0
  [kthread+0/176] kthread+0x0/0xb0
  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
=20
"it's time for the human race to enter the solar system."=20
                                                      - george w. bush

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAcFC9IgvIgzMMSnURAr8kAKCrW84TRCRLw0plAPT2ieLs4FUupwCgwXlv
EWi4wHpUeBatK2M/HTTB1mo=
=AMvB
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
