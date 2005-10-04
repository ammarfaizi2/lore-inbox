Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965006AbVJDWEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006AbVJDWEI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 18:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965007AbVJDWEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 18:04:08 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:6870 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S965006AbVJDWEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 18:04:07 -0400
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: what's next for the linux kernel?
To: Marc Perkel <marc@perkel.com>,
       Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Wed, 05 Oct 2005 00:04:01 +0200
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1EMutG-0001Hd-7U@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Perkel <marc@perkel.com> wrote:

[...]
> I'll run through a few ideas here.

> Novell Netware type permissions. ACLs are a step in the right direction
> but Linux isn't any where near where Novell was back in 1990. Linux lets
> you - for example - to delete files that you have no read or write
> access rights to.

It lets you unlink them. That's different from deleting, since the owner
may have his/her private link to that file.

Unlinking is changing the contents of a directory, and it's controlled by
the write permission of the containing directory.

> Netware on the other hand prevents you from deleting
> files that you can't write to and if you have no right it is as if the
> file isn't there.

Imagine a /tmp directory (writable by world) with user "a" creating a file
"foo", umask=077 and user "b" trying to do the same. User "b" will get
'file exists' if he tries to create it, and 'file does not exist' if he
tries to list it. He will go nuts.

BTW: YANI: That about a tmpfs where all-numerical entries can only be
created by the corresponding UID? This would provide a secure, private
tmp directory to each user without the possibility of races and denial-of-
service attacks. Maybe it should be controlled by a mount flag.

> You can't even see it in the directory. Netware also
> has inherited permissions like Windows and Samba has and this is doing
> it right.

You can't do that if you have hardlinks. However, I missed the feature of
overruling file permissions in some special directories, e.g. anything
put under /pub should ignore umask and be a+rX.

> File systems and individual directories should be able to be
> flagged as casesensitive/insensitive.

IMHO not needed.

> Permissions need to be fine
> grained and easy to use. Netware is a good example to emulate.

ACK.

> The bootup sequence of Linux is pathetic. What an ungodly mess.

Which one? The bsd-style, sysv-suse-style, the sysv-debian-style,
the sysv-gentoo-style, the supervise-style, ...?

> The
> FSTAB file needs to go and a smarter system needs to be developed.

Smarter than recognizing the partitions by GUID?

> I
> know this isn't entirely a kernel issue but it is somewhat related.
> 
> I think development needs to be done to make the kernel cleaner and
> smarter rather than just bigger and faster. It's time to look at what
> users need and try to make Linux somewhat more windows like in being
> able to smartly recover from problems.

Using "windows" and "smartly recover from problems" is strange.

> Perhaps better error messages

And it becomes even more strange. Decent error messsages from windows are
as common as snowballs in hell.

> that your traditional kernel panic or hex dump screen of death.

«Some error occured. Press "OK".»

And if there is a help button, it won't.

> The big challenge for Linux is to be able to put it in the hands of
> people who don't want to dedicate their entire life to understanding all
> the little quirks that we have become used to. The slogan should be
> "this just works" and is intuitive.

"Just working" isn't easy if you have zillions of dependencies and even
more possibilities to choose from. You can e.g. make linux use a raid0
of a network block device and a loop-mounted file accessed over a ssh
session as it's root device (just in case if you you got bored of drilling
holes into your knees, pooring milk into them and raising fish in them.)

-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
