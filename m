Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287375AbSAMEMK>; Sat, 12 Jan 2002 23:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287950AbSAMEMB>; Sat, 12 Jan 2002 23:12:01 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:38139 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S287375AbSAMELv>;
	Sat, 12 Jan 2002 23:11:51 -0500
Date: Sat, 12 Jan 2002 23:11:49 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: initramfs buffer spec -- second draft
In-Reply-To: <3C40EE23.6010906@zytor.com>
Message-ID: <Pine.GSO.4.21.0201122305200.24774-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 12 Jan 2002, H. Peter Anvin wrote:

> > - The c_filesize should be zero for any non-regular file.
> > + The c_filesize can be non-zero only for regular files and symlinks.
> > + For symlinks data and c_filesize match the results of readlink(2).
> > + Having more than one link to a symlink is illegal.
> > 
> 
> Why can't you have more than one link to a symlink?

Basically, you'll have no decent way to preserve that when you unpack.

In our case we _can_ do that; in general there is no portable way to
create such links (semantics of link(2) wrt following links differs
even between Linux versions, let alone various Unices).

cpio(1) includes the symlink body with each instance and doesn't
even bother trying to link(2) them when unpacking.

