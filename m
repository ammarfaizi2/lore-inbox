Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130000AbQLFJZL>; Wed, 6 Dec 2000 04:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130454AbQLFJZB>; Wed, 6 Dec 2000 04:25:01 -0500
Received: from 213-123-74-204.btconnect.com ([213.123.74.204]:30468 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S130000AbQLFJYy>;
	Wed, 6 Dec 2000 04:24:54 -0500
Date: Wed, 6 Dec 2000 08:56:27 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: test12-pre6
In-Reply-To: <Pine.LNX.4.21.0012060838100.906-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.21.0012060854090.1044-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2000, Tigran Aivazian wrote:
>  	error = -EPERM;
>  	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
>  		goto dput_and_out;

also, while we are here -- are you sure that EPERM is a good idea for
IS_IMMUTABLE(inode)? Other parts of Linux return EACCES in this
case. Maybe it would be more consistent to do EACCES here too? This would
simply mean remove IS_IMMUTABLE() from the above if because
vfs_permission() does return -EACCES if we ask MAY_WRITE for IS_IMMUTABLE
inode.

Since, the SuSv2 standard is silent on the issue of immutable files (they
are Linux-specific) then it may make sense to be consistent?

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
