Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263220AbTJJXOK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 19:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263225AbTJJXOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 19:14:10 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:54913 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263220AbTJJXN7 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 19:13:59 -0400
Message-Id: <200310102313.h9ANDtRX009446@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Michael Jensen <kernel@millcreeksys.com>
Cc: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: [2.7 "thoughts"] V0.3 
In-Reply-To: Your message of "Fri, 10 Oct 2003 16:33:09 MDT."
             <1065825189.3f8733a55cfd4@secure.millcreeksys.com> 
From: Valdis.Kletnieks@vt.edu
References: <D9B4591FDBACD411B01E00508BB33C1B01F24E98@mesadm.epl.prov-liege.be> <1065820650.3f8721ea4162b@secure.millcreeksys.com> <200310102205.h9AM5lRX007520@turing-police.cc.vt.edu>
            <1065825189.3f8733a55cfd4@secure.millcreeksys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-557769179P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 10 Oct 2003 19:13:55 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-557769179P
Content-Type: text/plain; charset=us-ascii

On Fri, 10 Oct 2003 16:33:09 MDT, Michael Jensen said:

> I agree that it wouldn't have any effect on buffer overflows.  It would prevent
> further abuse of the system unless the perpetrator was able to install and load
> a modified kernel.  Even if they had root access, they would be unable to
> execute backdoor binaries because they would not be signed with a trusted key. 
> This would also thwart rootkits.

Umm... let me see if I got this straight...  They already exploited the system once
to get in originally, and you think that the same method that didn't stop them
from executing code to get in will also stop them from exploiting further?

All they need to do is park their code-to-execute in a file *anywhere* on the box,
and then invoke any of the numerous programs that have local buffer overflows,
and then use that program and an overflow sled to act as a poor-man's replacement
for /lib/ld-linux.

Hmm.. /bin/ls segfaults under some overflow conditions?  Just set up the
conditions, run /bin/ls, get the signed binary to run, and use it to load your
code. Game over. /bin/ls isn't exploitable?  Wander over to packetstorm and
pick and choose a ready-made exploit for lots of other stuff..

The basic problem here is that you're assuming that "the code loaded by exec()"
is trusted, therefor the code actually executed is trusted.  Given that most modern
processors are Von Neumann architectures rather than Harvard machines, that's a
problematic assumption.  That's why things like exec-shield or SELinux are probably
more productive directions - they are taking a different model:

exec-shield - We don't care if you're a trusted program, you're not executing off the stack.

SELinux - We don't care what binary you are, if you started in this security domain,
you're staying in it and having the restrictions enforced (yes, I know I'm simplifying
the issues with 'newrole' and the like)...

The important part is that what they *check* is actually related to the threat -
whereas checking the binary as protection against malicious code is essentially
a perverse case of a TOCTOU bug....

> Another problem that I see is that it would be quite easy to get around signed
> binaries if perl was one of those binaries.  Care would need to be taken in
> deciding what is trusted and signed.

As pointed out above, perl is just one of the problems.

> BTW - I like your suggestion of mounting everything either 'read only' or
> 'noexec', and using LSM.  I'm going to have to mess around with that.

Not to be snide or anything, if you haven't *already* investigated the existing
facilities (and found the issues with 'noexec', etc), you almost certainly haven't
thought through either the threat model or suitable defenses very thoroughly.



--==_Exmh_-557769179P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/hz0zcC3lWbTT17ARAi/8AKC8ULq1DkbRw/msz1ECyxCgAGDFtwCgiU7R
uh81zJ5Da+zKVhWQ+EvsXVs=
=eUlz
-----END PGP SIGNATURE-----

--==_Exmh_-557769179P--
