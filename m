Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129800AbQK1Qxk>; Tue, 28 Nov 2000 11:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129891AbQK1Qxb>; Tue, 28 Nov 2000 11:53:31 -0500
Received: from 213-123-72-140.btconnect.com ([213.123.72.140]:26375 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S129800AbQK1QxX>;
        Tue, 28 Nov 2000 11:53:23 -0500
Date: Tue, 28 Nov 2000 16:25:11 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alexander Viro <viro@math.psu.edu>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: bug in count_open_files() or a strange granularity?
In-Reply-To: <Pine.GSO.4.21.0011281100430.9313-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0011281614350.1254-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

Thank you for the useful comments.

On Tue, 28 Nov 2000, Alexander Viro wrote:
> On Tue, 28 Nov 2000, Tigran Aivazian wrote:
> 
> >        /* switch the open fds from old_user to new_user */
> >         read_lock(&files->file_lock);
> >         nr_open = close_files(files, 0); /* 0 means don't close them */
> >         atomic_sub(nr_open, &old_user->files);
> >         atomic_add(nr_open, &new_user->files);
> >         read_unlock(&files->file_lock);
> 
> That makes no sense - how do you count the descriptors in shared ->files?
> And how on the Earth do you count SCM_RIGHTS packets? Because they make
> a great way to fool any use of that stuff for resource-limit type of
> applications (stash the descriptors into SCM_RIGHTS cookie, send them to
> yourself and close them).

Yes, both the shared file struct and the SCM_RIGHTS are not so easy to
account. I never said this is ready -- just work in progress. If you have
already done this, please let me know -- there is plenty of other things
to do and I don't wish to step on your toes.

> 
> Basically, I don't see what are you counting.
  ¬¬¬¬¬¬¬¬¬

it is not basic at all. The problems you point out are extremely complex
(at least the fd in transit issue, definitely is). 

So, yes it requires a bit more thought. I will come back when the issues
you pointed out are dealt with. Someone has added the 'files' field to the
'struct user_struct' so someone must have meant to put support for this
field to be something other than the meaningless 0 it currently is.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
