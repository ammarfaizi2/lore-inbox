Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286286AbRLJPRT>; Mon, 10 Dec 2001 10:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286285AbRLJPRK>; Mon, 10 Dec 2001 10:17:10 -0500
Received: from dsl-213-023-043-133.arcor-ip.net ([213.23.43.133]:21523 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S286283AbRLJPQw>;
	Mon, 10 Dec 2001 10:16:52 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Subject: Re: File copy system call proposal
Date: Mon, 10 Dec 2001 16:19:33 +0100
X-Mailer: KMail [version 1.3.2]
Cc: quinn@nmt.edu (Quinn Harris),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <200112100544.fBA5isV223458@saturn.cs.uml.edu>
In-Reply-To: <200112100544.fBA5isV223458@saturn.cs.uml.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16DSDU-0001EN-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 10, 2001 06:44 am, Albert D. Cahalan wrote:
> Daniel Phillips writes:
> 
> > There's some merit to this idea.  As Peter pointed out,
> > an in-kernel cp isn' needed: mmap+write does the job.
> > The question is, how to avoid the copy_from_user and
> > double caching of data?
> 
> No, mmap+write does not do the job. SMB file servers have
> a remote copy operation. There shouldn't be any need to
> pull data over the network only to push it back again!

Hi Albert,

I don't get it, you're saying that this zero-copy optimization, which happens 
entirely within the vfs, shouldn't be done because smb can't do it over a 
network?

> The user-space copy operation is also highly likely to
> lose stuff that the kernel would know about:
> 
> extended attributes   (IRIX, OS/2, NT)
> forks / extra streams   (MacOS, NT)
> creation time stamp   (Microsoft: not ctime or mtime)
> author   (GNU HURD: person who created the file)
> file type   (MacOS)
> creator app   (MacOS)
> unique ID   (Win2K)
> mandatory access control data   (Trusted Foo)
> non-UNIX permission bits   (every other OS)
> ACLs   (NFSv4, NT, Solaris...)
> translator   (HURD)
> trustees   (NetWare)

I'd think the mmap-based copy would only use the technique on the data 
portion of a file.

Note that I'm not seriously proposing to do this, there are about 1,000 more 
important things.  I'm suggesting the original poster go take a look at the 
issues involved in making it happen.

--
Daniel
