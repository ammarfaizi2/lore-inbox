Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131386AbRCWTql>; Fri, 23 Mar 2001 14:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131392AbRCWTqc>; Fri, 23 Mar 2001 14:46:32 -0500
Received: from mail.valinux.com ([198.186.202.175]:6672 "EHLO mail.valinux.com")
	by vger.kernel.org with ESMTP id <S131386AbRCWTqG>;
	Fri, 23 Mar 2001 14:46:06 -0500
Message-ID: <3ABB8BB8.3A887F20@valinux.com>
Date: Fri, 23 Mar 2001 12:45:28 -0500
From: Jeremy Allison <jeremy@valinux.com>
Organization: VA Linux Systems
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.13-0.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, jeremy@valinux.com
Subject: Re: Status Of POSIX ACLs
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't read linux-kernel (too much traffic already on the Samba lists :-)
but I do read the kernel traffic summaries, and I noticed this item :

------------------------------------------------------------------------
"Jochen Dolze [*] asked, "i found at http://acl.bestbits.at the
ACL-linux-project.
Now i want to know, if there is a plan to integrate posix-ACLs into the
fs-part of
the kernel, e.g. into the VFS-Layer? Is there a general discussion about
this
anywhere? What are the biggest problems? (i know that many userland-tools
must
be changed for this)."

" Albert D. Cahalan [*] retched into his hand, and said he
hoped POSIX ACLs never got into the kernel. He added, "POSIX ACLs are crap.
NFSv4 mostly follows NT. Compatibility with NFSv4 and SMB (Samba's protocol)
is important."

And Bernd Eckenfels [*] added: AFAIK there is no Support in User Land
Programs
required. You just have additional tools for managing the ACLs . The main
problem
with ACLs are the storage of the additional info in the file system. This is
a
hard job if you want to have it for all/most file systems. Remy had a
working
Version for ext2, but it never got very public.. dunno why. NTs ACLs are
somewhat
messy cause they require too much scanning. 
------------------------------------------------------------------------

Well as I like to say, they may be crap, but at least they're
slow and buggy :-) :-).

Actually, the next rev. of Samba (2.2 which will ship soon)
will *depend* upon the POSIX ACL patch at http://acl.bestbits.at
in order to support ACLs on Linux.

The reason for this is that the ACL code there is reasonably
common (ie. enough for me to have a wrapper layer that hides
all the uglyness :-) enough to provide ACL support across
Solaris, HPUX, AIX, IRIX, Sco UnixWare (all of which have 
POSIX ACLs or something similar) and Linux.

In order to support ACLs, Samba needs to have an underlying
implementation of ACLs in the kernel, as Samba doesn't make
policy decisions on allowing file access in user-space (that
way root race holes lie... :-).

I just spent 3 weeks coding up a (somewhat) reasonable
mapping between NT ACLs and POSIX ACLs (ie., it's as good
as I can get it - and it's a *hard* problem :-) and it is
also the number ONE Samba feature request from shops that
use NT servers who are looking at Linux+Samba to get around
the "client access license" 'problem' :-).

If we don't eventually get them in the kernel I'm sure Sun
will be happy to suggest they convert to Samba on Solaris
to get the functionality they need :-) :-).

I certainly hope POSIX ACLs (or some form of ACL support)
does get into the kernel at some point (no, not NT ACLS - they
*suck* and are ordering dependent.... brrrrrrr :-) otherwise
there will be a host of applications for which Linux servers
will be disqualified for, and that would be a shame.

Please respond to samba-technical@samba.org or to me personally
if you want more timely feedback, else I'll wait for the next
kernel-traffic summary and take my answer off line (in the
grand tradition of polite radio talk show call in listeners :-).

Cheers,

	Jeremy Allison,
	Samba Team.

-- 
--------------------------------------------------------
Buying an operating system without source is like buying
a self-assembly Space Shuttle with no instructions.
--------------------------------------------------------
