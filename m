Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbQLDU2Y>; Mon, 4 Dec 2000 15:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129226AbQLDU2O>; Mon, 4 Dec 2000 15:28:14 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:37083 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129401AbQLDU15>;
	Mon, 4 Dec 2000 15:27:57 -0500
Date: Mon, 4 Dec 2000 14:57:26 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Tigran Aivazian <tigran@veritas.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Attempt to hard link across filesystems results in
 un-unmountable filesystem (fwd)
In-Reply-To: <Pine.LNX.4.21.0012041829370.1134-100000@penguin.homenet>
Message-ID: <Pine.GSO.4.21.0012041455510.7166-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 4 Dec 2000, Tigran Aivazian wrote:

> It is true that your patch fixes the problem as reported but let us look
> one step deeper into the problem. Linux supports multiply mounted
> instances of a filesystem and the check in sys_link() comparing the
> mountpoints would refuse (with cross-device link error) linking between
> them. This is correct. However, one level down, inside vfs_link() we also
> check for ->i_dev match and that seems unnecessary, now that (with your
> patch) link(2) would work correctly anyway.
> 
> Therefore, I propose a slightly modified (tested under
> 2.4.0-test12-pre4) version of the patch. What do you think? My philosophy
> is -- since you made this feature work properly you should make it work
> efficiently too and that means removing redundant code. 

Tigran, think about the uses from knfsd.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
