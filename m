Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129423AbQLFJ6W>; Wed, 6 Dec 2000 04:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130000AbQLFJ6M>; Wed, 6 Dec 2000 04:58:12 -0500
Received: from 213-123-74-204.btconnect.com ([213.123.74.204]:48388 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129423AbQLFJ6A>;
	Wed, 6 Dec 2000 04:58:00 -0500
Date: Wed, 6 Dec 2000 09:29:36 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: test12-pre6
In-Reply-To: <Pine.GSO.4.21.0012060356290.14974-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0012060925020.1044-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2000, Alexander Viro wrote:
> They are not Linux-specific (check where they came from), so I would rather
> check 4.4BSD and SuSv2[1] be damned. I'll look it up tomorrow, right now I'm
> going down. Sorry.

4.4BSD (FreeBSD 4.2-release) returns EPERM for truncate on immutable (schg
or uchg), in which case current Linux truncate(2) is broken. So if we want
to return the same as FreeBSD then we either need to:

a) change
vfs_permission() (and make sure all other cases returning EPERM for
immutable is ok) or 

b) we need to move that explicit check in
do_sys_truncate() above the call to permission().

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
