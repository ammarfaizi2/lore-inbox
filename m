Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262375AbVCBR2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbVCBR2T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 12:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbVCBR0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 12:26:30 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:57096 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262370AbVCBRYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 12:24:50 -0500
Message-Id: <200503021723.j22HNMEQ019547@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, kai@germaschewski.name, sam@ravnborg.org,
       rusty@rustcorp.com.au, vincent.vanackere@gmail.com,
       keenanpepper@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Undefined symbols in 2.6.11-rc5-mm1 
In-Reply-To: Your message of "Wed, 02 Mar 2005 08:28:46 PST."
             <20050302082846.1b355fa4.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <422550FC.9090906@gmail.com> <20050302012331.746bf9cb.akpm@osdl.org> <65258a58050302014546011988@mail.gmail.com> <20050302032414.13604e41.akpm@osdl.org> <20050302140019.GC4608@stusta.de>
            <20050302082846.1b355fa4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1109784199_6557P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 02 Mar 2005 12:23:22 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1109784199_6557P
Content-Type: text/plain; charset=us-ascii

On Wed, 02 Mar 2005 08:28:46 PST, Andrew Morton said:
> Adrian Bunk <bunk@stusta.de> wrote:

> >  Why doesn't an EXPORT_SYMBOL create a reference?
> 
> It does, but that reference is within the same compilation unit as the
> definition.  IOW: there are no references to the symbol which are external
> to the symbol's file.   There's still nothing to drag that file in.

I just got bit by a similar issue myself last night.  Had a working 2.6.11-rc5-mm1 tree
compiled with gcc 3.4.  Then Fedora-devel had an update to gcc 4.0, so I
rebuilt the *same exact tree* with it, and it threw 3 errors at me, for
exit_orinoco() in drivers/net/wireless/orinoco.c and init_hermes() and exit_hermes()
in drivers/net/wireless/hermes.c.  Here's what the code looked like:

(hermes.c)
static int __init init_hermes(void)
{
        return 0;
}

static void __exit exit_hermes(void)
{
}

module_init(init_hermes);
module_exit(exit_hermes);

That's it.  As far as I can tell, gcc 4.0 semi-correctly determined they were both
static functions with no side effect, threw them away, and then the module_init
and module_exit threw undefined symbols for them.

My totally incorrect workaround was to stick a printk(KERN_DEBUG) in the body
of the 3 trimmed functions so they had side effects.

Anybody got a *better* solution?


--==_Exmh_1109784199_6557P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCJfaHcC3lWbTT17ARAndVAJ4xuHGfYVbOwaz7ovLSgkP4KkV+BgCfSqrO
utnbkH5qJSaEmXiP5LFsyPY=
=GU9d
-----END PGP SIGNATURE-----

--==_Exmh_1109784199_6557P--
