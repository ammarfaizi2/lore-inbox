Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262330AbSI3OQJ>; Mon, 30 Sep 2002 10:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262317AbSI3OPX>; Mon, 30 Sep 2002 10:15:23 -0400
Received: from h80ad26c4.async.vt.edu ([128.173.38.196]:32904 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S262163AbSI3OOv>; Mon, 30 Sep 2002 10:14:51 -0400
Message-Id: <200209301419.g8UEJI6E001699@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [RFC] LSM changes for 2.5.38 
In-Reply-To: Your message of "Fri, 27 Sep 2002 19:59:19 BST."
             <20020927195919.A4635@infradead.org> 
From: Valdis.Kletnieks@vt.edu
X-Url: http://black-ice.cc.vt.edu/~valdis/
X-Face-Viewer: See ftp://cs.indiana.edu/pub/faces/index.html to decode picture 
X-Face: 34C9$Ewd2zeX+\!i1BA\j{ex+$/V'JBG#;3_noWWYPa"|,I#`R"{n@w>#:{)FXyiAS7(8t(
 ^*w5O*!8O9YTe[r{e%7(yVRb|qxsRYw`7J!`AM}m_SHaj}f8eb@d^L>BrX7iO[<!v4-0bVIpaxF#-)
 %9#a9h6JXI|T|8o6t\V?kGl]Q!1V]GtNliUtz:3},0"hkPeBuu%E,j(:\iOX-P,t7lRR#
References: <20020927003210.A2476@sgi.com> <Pine.GSO.4.33.0209270743170.22771-100000@raven> <20020927175510.B32207@infradead.org> <200209271809.g8RI92e6002126@turing-police.cc.vt.edu> <20020927191943.A2204@infradead.org> <200209271854.g8RIsPe6002510@turing-police.cc.vt.edu>
            <20020927195919.A4635@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1332808778P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 30 Sep 2002 10:19:18 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1332808778P
Content-Type: text/plain; charset=us-ascii

On Fri, 27 Sep 2002 19:59:19 BST, Christoph Hellwig said:

> insmod doesn't require modules to be in /lib/modules.

This would probably be closed by this code in sys_create_module():

        /* check that we have permission to do this */
        error = security_ops->module_ops->create_module(name, size);
        if (error)
                goto err1;

Similarly, there are other hooks that will stop renaming of the interface (I
have to admit I haven't had enough caffeine to verify whether doing a /bin/mv
to rename an interface will change the name that's presented to the iptables
rulesets), or did you have other "rename" methods in mind?

> Given that we really want to fine-grained control who's netdevice can get what
> names we'd` better place a hook in dev_alloc_name.

However, you're missing the point - I was using that as *AN EXAMPLE* of "you
might want to check what parameters are being passed".  Are you prepared to
make the same sort of analysis for *EVERY* parameter of *every* module, and
every combination thereof (including interacting parameters of different
modules)?

In order to assert that the hook to check parameters in module loading is
useless, you'd have to verify that there exist *NO* modules that can have their
security status changed by changing the parameters.  And even more importantly,
you'd have to make this a permanent restriction on module parameters,
which puts the onus on "getting it right" on the module author, rather than
on the LSM author who's in a better position to know what is/isn't acceptable
for his module.

> And that's my whole point: LSM adds random hooks all over the place without
> even thinking what they intend to protect.

And quite a bit of thought *did* go into it - a *LOT* of those hooks got added
along the way precisely *because* the writers of a module found that they were
trying to enforce a policy, and found it could be backdoored by means like
module parameters. Yes, there are some hooks that are unused by anything
at the current time (and there's discussion on the LSM list about pruning those
hooks), but I'll bet if you ask "why is hook XYZ in there?" on the LSM list,
somebody will be able to reply with "to close the hole of ABC".



-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_1332808778P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE9mF1mcC3lWbTT17ARAm2OAJ0SJRgUZBVEzMTQq2wpOo+CvLuCSwCg/oir
/R8YZh9jEfCHUmmU331sYlo=
=ZJbG
-----END PGP SIGNATURE-----

--==_Exmh_1332808778P--
