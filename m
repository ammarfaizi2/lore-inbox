Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbUEVQyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbUEVQyK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 12:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbUEVQyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 12:54:10 -0400
Received: from [193.170.124.123] ([193.170.124.123]:40133 "EHLO 23.cms.ac")
	by vger.kernel.org with ESMTP id S261648AbUEVQyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 12:54:02 -0400
Date: Sat, 22 May 2004 18:53:54 +0200
From: JG <jg@cms.ac>
To: John Bradford <john@grabjohn.com>
Cc: Jan Meizner <jm@pa103.nowa-wies.sdi.tpnet.pl>,
       system <system@eluminoustechnologies.com>, linux-kernel@vger.kernel.org
Subject: Re: hda Kernel error!!!
In-Reply-To: <200405221622.i4MGMuhD000211@81-2-122-30.bradfords.org.uk>
References: <200405221257.28570.system@eluminoustechnologies.com>
	<Pine.LNX.4.55L.0405221515410.32669@pa103.nowa-wies.sdi.tpnet.pl>
	<200405221622.i4MGMuhD000211@81-2-122-30.bradfords.org.uk>
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Gentoo 1.4 ;)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sat__22_May_2004_18_53_54_+0200_tMfzaYq4HdZNA_y9"
Message-Id: <20040522165404.5BF5A1A9B70@23.cms.ac>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sat__22_May_2004_18_53_54_+0200_tMfzaYq4HdZNA_y9
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

 
> It does not necessarily indicate a serious problem.  Are you sure your
> error messages were exactly the same?

while we are at it. some days ago i got this:
hdi: task_in_intr: status=0x7f { DriveReady DeviceFault SeekComplete DataRequest CorrectedError Index Error }
hdi: task_in_intr: error=0x7f { DriveStatusError UncorrectableError SectorIdNotFound TrackZeroNotFound AddrMarkNotFound }, LBAsect=280923064991615, high=16744319, low=8355711, sector=1130361
ide4: reset: success

maxtor 200gb disk (2x100gb partitions, both reiserfs 3.6) on highpoint hpt374. i wasn't able to access the disk anymore until reboot and lost data. also got a kernel bug message regarding to reiserfs.

end_request: I/O error, dev hdi, sector 199201724
Buffer I/O error on device hdi2, logical block 7498
lost page write due to I/O error on hdi2
journal-601, buffer write failed
------------[ cut here ]------------
kernel BUG at fs/reiserfs/prints.c:339!
invalid operand: 0000 [#2]
CPU:    0
EIP:    0060:[<f1134388>]    Not tainted
EFLAGS: 00210286
EIP is at reiserfs_panic+0x38/0x70 [reiserfs]
eax: 00000024   ebx: eeea3800   ecx: 00000001   edx: c0314cd8
esi: f127a1e8   edi: 00000000   ebp: 00000000   esp: db62fe00
ds: 007b   es: 007b   ss: 0068
Process umount (pid: 31023, threadinfo=db62e000 task=dc6f0660)
Stack: f114c446 f11522e0 f127a1e8 eeea3800 f113ff0e eeea3800 f114a240 00000000
       00001000 00000002 00000005 00000003 00000000 d9db61dc 00000110 00000004
       eeea3800 00000000 f114480d eeea3800 f127a1e8 00000001 00001000 e2e52d00
Call Trace:
 [<f113ff0e>] flush_commit_list+0x2ee/0x480 [reiserfs]
 [<f114480d>] do_journal_end+0x9dd/0xcb0 [reiserfs]
 [<f1140d09>] do_journal_release+0x89/0x100 [reiserfs]
 [<f1143048>] journal_mark_dirty+0x158/0x2e0 [reiserfs]
 [<f1131b8b>] reiserfs_destroy_inode+0x1b/0x20 [reiserfs]
 [<f1140d9f>] journal_release+0x1f/0x30 [reiserfs]
 [<f1131a15>] reiserfs_put_super+0x25/0x150 [reiserfs]
 [<c0152f15>] generic_shutdown_super+0xf5/0x110
 [<c015381d>] kill_block_super+0x1d/0x50
 [<c0152d58>] deactivate_super+0x48/0x80
 [<c0166fef>] sys_umount+0x3f/0x90
 [<c0142704>] sys_munmap+0x44/0x70
 [<c0167057>] sys_oldumount+0x17/0x20
 [<c0108cbb>] syscall_call+0x7/0xb

Code: 0f 0b 53 01 4c c4 14 f1 c7 04 24 60 8c 14 f1 c7 44 24 08 e0


the weird thing is, S.M.A.R.T doesn't show any current problems with the disk and there's nothing in the S.M.A.R.T error log...?
can't remember exactly which kernel i was running, i've tried too many lately because of this error (either 2.6.2 or some 2.6.6), currently i have 2.6.6-mm3.

thx,
JG

--Signature=_Sat__22_May_2004_18_53_54_+0200_tMfzaYq4HdZNA_y9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAr4WsU788cpz6t2kRAi/SAJ9GJBRHJ2tj3x1ZEkOd8IyC9bNPuQCfeNij
eGz770T07ZGs802StP7h9cA=
=+2fq
-----END PGP SIGNATURE-----

--Signature=_Sat__22_May_2004_18_53_54_+0200_tMfzaYq4HdZNA_y9--
