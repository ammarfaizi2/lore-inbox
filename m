Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbWE3TEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWE3TEE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 15:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWE3TEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 15:04:04 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:50125 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932392AbWE3TED (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 15:04:03 -0400
Message-Id: <200605301903.k4UJ3xQU008919@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Janos Haar <djani22@netcenter.hu>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: How to send a break? - dump from frozen 64bit linux
In-Reply-To: Your message of "Tue, 30 May 2006 12:22:01 +0200."
             <01a801c683d2$e7a79c10$1800a8c0@dcccs>
From: Valdis.Kletnieks@vt.edu
References: <01b701c6818d$4bcd37b0$1800a8c0@dcccs> <20060527234350.GA13881@voodoo.jdc.home> <004501c68225$00add170$1800a8c0@dcccs> <9a8748490605280917l73f5751cmf40674fc22726c43@mail.gmail.com> <01d801c6827c$fba04ca0$1800a8c0@dcccs>
            <01a801c683d2$e7a79c10$1800a8c0@dcccs>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1149015839_3454P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 30 May 2006 15:03:59 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1149015839_3454P
Content-Type: text/plain; charset=us-ascii

On Tue, 30 May 2006 12:22:01 +0200, Janos Haar said:

> http://download.netcenter.hu/bughunt/20060530/dump.txt  (The frozen system,
> 540KB)

> Can somebody tell me, whats wrong?

kblockd/1     D ffff81011f641778     0    25     19            26    24 (L-TLB)
ffff81011f641778 0000000000000000 0000000000000009 ffff81011f735358 
       ffff81011f735140 ffff81011fc79100 000014a00f9a0ef2 00000000000410dd 
       0000000102866d40 ffff810003900280 
Call Trace: <ffffffff8026d72a>{xfs_qm_shake+135} <ffffffff804e6046>{__mutex_lock_slowpath+424}
       <ffffffff804e62e4>{mutex_lock+41} <ffffffff8026d72a>{xfs_qm_shake+135}
       <ffffffff80157cfd>{shrink_slab+100} <ffffffff801584d9>{try_to_free_pages+372}
       <ffffffff80153c3f>{__alloc_pages+432} <ffffffff8046aef3>{tcp_sendmsg+1373}
       <ffffffff804848ad>{inet_sendmsg+70} <ffffffff8043f619>{sock_sendmsg+270}
       <ffffffff8013d3e0>{autoremove_wake_function+0} <ffffffff80440db3>{kernel_sendmsg+61}
       <ffffffff8802c111>{:nbd:sock_xmit+273} <ffffffff8015195d>{mempool_alloc_slab+17}
       <ffffffff80169b1b>{poison_obj+39} <ffffffff8015195d>{mempool_alloc_slab+17}
       <ffffffff80169c11>{cache_alloc_debugcheck_after+235}
       <ffffffff8015195d>{mempool_alloc_slab+17} <ffffffff802da471>{as_remove_queued_request+267}
       <ffffffff8802c472>{:nbd:nbd_send_req+517} <ffffffff8802c712>{:nbd:do_nbd_request+329}
       <ffffffff802d9b45>{as_work_handler+46} <ffffffff80139d30>{run_workqueue+168}
       <ffffffff802d9b17>{as_work_handler+0} <ffffffff8013a27f>{worker_thread+0}
       <ffffffff8013a383>{worker_thread+260} <ffffffff80123fa4>{default_wake_function+0}
       <ffffffff8013a27f>{worker_thread+0} <ffffffff8013d29f>{kthread+219}
       <ffffffff8012590d>{schedule_tail+70} <ffffffff8010bba6>{child_rip+8}
       <ffffffff8013d1c4>{kthread+0} <ffffffff8010bb9e>{child_rip+0}

Half the processes on the box seem wedged at that same mutex_lock. I can't
seem to find an xfs_qm_shake in my source tree though.

--==_Exmh_1149015839_3454P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEfJcfcC3lWbTT17ARAseuAJ9IJXjALeOukY0Jtky/2pyxD17M3wCeLJoO
PVFA7gbnjawLTyw5M8C3IZs=
=jdZ0
-----END PGP SIGNATURE-----

--==_Exmh_1149015839_3454P--
