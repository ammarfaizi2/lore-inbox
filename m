Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262365AbUCWHyO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 02:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbUCWHyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 02:54:14 -0500
Received: from everest.2mbit.com ([24.123.221.2]:38019 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S262365AbUCWHyJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 02:54:09 -0500
Date: Tue, 23 Mar 2004 02:54:59 -0500
From: Andrew D Kirch <trelane@trelane.net>
To: John Pearson <huiac@internode.on.net>
Cc: linux-kernel@vger.kernel.org
Message-Id: <20040323025459.755b73bb.trelane@trelane.net>
In-Reply-To: <405FE85C.5000307@internode.on.net>
References: <405FE85C.5000307@internode.on.net>
Organization: SOSDG
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-Scan-Signature: 8f3afb52ccb27b67846dd34d6f140aed
X-SA-Exim-Connect-IP: 24.123.221.4
X-SA-Exim-Mail-From: trelane@trelane.net
Subject: Re: strange ext3 corruption problem on 2.6.x
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__23_Mar_2004_02_54_59_-0500_vL4hrWSUDsbM85R8"
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
X-SA-Exim-Version: 4.0 (built Tue, 16 Mar 2004 14:56:42 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__23_Mar_2004_02_54_59_-0500_vL4hrWSUDsbM85R8
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 23 Mar 2004 18:03:48 +1030
John Pearson <huiac@internode.on.net> wrote:

> OK,
> 
> I've seen this one now, too; here's my datapoint:
> 
> First, under vanilla 2.6.3:
> 
> EXT3-fs error (device dm-0): ext3_readdir: bad entry in directory 
> #917711: rec_len % 4 != 0 - offset=0, inode=1182746341, rec_len=16861,
> #
> name_len=185
> Aborting journal on device dm-0.
> ext3_abort called.
> EXT3-fs abort (device dm-0): ext3_journal_start: Detected aborted
> journal Remounting filesystem read-only
>  
> 
> 
> Then, under 2.6.4+skas3:
>  
> 
> EXT3-fs error (device dm-3): ext3_readdir: bad entry in directory 
> #510327: directory entry across blocks - offset=0, inode=0, 
> rec_len=5044, name_len=113
> Aborting journal on device dm-3.
> ext3_abort called.
> EXT3-fs abort (device dm-3): ext3_journal_start: Detected aborted
> journal Remounting filesystem read-only
> 
> 
> 
> I'm running ext3 over raid5;  In both cases, fsck spotted the aborted 
> journal and checked the FS, which came up clean.
> 
> No other issues in many days of uptime, including kernel compiles,
> etc., so I'm reasonably confident of the RAM and hardware generally.
> 
> I wouldn't describe either volume as seeing heavy use - there's rarely
> 
> more than one reader, and almost never more than one writer.
> 
> dm-3 has had no writes since last boot (it serves images to diskless 
> clients, including NFS roots mounted ro); dm-0 had seen a few writes 
> (it's a read-mostly FTP server containing mirrors of debian-security
> and a few other things, synced about once a month).
> 
> 'directory #510327' on dm-3 is a manpage directory, which shows a size
> 
> of 20480 and contains 751 files; 'directory #917711' on dm-0 has a
> size of 8192 and contains 101 files.
> 
> The box is a UMP Athlon XP with 512Mb DDR RAM on a VIA VT8237-based
> board, using on-board IDE + a Promise 20268 controller (but as the
> RAID layer works, I doubt it's the hardware).

I had a situation similar to this in 2.6.3, while the machine was under
load, the entire filesystem was trashed, lots of lost inodes and the
journal was irrecoverable.  I'm glad your luck was better than mine.


-- 
Andrew D Kirch  |       Abusive Hosts Blocking List      | www.ahbl.org
Security Admin  |  Summit Open Source Development Group  | www.sosdg.org
Key At http://www.2mbit.com/~trelane/trelane.key
Key fingerprint = B4C2 8083 648B 37A2 4CCE  61D3 16D6 995D 026F 20CF

--Signature=_Tue__23_Mar_2004_02_54_59_-0500_vL4hrWSUDsbM85R8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAX+1eFtaZXQJvIM8RAjkYAKDe5cr+iiqh1Q29RmBqGWMaNuZ9gACeOVj0
TwS51OYE3CpeGK/Ac+BIfYU=
=UJcn
-----END PGP SIGNATURE-----

--Signature=_Tue__23_Mar_2004_02_54_59_-0500_vL4hrWSUDsbM85R8--
