Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262856AbTE0DGI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 23:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262861AbTE0DGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 23:06:08 -0400
Received: from h80ad26c3.async.vt.edu ([128.173.38.195]:54400 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262856AbTE0DGE (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 23:06:04 -0400
Message-Id: <200305270319.h4R3J7J2002940@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: mikpe@csd.uu.se
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Fix NMI watchdog documentation 
In-Reply-To: Your message of "Mon, 26 May 2003 11:21:38 +0200."
             <200305260921.h4Q9LcNr022536@harpo.it.uu.se> 
From: Valdis.Kletnieks@vt.edu
References: <200305260921.h4Q9LcNr022536@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-945326166P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 26 May 2003 23:19:06 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-945326166P
Content-Type: text/plain; charset=us-ascii

On Mon, 26 May 2003 11:21:38 +0200, mikpe@csd.uu.se said:

> --- linux-2.5.69/arch/i386/kernel/apic.c.~1~	2003-04-20 13:08:15.000000000 +
0200
> +++ linux-2.5.69/arch/i386/kernel/apic.c	2003-05-26 11:11:19.000000000 +
0200
> @@ -617,7 +617,7 @@
>  		goto no_apic;
>  	case X86_VENDOR_INTEL:
>  		if (boot_cpu_data.x86 == 6 ||
> -		    (boot_cpu_data.x86 == 15 && cpu_has_apic) ||
> +		    (boot_cpu_data.x86 == 15) ||

OK, there's good news and bad news.  After doing that and lopping out the
dmi_scan.c blacklist entry, we get these msgs on boot (diffing against
a dmesg from before the above:

1c1
< Linux version 2.5.69 (valdis@turing-police.cc.vt.edu) (gcc version 3.2.3 20030422 (Red Hat Linux 3.2.3-4)) #4 Sun May 25 16:22:44 EDT 2003
---
> Linux version 2.5.69 (valdis@turing-police.cc.vt.edu) (gcc version 3.2.3 20030422 (Red Hat Linux 3.2.3-4)) #5 Mon May 26 20:03:44 EDT 2003
24c24,25
< No local APIC present or hardware disabled
---
> Local APIC disabled by BIOS -- reenabling.
> Found and enabled local APIC!
27c28
< Detected 1595.314 MHz processor.
---
> Detected 1595.413 MHz processor.
30c31
< Memory: 254416k/262024k available (2520k kernel code, 6888k reserved, 969k data, 144k init, 0k highmem)
---
> Memory: 254416k/262024k available (2520k kernel code, 6880k reserved, 969k data, 144k init, 0k highmem)
40c41
< CPU:     After generic, caps: 3febf9ff 00000000 00000000 00000080
---
> CPU:     After generic, caps: 3febfbff 00000000 00000000 00000080
48a50,56
> enabled ExtINT on CPU#0
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> Using local APIC timer interrupts.
> calibrating APIC timer ...
> ..... CPU clock speed is 1595.0017 MHz.
> ..... host bus clock speed is 99.0688 MHz.

So yes Virginia, there is a local APIC on the C840.

Now the bad news - out of 7 or 8 tries, the above was the only boot that lived
long enough for me to get a single-user prompt and do a dmesg into a file.
That try hung about 10 seconds later.  It never hung at the same place twice,
and always hung hard enough to require the "power button for 5 seconds to
poweroff" sledgehammer.  The common factor seemed to be hangs while talking
to the IDE drive - while mounting /, while checking the partition table,
etc.

One question - in apic.c, I see where clear_local_APIC() is called in
init_bsp_APIC(), connect_bsp_APIC(), and disable_local_APIC().  I however
don't see where/how it's called in the init_local_APIC() codepath, nor can
I convince myself that it obviously *shouldn't* be called...


--==_Exmh_-945326166P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+0tkqcC3lWbTT17ARAnmlAJ4gREh/LXouPF0bz4N3BIEhjJYNZACg2eVs
onlUGkxE63jAg6tbkxDfFHo=
=xB8L
-----END PGP SIGNATURE-----

--==_Exmh_-945326166P--
