Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129749AbQK1Qg1>; Tue, 28 Nov 2000 11:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129756AbQK1QgR>; Tue, 28 Nov 2000 11:36:17 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:2245 "EHLO math.psu.edu")
        by vger.kernel.org with ESMTP id <S129749AbQK1QgF>;
        Tue, 28 Nov 2000 11:36:05 -0500
Date: Tue, 28 Nov 2000 11:06:02 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Tigran Aivazian <tigran@veritas.com>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: bug in count_open_files() or a strange granularity?
In-Reply-To: <Pine.LNX.4.21.0011281552280.1254-100000@penguin.homenet>
Message-ID: <Pine.GSO.4.21.0011281100430.9313-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 28 Nov 2000, Tigran Aivazian wrote:

>        /* switch the open fds from old_user to new_user */
>         read_lock(&files->file_lock);
>         nr_open = close_files(files, 0); /* 0 means don't close them */
>         atomic_sub(nr_open, &old_user->files);
>         atomic_add(nr_open, &new_user->files);
>         read_unlock(&files->file_lock);

That makes no sense - how do you count the descriptors in shared ->files?
And how on the Earth do you count SCM_RIGHTS packets? Because they make
a great way to fool any use of that stuff for resource-limit type of
applications (stash the descriptors into SCM_RIGHTS cookie, send them to
yourself and close them).

Basically, I don't see what are you counting.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
