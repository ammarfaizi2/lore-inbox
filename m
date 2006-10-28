Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751676AbWJ1DS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbWJ1DS7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 23:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751678AbWJ1DS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 23:18:58 -0400
Received: from pool-72-66-199-112.ronkva.east.verizon.net ([72.66.199.112]:55237
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751665AbWJ1DS5 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 23:18:57 -0400
Message-Id: <200610280318.k9S3Ie72012885@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>, Cedric Le Goater <clg@fr.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc2-mm2 - process_session-helper breaks /sbin/killall5
In-Reply-To: Your message of "Fri, 20 Oct 2006 01:56:41 PDT."
             <20061020015641.b4ed72e5.akpm@osdl.org>
From: Valdis.Kletnieks@vt.edu
References: <20061020015641.b4ed72e5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1162005519_3365P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 27 Oct 2006 23:18:39 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1162005519_3365P
Content-Type: text/plain; charset=us-ascii

On Fri, 20 Oct 2006 01:56:41 PDT, Andrew Morton said:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc2/2.6.19-rc2-mm2/

> +add-process_session-helper-routine.patch
> +add-process_session-helper-routine-deprecate-old-field.patch
> +add-process_session-helper-routine-deprecate-old-field-tidy.patch
> +add-process_session-helper-routine-deprecate-old-field-fix-warnings.patch
> +add-process_session-helper-routine-deprecate-old-field-fix-warnings-2.patch
> +rename-struct-namespace-to-struct-mnt_namespace.patch
> +add-an-identifier-to-nsproxy.patch
> +rename-struct-pspace-to-struct-pid_namespace.patch
> +add-pid_namespace-to-nsproxy.patch
> +use-current-nsproxy-pid_ns.patch
> +add-child-reaper-to-pid_namespace.patch
> 
>  Start work on virtualising process sessions.

Sorry for the delay in spotting this one sooner (and I'm surprised apparently
nobody else has).  Was busy, didn't get a chance to bisect it at all till
today, and I only got as far as "one of the above patches".

System works fine, except when you go to shutdown.  When it hits the /sbin/killall5
call in /etc/init.d/halt, it kills *all* the processes, and we get a
nice message 'INIT: no more processes in current runlevel', and we're dead in
the water.  Checking with alt-sysrg-T shows that in fact, the only things
left running are the various kernel threads.  As near as I can tell, killall5
wasn't able to tell that its parent process was part of its process group,
so didn't refrain from killing it.

Any ideas/clues?

--==_Exmh_1162005519_3365P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFQswPcC3lWbTT17ARAkcSAKCNQfJe13ZVONv1go1zRBo299cxsgCgtmJc
Aa7JTah5pCg2cQznWdgO2/Q=
=Eyxy
-----END PGP SIGNATURE-----

--==_Exmh_1162005519_3365P--
