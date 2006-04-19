Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWDSSvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWDSSvj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 14:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWDSSvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 14:51:39 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:43991 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751148AbWDSSvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 14:51:38 -0400
Message-Id: <200604191850.k3JIoeYb015907@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Crispin Cowan <crispin@novell.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Karl MacMillan <kmacmillan@tresys.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, James Morris <jmorris@namei.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks 
In-Reply-To: Your message of "Wed, 19 Apr 2006 11:32:56 PDT."
             <44468258.1020608@novell.com> 
From: Valdis.Kletnieks@vt.edu
References: <E1FVtPV-0005zu-00@w-gerrit.beaverton.ibm.com> <1145381250.19997.23.camel@jackjack.columbia.tresys.com> <44453E7B.1090009@novell.com> <1145389813.2976.47.camel@laptopd505.fenrus.org>
            <44468258.1020608@novell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1145472640_2985P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 19 Apr 2006 14:50:40 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1145472640_2985P
Content-Type: text/plain; charset=us-ascii

On Wed, 19 Apr 2006 11:32:56 PDT, Crispin Cowan said:

> AppArmor initially validates your access at open time, and there after
> you can read&write to it without mediation. AppArmor re-validates your
> access if policy is reloaded, you exec() a new program, you get passed
> the fd from another process, or you call our change_hat() API.
> 
> So, if the file is unlinked or renamed while you have it open, and
> policy says you don't have access to the new name, then:
> 
>     * within the same process you get to keep accessing it until
>           o policy is reloaded by the administrator
>           o you call the change_hat() API
>     * in some other process, either a child or some process you passed
>       an fd to, you don't get to access it because your access gets
>       revalidated

My brain is small, and my eyes glaze over easily... ;)

What happens for the following sequence:

a) Process A does   fd = open("/some/protected");
b) Somebody then does an unlink("/some/protected");
c) A then does a fork/exec, handing the exec'ed process B the open FD 
as its stdin.

What name do you use to re-validate B's access to the data described by
the inode that open file is referencing?

Note that although B can't get any access to the data that A didn't have,
it can still be used to bypass security, because B may be able to *copy* that
data to an area where A couldn't write (presumably because A is in a confined box).

This can be mitigated by saying "A can't fork/exec" - which may not work if
A in fact needs to exec things (webserver CGI comes to mind).  I don't see
any provision for saying "A can only exec B, C, and D and nothing else..."

--==_Exmh_1145472640_2985P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFERoaAcC3lWbTT17ARAomCAJwMenZPgOCnAK+rRPK1+6wPj64YggCgvYV2
uTTRIxdYg13UMiRJhOGcpF0=
=Gu6S
-----END PGP SIGNATURE-----

--==_Exmh_1145472640_2985P--
