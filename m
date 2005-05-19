Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVESSpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVESSpw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 14:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbVESSpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 14:45:52 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:3601 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261218AbVESSpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 14:45:40 -0400
Message-Id: <200505191845.j4JIjVtq006262@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Linux Audit Discussion <linux-audit@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc4-mm2 - sleeping function called from invalid context at mm/slab.c:2502 
In-Reply-To: Your message of "Thu, 19 May 2005 12:34:08 BST."
             <1116502449.23972.207.camel@hades.cambridge.redhat.com> 
From: Valdis.Kletnieks@vt.edu
References: <200505171624.j4HGOQwo017312@turing-police.cc.vt.edu>
            <1116502449.23972.207.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1116528331_5456P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 19 May 2005 14:45:31 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1116528331_5456P
Content-Type: text/plain; charset=us-ascii

On Thu, 19 May 2005 12:34:08 BST, David Woodhouse said:
> On Tue, 2005-05-17 at 12:24 -0400, Valdis.Kletnieks@vt.edu wrote:
> > [4295584.974000] Debug: sleeping function called from invalid context
> > at mm/slab.c:2502

> OK, we'll just let audit_log() assemble its own skb and queue it for a
> separate kernel thread to feed up to auditd. We'll fix up the horrid
> error handling mess we had before too, where we used to clone the skb
> because we know netlink_unicast() would free it even on temporary errors
> (like the SO_RCVBUF limit being reached).
> 
> This includes one of Steve's earlier patches which ensures that messages
> in the skb are NUL-terminated. It should all appear some time soon in
> http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/dwmw2/audit-2.6.git;a
=summary
> or more perhaps more usefully (since Thomas allows us to distinguish
> between local and merged commits) in
> http://www.tglx.de/cgi-bin/gittracker/commit/tracker-linux/audit-2.6.git?proj
ect=tracker-linux%2Fdwmw2%2Faudit-2.6.git&pagelen=10&exclude=tracker-linux%2Fto
rvalds%2Flinux-2.6.git&offset=0
> 
> Index: kernel/audit.c
> ===================================================================
> --- e45ee43e7af31f847377e8bb3a0a61581732b653/kernel/audit.c  (mode:100644)
> +++ c1096ff7ae35b77bf8108c3a60b856551c50a9d7/kernel/audit.c  (mode:100644)

Patch applies with a few offsets against 12-rc4-mm2, and I'm not
seeing the messages any more...

--==_Exmh_1116528331_5456P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCjN7LcC3lWbTT17ARAv89AKDXM1YaQOdDYHibDgK94RVYKt3bkACeO7nC
ZE5djAyM+3MlCvSTOnkwhDA=
=aJAX
-----END PGP SIGNATURE-----

--==_Exmh_1116528331_5456P--
