Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbWGGR1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWGGR1P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 13:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWGGR1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 13:27:15 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:35002 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S932226AbWGGR1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 13:27:14 -0400
X-Sasl-enc: eu07zsGvB5MAdK65dfEcQBp6JbH8aeOlBAoSjAySnBYa 1152293230
Message-ID: <44AE99CD.80006@imap.cc>
Date: Fri, 07 Jul 2006 19:28:45 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.12) Gecko/20050915
X-Accept-Language: de,en,fr
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.18-rc1/reiserfs INFO: possible recursive locking detected
References: <6vtF8-99-7@gated-at.bofh.it>  <44AD9F82.7050006@imap.cc> <1152253999.3111.17.camel@laptopd505.fenrus.org>
In-Reply-To: <1152253999.3111.17.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig08E9CACD401ED00ADE88073E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig08E9CACD401ED00ADE88073E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On 07.07.2006 08:33, Arjan van de Ven wrote:
> hmm interesting; reiserfs seems to have another locking level layer for
> the i_mutex due to the xattrs-are-a-directory thing.
> 
> Can you try this patch below and see if that fixes it?

The message is still there, but the details changed a bit:

> Jul  7 19:15:48 gx110 kernel: [  125.840979]
> Jul  7 19:15:48 gx110 kernel: [  125.840984] =============================================
> Jul  7 19:15:48 gx110 kernel: [  125.841003] [ INFO: possible recursive locking detected ]
> Jul  7 19:15:48 gx110 kernel: [  125.841012] ---------------------------------------------
> Jul  7 19:15:48 gx110 kernel: [  125.841021] kdm/3242 is trying to acquire lock:
> Jul  7 19:15:48 gx110 kernel: [  125.841030]  (&inode->i_mutex){--..}, at: [<c033c73a>] mutex_lock+0x1c/0x1f
> Jul  7 19:15:48 gx110 kernel: [  125.841077]
> Jul  7 19:15:48 gx110 kernel: [  125.841079] but task is already holding lock:
> Jul  7 19:15:48 gx110 kernel: [  125.841087]  (&inode->i_mutex){--..}, at: [<c033c73a>] mutex_lock+0x1c/0x1f
> Jul  7 19:15:48 gx110 kernel: [  125.841105]
> Jul  7 19:15:48 gx110 kernel: [  125.841107] other info that might help us debug this:
> Jul  7 19:15:48 gx110 kernel: [  125.841117] 3 locks held by kdm/3242:
> Jul  7 19:15:48 gx110 kernel: [  125.841123]  #0:  (&inode->i_mutex){--..}, at: [<c033c73a>] mutex_lock+0x1c/0x1f
> Jul  7 19:15:48 gx110 kernel: [  125.841143]  #1:  (&REISERFS_I(inode)->xattr_sem){----}, at: [<c01bcb36>] reiserfs_acl_chmod+0xe0/0x182
> Jul  7 19:15:48 gx110 kernel: [  125.841175]  #2:  (&REISERFS_SB(s)->xattr_dir_sem){----}, at: [<c01bcb6b>] reiserfs_acl_chmod+0x115/0x182
> Jul  7 19:15:48 gx110 kernel: [  125.841197]
> Jul  7 19:15:48 gx110 kernel: [  125.841199] stack backtrace:
> Jul  7 19:15:48 gx110 kernel: [  125.841919]  [<c0103f4d>] show_trace_log_lvl+0x54/0xfd
> Jul  7 19:15:48 gx110 kernel: [  125.841975]  [<c010504d>] show_trace+0xd/0x10
> Jul  7 19:15:48 gx110 kernel: [  125.842022]  [<c0105067>] dump_stack+0x17/0x1c
> Jul  7 19:15:48 gx110 kernel: [  125.842067]  [<c012e3fa>] __lock_acquire+0x758/0x9bf
> Jul  7 19:15:48 gx110 kernel: [  125.842314]  [<c012e93e>] lock_acquire+0x5e/0x80
> Jul  7 19:15:48 gx110 kernel: [  125.842550]  [<c033c5b7>] __mutex_lock_slowpath+0xa7/0x20e
> Jul  7 19:15:48 gx110 kernel: [  125.842846]  [<c033c73a>] mutex_lock+0x1c/0x1f
> Jul  7 19:15:48 gx110 kernel: [  125.843074]  [<c01bbbb8>] reiserfs_xattr_set+0xe0/0x2bc
> Jul  7 19:15:48 gx110 kernel: [  125.844327]  [<c01bc5d6>] reiserfs_set_acl+0x187/0x200
> Jul  7 19:15:48 gx110 kernel: [  125.844957]  [<c01bcb79>] reiserfs_acl_chmod+0x123/0x182
> Jul  7 19:15:48 gx110 kernel: [  125.845581]  [<c019ddab>] reiserfs_setattr+0x218/0x250
> Jul  7 19:15:48 gx110 kernel: [  125.846168]  [<c0174619>] notify_change+0x135/0x2c0
> Jul  7 19:15:48 gx110 kernel: [  125.846637]  [<c015b25a>] sys_fchmodat+0x9c/0xc3
> Jul  7 19:15:48 gx110 kernel: [  125.847032]  [<c015b293>] sys_chmod+0x12/0x14
> Jul  7 19:15:48 gx110 kernel: [  125.847413]  [<c0102cbd>] sysenter_past_esp+0x56/0x8d

Thanks,
Tilman

-- 
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany

--------------enig08E9CACD401ED00ADE88073E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFErpnUMdB4Whm86/kRAn9xAJ9fDWnoYfrDzUdaV/NF1L49l5QzmgCfSlzE
waYY8D3mW4vOFvP9MfJ0ypc=
=iQ7R
-----END PGP SIGNATURE-----

--------------enig08E9CACD401ED00ADE88073E--
