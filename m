Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbUKWVAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbUKWVAM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 16:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbUKWU6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 15:58:51 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:5538 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261544AbUKWU4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 15:56:39 -0500
Message-Id: <200411232056.iANKuCmN019652@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: keith <kmannth@us.ibm.com>
Cc: devnull@us.ibm.com, djwong <djwong@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: SELinux performance issue with large systems (32 cpus) 
In-Reply-To: Your message of "Tue, 23 Nov 2004 11:22:05 PST."
             <1101237725.27848.301.camel@knk> 
From: Valdis.Kletnieks@vt.edu
References: <1101237725.27848.301.camel@knk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_622684346P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 23 Nov 2004 15:56:12 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_622684346P
Content-Type: text/plain; charset=us-ascii

On Tue, 23 Nov 2004 11:22:05 PST, keith said:

> After some lock profiling (keeping track of what locks were last used
> and how many cycles were spent waiting) it became quite clean the the
> avc_lock was to blame.  The avc_lock is a SELinux lock.  

Known issue - in the -mm kernels there are these patches:

selinux-scalability-add-spin_trylock_irq-and.patch
  SELinux scalability: add spin_trylock_irq and  spin_trylock_irqsave

selinux-scalability-convert-avc-to-rcu.patch
  SELinux scalability: convert AVC to RCU

selinux-atomic_dec_and_test-bug.patch
  SELinux: atomic_dec_and_test() bug

selinux-scalability-avc-statistics-and-tuning.patch
  SELinux scalability: AVC statistics and tuning

I don't know if these patches require other infrastructure from the -mm
patchseries, or if they'll apply clean to a 2.6.10-rc2 kernel.



--==_Exmh_622684346P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBo6PqcC3lWbTT17ARAo9wAKCHgtum+sZm5tIJtgm7GuvyZ1bQbgCfdSKf
cKGwe7qTN+J7htaN2Wu4JHc=
=v/2T
-----END PGP SIGNATURE-----

--==_Exmh_622684346P--
