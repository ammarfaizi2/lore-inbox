Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbWEQTod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbWEQTod (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 15:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbWEQTod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 15:44:33 -0400
Received: from pool-71-254-71-216.ronkva.east.verizon.net ([71.254.71.216]:58054
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751041AbWEQTod (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 15:44:33 -0400
Message-Id: <200605171944.k4HJiELo030480@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Olaf Hering <olh@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ignore partition table on disks with AIX label
In-Reply-To: Your message of "Wed, 17 May 2006 21:03:26 +0200."
             <20060517190326.GA29017@suse.de>
From: Valdis.Kletnieks@vt.edu
References: <20060517081314.GA20415@suse.de> <200605170853.k4H8rn8K009466@turing-police.cc.vt.edu> <20060517091056.GA21219@suse.de> <200605171014.k4HAETHT011371@turing-police.cc.vt.edu> <20060517183710.GA28931@suse.de> <1147892187.10470.70.camel@localhost.localdomain>
            <20060517190326.GA29017@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1147895053_4166P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 17 May 2006 15:44:13 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1147895053_4166P
Content-Type: text/plain; charset=us-ascii

On Wed, 17 May 2006 21:03:26 +0200, Olaf Hering said:
>  On Wed, May 17, Alan Cox wrote:
> > All we want to know initially is how to correctly spot AIX volumes. As I
> I dont have any more info about the layout.

I'm looking at the IBM header files on our AIX box.  Incidentally,
whoever "corrected" the spelling of EBCDIC should note that the same
exact typo is in the AIX /usr/include/sys/bootrecord.h I'm looking at. :)

As far as I can tell, the boot ROM snarfs up the first 512 byte block, and then
looks for the 'IBMA' magic cookie, then looks at offset 0x1BE for a
bog-standard 4-entry partition table, and a 0x55AA at offset 0x1FE.

Additionally, there will be an *ASCII* '_LVM' in the first 4 bytes of physical
512-byte block 7, denoting the start of the LVM control record.

I'd say if you find both the IBMA *and* _LVM cookies intact, you declare it
an AIX volume.



--==_Exmh_1147895053_4166P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEa30NcC3lWbTT17ARAqEvAJ9j2COSSa5tdlHW8PmONG+wS/vugQCgnfIp
NF/KXVWDHdLtuu5prfNkTos=
=nHr0
-----END PGP SIGNATURE-----

--==_Exmh_1147895053_4166P--
