Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129614AbQK2QyT>; Wed, 29 Nov 2000 11:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129669AbQK2QyJ>; Wed, 29 Nov 2000 11:54:09 -0500
Received: from 213-123-77-235.btconnect.com ([213.123.77.235]:9734 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S129614AbQK2QyF>;
        Wed, 29 Nov 2000 11:54:05 -0500
Date: Wed, 29 Nov 2000 16:25:33 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Alexander Viro <viro@math.psu.edu>, Andries Brouwer <aeb@veritas.com>,
        linux-kernel@vger.kernel.org
Subject: Re: access() says EROFS even for device files if /dev is mounted RO
In-Reply-To: <Pine.LNX.4.21.0011291612190.1306-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.21.0011291624530.1306-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

just to add (obvious!) -- whenever "uid" was mentioned I implied "uid and
gid"...

On Wed, 29 Nov 2000, Tigran Aivazian wrote:

> On Wed, 29 Nov 2000, Hugh Dickins wrote:
> > Sorry, I missed the point at issue here, and what changed when.
> > Assuming (perhaps wrongly) it's independent of filesystem type,
> > 
> > Solaris         yes             ok              ok
> > HP-UX           yes             EROFS           ok
> > 
> > I don't have UnixWare or OpenServer at hand to test,
> > guess UnixWare as Solaris, can report OpenServer tomorrow.
> > But it looks like a Floridan answer.
> 
> Hugh,
> 
> The classical interpretation of the access(2) system call is "do the same
> type of permission check as open(2) would do but using real uid in the
> credentials instead of effective (or on Linux fs) uid". So, the typical
> logic of access() would be:
> 
> duplicate credential structure
> replace euid with ruid (or with fsuid on Linux)
> install this tmp credential in the LWP (or task in Linux)
> do the same sort of lookupname() as open() would do
> restore saved credentials back
> 
> All I am saying is that if open on HP/UX allows writing but access denies
> it, it is definitely a bug (in HP/UX). Let's remember why access(2) was
> invented at all -- to allow setuid-privileged programs to do permission
> checks based on real uid instead of relying on open(2) to fail. This
> should make it clear that the two (access(2) and open(2)) should behave
> identically modulo the euid->ruid transformation.
> 
> Regards,
> Tigran
> 
> PS. This is the sort of dicussion where openly showing snippets of
> proprietary UNIX source code would benefit but, alas, we can't...
> 
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
