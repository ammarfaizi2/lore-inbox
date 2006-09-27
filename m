Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbWI0MwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWI0MwQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 08:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWI0MwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 08:52:16 -0400
Received: from pool-71-254-65-206.ronkva.east.verizon.net ([71.254.65.206]:57028
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932250AbWI0MwP (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 08:52:15 -0400
Message-Id: <200609271251.k8RCpp6X029724@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Horms <horms@verge.net.au>, Andrew Morton <akpm@osdl.org>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Stupid kexec/kdump question...
In-Reply-To: Your message of "Wed, 27 Sep 2006 02:00:07 MDT."
             <m1u02toi2g.fsf@ebiederm.dsl.xmission.com>
From: Valdis.Kletnieks@vt.edu
References: <200609261525.k8QFP6j4022389@turing-police.cc.vt.edu> <20060926221029.d9e87650.akpm@osdl.org> <20060927052737.GA17214@verge.net.au>
            <m1u02toi2g.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1159361510_3752P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 27 Sep 2006 08:51:50 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1159361510_3752P
Content-Type: text/plain; charset=us-ascii

On Wed, 27 Sep 2006 02:00:07 MDT, Eric W. Biederman said:

> I suspect the reason for the matching kernel from the distros is just
> that everything is quite new so they don't want to wonder if you old
> kernel has all of the appropriate support, and by that point they can
> probably assume the shipped kernel works.

And careful reading of the Fedora scripts shows how to provide your
own custom kernel/initrd pair. Setting the right variable in the right
config file will use that - if it's unset, it will go with a kernel
named ${kernelversion}kdump.

> >> > 2) I'm presuming that a massively stripped down kernel (no sound support,
> >> > no netfilter, no etc) that just has what's needed to mount the dump location
> >> > is sufficient?
> >
> > Yes

I'm definitely submitting a doc patch to explain all this in more detail, as
soon as I get it figured out enough. ;)

> >> > 3) The docs recommend 'crashkernel=64M@16M', but that's 8% of my memory.
> >> > What will happen if I try '16M@16M' instead?  Just slower copying due to
> >> > a smaller buffer cache space, or something more evil?
> >
> > There is a lower bound to how small you can make the space, which
> > is basically how little memory space your post-crash kernel needs.
> > 16M is probably pushing it, but 32M should be more than possible.
> > Experimentation is really the order of the day here.
> 
> At that level I would say that below 32M is where you start dealing with
> custom built programs, instead of slapping a bunch of utilities inside
> a ramdisk.  I suspect with a little care you could get a few K user
> space executable and fit everything inside of 4M.  But I don't know if anyone
> is that ambitious yet.

Well, the stripped down kernel is right around 2M.  Unfortunately, I need
to run lvm.static, which is another 1.5M at least.  So unless busybox has
grown support for LVM, I'm looking at 8M at best.

Another stupid question - I see how the first kernel gets the 'crashkernel='
parameter and knows how much space there is.  But if you set it to 32M@16M,
how does the kdump kernel know it only has 32M?  Or does it just start at
the 16M line, and it's your job to make sure it doesn't go over the 48M line
and start corrupting the dump?


--==_Exmh_1159361510_3752P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFGnPmcC3lWbTT17ARAv+1AJsGFdmkVRQU7ZDL5EUxZ9kWJKzNxgCeJFUW
UM1gaACHNIlF0mEF+aLZ7H0=
=N/47
-----END PGP SIGNATURE-----

--==_Exmh_1159361510_3752P--
