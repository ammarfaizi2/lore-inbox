Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbVACXbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbVACXbY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 18:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbVACX2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 18:28:51 -0500
Received: from li4-142.members.linode.com ([66.220.1.142]:49672 "EHLO
	li4-142.members.linode.com") by vger.kernel.org with ESMTP
	id S261959AbVACX0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 18:26:14 -0500
Message-ID: <54479.199.43.32.68.1104794772.squirrel@li4-142.members.linode.com>
In-Reply-To: <41D9C635.1090703@zytor.com>
References: <41D9C635.1090703@zytor.com>
Date: Mon, 3 Jan 2005 18:26:12 -0500 (EST)
Subject: Re: FAT, NTFS, CIFS and DOS attributes
From: "Michael B Allen" <mba2000@ioplex.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: sfrench@samba.org, linux-ntfs-dev@lists.sourceforge.net,
       samba-technical@lists.samba.org, aia21@cantab.net,
       hirofumi@mail.parknet.co.jp,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin said:
> I noticed that CIFS has a placeholder "user.DosAttrib" in cifs/xattr.c,
> although it doesn't seem to be implemented.
>
> Questions:
>
> a) is xattr the right thing?  It seems to be a fairly complex and
> ill-thought-out mechanism all along, especially the whole namespace
> business (what is a system attribute to one filesystem is a user
> attribute to another, for example.)

Ahh, just go with xattrs Pete :-> I don't see the namespace issue to be a
big deal. The interface does seem a *little* overdesigned. It would have
been adequate to just use the dev:ino pair from stat(2) and dump
namespaces altogether since the real performance critical apps will have
stat'd the living daylights out of the path trying to canonicalize the
case so the last thing you want to do is a path lookup.

> b) if xattr is the right thing, shouldn't this be in the system
> namespace rather than the user namespace?

If we're just thinking about MS-oriented discretionary access control then
I think the owner of the file is basically king and should be the only
normal user to that can read and write it's xattrs. So whatever namespace
that is (not system).

> c) What should the representation be?  Binary byte?  String containing a
> subset of "rhsvda67" (barf)?

Definitely binary.

Mike
