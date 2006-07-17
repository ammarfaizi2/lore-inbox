Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWGQPNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWGQPNH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 11:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWGQPNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 11:13:07 -0400
Received: from gateway0.EECS.Berkeley.EDU ([169.229.60.93]:24277 "EHLO
	gateway0.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1750826AbWGQPNF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 11:13:05 -0400
From: "Jeff Anderson-Lee" <jonah@eecs.berkeley.edu>
To: "'fsdevel'" <linux-fsdevel@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
References: <44BAFDB7.9050203@calebgray.com> <1153128374.3062.10.camel@laptopd505.fenrus.org> <Pine.LNX.4.63.0607171242350.10427@alpha.polcom.net>
Subject: Re: Reiser4 Inclusion
Date: Mon, 17 Jul 2006 08:13:04 -0700
Message-ID: <000001c6a9b3$81186ea0$ce2a2080@eecs.berkeley.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <Pine.LNX.4.63.0607171242350.10427@alpha.polcom.net>
Thread-Index: Acapsw8vcZx4W9R0RQKTR6osqEJAEA==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.2663
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Kulewski wrote:

>I too tested Reiser4 some time ago. It didn't have any big problems for me.

>But I am not using (or testing) it now. Why? Mainly because of security: 
>if Reiser4 is not merged (even as a experminental, subject to change, 
>unstable, whatever) it will work with new kernels as long as Namesys will 
>release patches. And if something happens to Namesys I will have to port it

>to new kernels (and that is usually trivial for kernel developers 
>introducing incompatible internal kernel API changes but not for me) myself

>or will have to use old kernels. And _that_ is a problem for me. 

>(Not to mention that I am regulary applying 4-7 patches, some big ones, for

>every kernel I am building and resolving merge problems in not your code is

>not easy thing to do and takes time. While I can live without staircase 
>scheduler or vesafb-tng if my manual merge attempt fails I can not do so 
>without my main filesystem. And -mm is a little too unstable for me
recently.)
 
While I cannot speak directly to the Reiser4 component of this issue, I
would like to comment on this related issue.

In the past I've wondered why so many experimental FS projects die this
death of obscurity in that they only work under FreeBSD or some ancient
version of Linux.  I'm beginning to see why that is so:  the Linux core
simply changes too fast for it to be a decent FS R&D environment!

I have been looking at implementing a COW archival file system for Linux on
and off for some time now.  While I had hoped to develop these new FS ideas
under Linux, so that they could have a longer life-time and wider exposure,
that seems to be a pipe dream with the current situation.  The file system,
VFS, and mm code has been changing so much lately it would be like trying to
build on quicksand.  The LKML has such a high volume that I cannot afford
the time to follow it 100%, but issues that would affect FS development are
often raised there, instead of in linux-fsdevel.  linux-mm often contains
issues that would affect linux-fsdevel without cross posting.  The overhead
of following all of these lists is a huge burden of time that subtracts for
the time available for development (and the rest of my job).

I saw a log-structured file system being developed as a Google summer
project recently.  It's likely doomed to obscurity by the fs-related
code-churning in the Linux kernel.  Since it is "experimental" it won't be
included in the kernel distribution and hence won't get the benefit of
kernel developers making sweeping changes that touch all the file system
dependent code.  You practically need it to be your full-time job in order
to do any research or development work under Linux with this kind of
environment.

The frequent chant of LKML is "don't write a new f/s, make changes to an
existing FS".   While there is much merit to this approach it limits the
ideas that can be tried to small incremental changes.  Also, since every
existing f/s is essentially considered as "production", each change must be
vetted by the LKML -- not ideal for "experimentation".

Things that could make Linux a better environment for FS development might
include:

1) Create a F/S "sandbox" where experimental FS can be added that will be
benefit from sweeping changes that affect f/s specific code, or

2) A lessening (moratorium?) on sweeping changes for a while, so that FS
developers would have a chance to try new ideas without being flooded with
changes needed just to keep up with the latest kernel, or

3) Better isolation of the FS dependent and FS independent code, so that
fewer sweeping changes are needed.

Of these: (1) is likely impractical, as it imposes an additional burden on
kernel developers to support obscure or experimental f/s.  (2) is only a
stop-gap, as at some point sweeping changes might again be made that would
out-date most experimental f/s.  (3) seems the most logical course: work
towards a better interface between the FS dependent and independent layers
(e.g. VFS, mm) that does a better job of isolating the layers from each
other.

Without that, *BSD (and now possibly OpenSolaris) will be preferred over
Linux for FS research, which typically means that few if any people benefit
from the results: a loss for both Linux and the community at large.

Jeff Anderson-Lee
Petabyte Storage Infrastructure Project
UC Berkeley

