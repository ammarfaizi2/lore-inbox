Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965195AbVJEOzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965195AbVJEOzd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 10:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965193AbVJEOzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 10:55:33 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:25952 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965195AbVJEOzc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 10:55:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O5yoRiZwx1V0ygL1QfMmguARjHxUcVSOIgnps82CW8ehVRFOjHHFNa9IzBFCFASI92tDSyARPUR35XLjyks3pxDpOa0wNnYCR7jwZ2cdKuPmU98i5UgPJDWzBgvtRoosJF89GFzqFJqYU3oyN5G5EXlAun6yus9D37RWsoFNeyk=
Message-ID: <3e1162e60510050755l590a696bx655eb0b7ac05aab6@mail.gmail.com>
Date: Wed, 5 Oct 2005 07:55:31 -0700
From: David Leimbach <leimy2k@gmail.com>
Reply-To: David Leimbach <leimy2k@gmail.com>
To: Nix <nix@esperi.org.uk>
Subject: Re: what's next for the linux kernel?
Cc: 7eggert@gmx.de, Marc Perkel <marc@perkel.com>,
       Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <87k6gsjalu.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it>
	 <E1EMutG-0001Hd-7U@be1.lrz> <87k6gsjalu.fsf@amaterasu.srvr.nix>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/05, Nix <nix@esperi.org.uk> wrote:
> On 4 Oct 2005, Bodo Eggert stated:
> > BTW: YANI: That about a tmpfs where all-numerical entries can only be
> > created by the corresponding UID? This would provide a secure, private
> > tmp directory to each user without the possibility of races and denial-of-
> > service attacks. Maybe it should be controlled by a mount flag.
>
> Wouldn't it be less kludgy to just use the existing private namespace
> stuff to provide each user with its own /tmp? (Or each user's session,
> rather, which is probably much easier, as that corresponds precisely to
> one process tree).
>

It would if the rest of the system really enforced this "privacy".  In
plan 9 /tmp is really a bind to /usr/$user/tmp.  And if you launch
something like "ramfs" [a userland 9P server] it binds a ram disk
device over /tmp by default unless you tell it otherwise, then you
have a ram-backed directory only for the current process and its
children in /tmp.  This is useful for pulling things out of the
encrypted storage like factotum keys [sort of like a keyring for all
factotum based authentication including 9P mounts and even ssh
connections that use no ssh-keys].  When your process goes away so
does the decrypted keyfile, pretty nice.

Back on topic...

The problem with private namespaces on Linux is that they really
aren't so much.  mount will update /etc/mtab for all to see and even
/proc/<pid>/mounts is world readable [though it doesn't give useful
bind information anyway on linux... just the disk device it appears].

On one hand you've got very specific information in mtab about all the
binding that's been done and on the other hand you've got not so
useful information on a per-process basis in /proc.

I think private namespaces could actually be made more-so but the rest
of the system has to cooperate and I doubt that I have the energy to
do the evangelism and requisite proofs of concept for Linux.  It's far
easier for me to just use Plan 9 and Inferno instead of trying to
assimilate Linux, even though I think I'd prefer Linux if it were more
like the former two.

Maybe it's time for another BSD fork? [*runs away from the disapproval*]

Dave
