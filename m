Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271900AbTGYDam (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 23:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271901AbTGYDam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 23:30:42 -0400
Received: from h80ad2526.async.vt.edu ([128.173.37.38]:44930 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S271900AbTGYDaa (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 23:30:30 -0400
Message-Id: <200307250345.h6P3jTDE011119@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Douglas J Hunley <doug@hunley.homeip.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0: Badness in pci_find_subsys!! 
In-Reply-To: Your message of "Thu, 24 Jul 2003 13:26:01 EDT."
             <200307241326.04656.doug@hunley.homeip.net> 
From: Valdis.Kletnieks@vt.edu
References: <200307241326.04656.doug@hunley.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1206902696P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Jul 2003 23:45:29 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1206902696P
Content-Type: text/plain; charset=us-ascii

On Thu, 24 Jul 2003 13:26:01 EDT, Douglas J Hunley <doug@hunley.homeip.net>  said:

> Just had my athlon box lock-up solid. needed SysRq to reboot the thing.. 
> kernel info follows:
> Jul 24 13:08:23 doug kernel: Badness in pci_find_subsys at 
> drivers/pci/search.c:132
> Jul 24 13:08:23 doug kernel: Call Trace:
> Jul 24 13:08:23 doug kernel:  [<c02064a1>] pci_find_subsys+0x111/0x120
> Jul 24 13:08:23 doug kernel:  [<c02064df>] pci_find_device+0x2f/0x40
> Jul 24 13:08:23 doug kernel:  [<c0206368>] pci_find_slot+0x28/0x50
> Jul 24 13:08:23 doug kernel:  [<f8a2ada4>] os_pci_init_handle+0x3a/0x67 

The 'badness in pci_find_subsys' may not be related to your hang. 

The NVidia msgs are basically caused by the fact that pci_find_slot() is
getting called in an interrupt, so we trigger the WARN_ON in pci_find_subsys().
The worry here is that we may be walking the PCI list on the interrupt side
while something else is hotplugging a new device into existence, causing it to
walk off the end of a inconsistent list.  Unless you actually crapped out right
at 13:08:23, it's probably unrelated.

(I was getting the same NVidia traceback on a regular basis (3-4 at every start
of the X server, and 1 at X server shutdown) under 2.5.72-mm3, they stopped
when I went to 2.5.73-mm1.  If you're still seeing them in 2.6.0-test1, I would
suspect something different in the -mm series is fixing them for me - first place
to look is what got added between 72-mm3 and 73-mm1.

--==_Exmh_-1206902696P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/IKfZcC3lWbTT17ARAj9TAJ96EYV8IF0PHb9CLBreNLILgX+kLwCfTNuL
6hR82svT+2orwVovSJd0/2s=
=e1a8
-----END PGP SIGNATURE-----

--==_Exmh_-1206902696P--
