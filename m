Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263689AbUDQHOO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 03:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263710AbUDQHOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 03:14:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58293 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263689AbUDQHOM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 03:14:12 -0400
Date: Sat, 17 Apr 2004 09:13:35 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: "H. J. Lu" <hjl@lucon.org>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to make stack executable on demand?
Message-ID: <20040417071335.GA4296@devserv.devel.redhat.com>
References: <20040416170915.GA20260@lucon.org> <1082145778.9600.6.camel@laptop.fenrus.com> <20040416204651.GA24194@lucon.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <20040416204651.GA24194@lucon.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 16, 2004 at 01:46:51PM -0700, H. J. Lu wrote:
> On Fri, Apr 16, 2004 at 10:02:58PM +0200, Arjan van de Ven wrote:
> > >  But it will either fail if
> > > kernel is set with non-executable stack,
> > 
> > eh no. mprotect with prot_exec is still supposed to work. The stacks
> > still have MAY_EXEC attribute, just not the actual EXEC attribute
> 
> Ok. It looks like a bug in Red Hat EL 3 kernel. In fs/exec.c, there
> are
> 
>                 if (executable_stack)
>                         mpnt->vm_flags = VM_STACK_FLAGS | VM_MAYEXEC | VM_EXEC;
> 		else
>                         mpnt->vm_flags = VM_STACK_FLAGS & ~(VM_MAYEXEC|VM_EXEC); 

yep that's a bug


> The VM_MAYEXEC bit is untouched. Now the question is if it is a good
> idea for user to change stack permission.

it's required for correct operation and "security wise" it doesn't matter,
if someone can execute an mprotect syscall the game is over anyway 

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAgNkfxULwo51rQBIRAhE7AJ9qGdcwPS4t0U+myaQn3s58yoiiCwCfd77a
upCtQHseSjY6YIXmomBNL6E=
=DYLH
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
