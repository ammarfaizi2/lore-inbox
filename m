Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVFNPmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVFNPmz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 11:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVFNPmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 11:42:55 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:15 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261171AbVFNPlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 11:41:21 -0400
Message-Id: <200506141540.j5EFeh6d014592@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Thomas Renninger <trenn@suse.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@ucw.cz>,
       Bernard Blackham <b-lkml@blackham.com.au>,
       Christian Hesse <mail@earthworm.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] Dynamic tick for x86 version 050609-2 
In-Reply-To: Your message of "Tue, 14 Jun 2005 11:39:27 +0200."
             <42AEA5CF.30100@suse.de> 
From: Valdis.Kletnieks@vt.edu
References: <88056F38E9E48644A0F562A38C64FB6004EBD10C@scsmsx403.amr.corp.intel.com> <20050609014033.GA30827@atomide.com> <20050610043018.GE18103@atomide.com> <200506130454.j5D4suNY006032@turing-police.cc.vt.edu> <20050613152507.GB7862@atomide.com> <200506131647.j5DGl0ke009926@turing-police.cc.vt.edu> <42ADC9E7.30901@suse.de> <200506131907.j5DJ7e4G017545@turing-police.cc.vt.edu>
            <42AEA5CF.30100@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1118763643_3658P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 14 Jun 2005 11:40:43 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1118763643_3658P
Content-Type: text/plain; charset=us-ascii

On Tue, 14 Jun 2005 11:39:27 +0200, Thomas Renninger said:

> There are two ways C-state addresses are exported to OS.
> 
>      - Some flags in the FADT (-> ACPI spec) -> this gives you two C-states maximum, AFAIK.

This must be what I have, because...

>      - Through the _CST function in your DSDT (-> ACPI spec, sorry). If you have
>        have a look in dsdt.dsl at the _CST function there are that much packages returned as
>        your BIOS claims to support. Hmm, _CST code is often in the SSDT an extention
>        of the DSDT code. If you have one: acpidmp > acpidmp; acpixtract ssdt acpidmp >my_ssdt;
>        iasl -d my_ssdt.

I tried (using pmtools-20031210 and acpica-unix-20050513):

acpidmp > c840.dmp
acpixtract dsdt c840.dmp > c840.dsdt
acpixtract ssdt c840.dmp > c840.ssdt
iasl -d c840.dsdt
iasl -d c840.ssdt

No signs of a _CST in either the DSDT or SSDT (in fact, xtract ssdt got me a
zero-length file, so I suspect there's no SSDT at all in there).

Oh well.. looks like short of BIOS/DSDT hacking, I'm stuck.  At least the
dynamic tick code got some testing out of all this... ;)

--==_Exmh_1118763643_3658P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCrvp7cC3lWbTT17ARAiLvAKDo0ZK4nl17ftWI+53MunD6O+F/cQCdE8An
YkA3/Gebwwrik4R3wF7ZbI4=
=+FJU
-----END PGP SIGNATURE-----

--==_Exmh_1118763643_3658P--
