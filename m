Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263625AbTJWP4i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 11:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263627AbTJWP4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 11:56:37 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:36738 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263625AbTJWP4g (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 11:56:36 -0400
Message-Id: <200310231556.h9NFuGqm007878@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Flavio Bruno Leitner <fbl@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel/initrd and rootfs over LVM 
In-Reply-To: Your message of "Thu, 23 Oct 2003 13:44:25 -0300."
             <20031023164425.GC21031@conectiva.com.br> 
From: Valdis.Kletnieks@vt.edu
References: <20031023164425.GC21031@conectiva.com.br>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1409194144P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 23 Oct 2003 11:56:16 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1409194144P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <7860.1066924562.1@turing-police.cc.vt.edu>

On Thu, 23 Oct 2003 13:44:25 -0300, Flavio Bruno Leitner <fbl@conectiva.com.br>  said:
> 
> I'm using kernel 2.6.0-test7 and as far I understand 
> prepare_namespace() checks if saved_root_name[0] is
> not null (I'm passing root=/dev/vg0/lvroot), then
> name_to_dev_t() try to guess what MINOR and MAJOR 
> are used by the root device. 

What I ended up doing to get that working back in the 2.5.4x days was to have
my initrd's linuxrc do a 'lvm vgscan' to get the volume group online, and then
an 'lvdisplay' - this of course wedged up after it since there wasn't a proper
root=, but it revealed the numbers I needed.

As far as I can tell, if you're using the device-mapper in 2.6, you'll want
MAJOR=, and then the MINOR= seems to be stable across 2.4/2.6/lvm1/lvm2 (So if
you're building the system under 2.4 and have LVM running there, you can get
the minor number from lvdisplay there, and use it with major=254 to get your
2.6 up and running.  For lilo, I ended up using this:

        root=65029
# magic number is major=254 * 256 + minor=5

Grub you're on your own.  Yes, I should upgrade, but lilo *does* work for this machine, sooo.

--==_Exmh_1409194144P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/l/ogcC3lWbTT17ARArj0AJ42t9a7UjAP1k9kDGNpQFTXySUXiACg/Nyq
+0Fr7WQLEbbsXkqR21fPDDc=
=SOhj
-----END PGP SIGNATURE-----

--==_Exmh_1409194144P--
