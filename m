Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVF1TB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVF1TB0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 15:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbVF1TBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 15:01:07 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:43239 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261201AbVF1S6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 14:58:07 -0400
Message-Id: <200506281858.j5SIw2dr013640@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Sreeni <sreeni.pulichi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory Management during Program Loading 
In-Reply-To: Your message of "Tue, 28 Jun 2005 14:12:43 EDT."
             <94e67edf0506281112545d4766@mail.gmail.com> 
From: Valdis.Kletnieks@vt.edu
References: <94e67edf05062810497c7a20b5@mail.gmail.com> <200506281800.j5SI0FEe011475@turing-police.cc.vt.edu>
            <94e67edf0506281112545d4766@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1119985082_3764P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 28 Jun 2005 14:58:02 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1119985082_3764P
Content-Type: text/plain; charset=us-ascii

On Tue, 28 Jun 2005 14:12:43 EDT, Sreeni said:

> We have a "Bus Monitor hardware" which monitors and polices the bus at
> the specified physical address.

What does this hardware do, exactly, in addition to the usual memory-protection
capabilities of the main processor?  I suspect the answer to your query will
depend largely on what your monitor does, exactly, and what capabilities
it has, and what threat model you're trying to secure against....

> Basically we need to run "secure" program under the supervision of the
> Bus monitor hardware.

Is there an actual "threat model" here, as in "the attacker might try XYZ,
and this monitor is a defense because it does ABC, rendering XYZ ineffective"?

I'm unclear on how the monitor can provide any *real* security when it quite
likely does *not* have access to the entire state of the system (in particular,
if there's a security-critical value that's still in a CPU register or L1
cache line...)

> Kernel can see the "secure" memory region, and kernel is reponsible for enabling
> the "Bus monitor Hardware". 

The problem is that you're using an unsecured kernel to initially load the secure
memory region - so an attacker is free to load broken code into the secure
area.  The usual "trusted system" solution for this is to ensure that the kernel
*also* runs inside the tamper-proof evironment....

Or is the *real* question here "We have a bus analyzer that can't see all of
the physical memory, so we need the code we're interested in to be in the
part of physical memory it can see"?  If that's the case, totally different
answers will probably apply (as we don't have to do things in a "secure" manner,
we just need to get the right pages in the right frames before the analyzer is
turned on).....

--==_Exmh_1119985082_3764P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCwZ25cC3lWbTT17ARAigEAJ951HSkEOkeZwN529ZleCIOYal0HgCgxypu
DuLLSs1//shwLPn1gP9jijQ=
=GtsT
-----END PGP SIGNATURE-----

--==_Exmh_1119985082_3764P--
