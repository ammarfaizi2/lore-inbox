Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbUKWJrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbUKWJrb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 04:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261483AbUKWJra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 04:47:30 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:36473 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261286AbUKWJqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 04:46:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=R594qk5vL8QpEHLsNrhASGQpPFncER4HqYka0zIjXBoDh0hlYJi4VnqGGcyEwcoowczjvfoJUAasaZEhPIFG97Oq04iFCZOux7tei/kcqse7Ny5ZBh9zr5vF7wxfv+aa9WM9Pa9SXDq1J0x40PSVo3MLhRzhcKvFtT08rn0hwo4=
Message-ID: <2c59f00304112301467b411a46@mail.gmail.com>
Date: Tue, 23 Nov 2004 15:16:51 +0530
From: Amit Gud <amitgud1@gmail.com>
Reply-To: Amit Gud <amitgud1@gmail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: file as a directory
Cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0411222002380.21595@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <2c59f00304112205546349e88e@mail.gmail.com>
	 <200411221759.iAMHx7QJ005491@turing-police.cc.vt.edu>
	 <41A23566.6080903@namesys.com>
	 <Pine.LNX.4.53.0411222002380.21595@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2004 20:05:25 +0100 (MET), Jan Engelhardt
<jengelh@linux01.gwdg.de> wrote:
> >>(Hint - "file as directory" broke a number of programs that didn't
> >>expect that a file *could* be a directory, when run on a reiser4
> >>filesystem...)
> >
> >It broke extraordinarily few.
> 
> (The fewer the better.)
> 
> That's good news, and frankly, I did not expect anything else. That's because
> either programs definitely know that "it" is a file/directory because they just
> mkdir'ed or so, or they implement correct error checks, e.g. the user just
> created a directory and we check back (i.e. race protection).
> 

Correct me if I'm wrong, but the best way I know whether a file should
be treated as directory or as a file (atleast how I've implemented it)
depends upon the context (how the file is accessed) in the user-space
and this context is reflected in the kernel space in the flags of the
struct nameidata. So ...

----
        /* check if the archive is a path component or if last
component with slash */
	flags = (nd->flags & LOOKUP_CONTINUE) || (nd->flags & LOOKUP_DIRECTORY);
        if(flags)
               /* directory */
        else
               /* file */

----

> What I am worried about is the opendir() libc call, which AFAIK does this:
>   fd = open("directory", myflags | O_DIRECTORY)
> 

No more worries! Am I missing something?

AG
--
May the source be with you.
