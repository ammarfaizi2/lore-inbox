Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263302AbTECMkF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 08:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263303AbTECMkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 08:40:05 -0400
Received: from pat.uio.no ([129.240.130.16]:58365 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263302AbTECMkD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 08:40:03 -0400
Date: Sat, 3 May 2003 14:52:26 +0200 (MEST)
From: =?iso-8859-1?Q?P=E5l_Halvorsen?= <paalh@ifi.uio.no>
To: Mark Mielke <mark@mark.mielke.cc>
cc: Chris Friesen <cfriesen@nortelnetworks.com>, bert hubert <ahu@ds9a.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: sendfile
In-Reply-To: <20030502210648.GA5322@mark.mielke.cc>
Message-ID: <Pine.SOL.4.51.0305031449080.27640@ellifu.ifi.uio.no>
References: <Pine.SOL.4.51.0304302102300.12387@ellifu.ifi.uio.no>
 <20030430192809.GA8961@outpost.ds9a.nl> <Pine.SOL.4.51.0304302317590.13406@thrir.ifi.uio.no>
 <20030430221834.GA23109@mark.mielke.cc> <Pine.SOL.4.51.0305010024180.334@niu.ifi.uio.no>
 <20030501042831.GA26735@mark.mielke.cc> <Pine.SOL.4.51.0305012303540.17001@fjorir.ifi.uio.no>
 <3EB1A029.7080708@nortelnetworks.com> <20030502024147.GA523@mark.mielke.cc>
 <3EB1F1CD.4060702@nortelnetworks.com> <20030502210648.GA5322@mark.mielke.cc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 May 2003, Mark Mielke wrote:

> On Fri, May 02, 2003 at 12:19:25AM -0400, Chris Friesen wrote:
> > According to this:
> >   http://asia.cnet.com/builder/program/dev/0,39009360,39062783,00.htm
> > using sendfile() is easier on the CPU due to less trashing of the TLB.
>
> Thanks for the link. It looks quite accurate.
>
> One question it raises in my mind, is whether there would be value in
> improving write()/send() such that they detect that the userspace
> pointer refers entirely to mmap()'d file pages, and therefore no copy
> of data from userspace -> kernelspace should be performed. The pages
> could be loaded and accessed directly (as they are with sendfile())
> rather than generating a page fault to load the pages. The TLB trashing
> does not need to occur.
>
> I guess the first response to this question would be 'why not use
> sendfile()?  it already exists, and people have already begun to use
> it...'
>
> My answer is that I don't like sendfile(). It is not-yet-standard, and
> is fairly limited. I could just be naive, but I think that:
>
>      write(fd, mmapped_file_pages, length);
>
> Could be transparently mapped to the sendfile() code in the kernel,
> minimizing the benefit of sendfile() having its own system call. It all
> comes down to optimization. The current implementation of mmap() is not
> optimal where mmap()'d file pages are passed as data to system calls.

This is somewhat similar to what I want to do as well. As long as sendfile
can have this, why cant we make write/send/... similar. Thus, removing the
copy operation. Then, one can easier support streaming applications (or
applications needing more control than sendfile)!

-ph

> mark

