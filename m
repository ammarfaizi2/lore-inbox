Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030223AbVJEQ0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbVJEQ0P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 12:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbVJEQ0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 12:26:15 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:15573 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S1030223AbVJEQ0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 12:26:14 -0400
Date: Wed, 5 Oct 2005 18:25:59 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: David Leimbach <leimy2k@gmail.com>
cc: Nix <nix@esperi.org.uk>, 7eggert@gmx.de, Marc Perkel <marc@perkel.com>,
       Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
In-Reply-To: <3e1162e60510050755l590a696bx655eb0b7ac05aab6@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0510051744480.2279@be1.lrz>
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it> 
 <E1EMutG-0001Hd-7U@be1.lrz> <87k6gsjalu.fsf@amaterasu.srvr.nix>
 <3e1162e60510050755l590a696bx655eb0b7ac05aab6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Oct 2005, David Leimbach wrote:

[snip quotes]

> It would if the rest of the system really enforced this "privacy".  In
> plan 9 /tmp is really a bind to /usr/$user/tmp.  And if you launch
> something like "ramfs" [a userland 9P server] it binds a ram disk
> device over /tmp by default unless you tell it otherwise, then you
> have a ram-backed directory only for the current process and its
> children in /tmp.
[...]

> This is useful for pulling things out of the
> encrypted storage like factotum keys [sort of like a keyring for all
> factotum based authentication including 9P mounts and even ssh
> connections that use no ssh-keys].  When your process goes away so
> does the decrypted keyfile, pretty nice.

You'd usurally just create+open a file and erase it without closing it.
The only access to this file is by using the file descriptor (or, off 
cause, /proc/pid/fd/num). If the last reference to this file, the running 
process, is gone, so is the file.

> Back on topic...
> 
> The problem with private namespaces on Linux is that they really
> aren't so much.  mount will update /etc/mtab for all to see and even

Userspace problem.-)

> /proc/<pid>/mounts is world readable [though it doesn't give useful
> bind information anyway on linux... just the disk device it appears].

There was some proc privacy patch some time ago. It was argued about 
because some sites want peer review on system usage. I lost track 
if it was included.

> I think private namespaces could actually be made more-so but the rest
> of the system has to cooperate and I doubt that I have the energy to
> do the evangelism and requisite proofs of concept for Linux.  It's far
> easier for me to just use Plan 9 and Inferno instead of trying to
> assimilate Linux, even though I think I'd prefer Linux if it were more
> like the former two.

The plan is:

1) make namespaces joinable
2) ???
3) profit

No, that's wrong. The plan is (should be?):

1) make namespaces joinable in a sane way
2) wait for the shared subtree patch
3) make pam join the per-user-namespace
4) make pam automount tmpfs on the private /tmp

-- 
Top 100 things you don't want the sysadmin to say:
44. System coming down in 0 min....
