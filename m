Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272697AbTHENet (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 09:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272718AbTHENet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 09:34:49 -0400
Received: from chaos.analogic.com ([204.178.40.224]:21121 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S272697AbTHENer
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 09:34:47 -0400
Date: Tue, 5 Aug 2003 09:36:37 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
In-Reply-To: <20030805150351.5b81adfe.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.53.0308050916140.5994@chaos>
References: <20030804141548.5060b9db.skraw@ithnet.com> <03080409334500.03650@tabby>
 <20030804170506.11426617.skraw@ithnet.com> <03080416092800.04444@tabby>
 <20030805003210.2c7f75f6.skraw@ithnet.com> <3F2FA862.2070401@aitel.hist.no>
 <20030805150351.5b81adfe.skraw@ithnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003, Stephan von Krawczynski wrote:

> On Tue, 05 Aug 2003 14:51:46 +0200
> Helge Hafting <helgehaf@aitel.hist.no> wrote:
>
> > Even more fun is when you have a directory loop like this:
> >
> > mkdir A
> > cd A
> > mkdir B
> > cd B
> > make hard link C back to A
> >
> > cd ../..
> > rmdir A
> >
> > You now removed A from your home directory, but the
> > directory itself did not disappear because it had
> > another hard link from C in B.
>
> How about a truly simple idea:
>
> rmdir A says "directory in use" and is rejected
>
> Which means you simply cannot remove the first directory entry before not all
> other links to it are removed. This implies only two things:
> 1) you have to know who was first.
> 2) you have to be able to find out where the links are.
>
> Both sound solvable.
>
> Regards,
> Stephan
>

A hard-link is, by definition, indistinguishable from the original
entry. In fact, with fast machines and the course granularity of
file-system times, even the creation time may be exactly the
same.

Without making one of the files different, and therefore not
a hard-link, there is no way for an operating system to distinguish
them except by keeping some list of hard-link inodes in some container
file or some other such atrocious misconduct. Then every significant
file operation would require a search of this inode-list to determine
the special handling of such hard-linked directories.

A directory hard-link to the same directory will cause any
recursive directory look-up to fail. It doesn't fail with
sim-links because they are specifically different and can be
excluded from the infinite recursion syndrome that would
exist otherwise.

Somebody mentioned that VAX/VMS would allow hard-linked
directories. This is not true. Even files, created with
SET FILE ENTER=DUA0:[1.DIR] DUA0:[000000] that seemed
like hard links were not hard links. They were sim-links.
The file entry contained the directory information of the
file being linked, and was not a clone of the header
(inode) itself as would be a hard link. Therefore, these
were unique and could not cause recursion to fail.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.

