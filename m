Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286164AbRLJFpO>; Mon, 10 Dec 2001 00:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286165AbRLJFpE>; Mon, 10 Dec 2001 00:45:04 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:45318 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S286164AbRLJFo6>;
	Mon, 10 Dec 2001 00:44:58 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200112100544.fBA5isV223458@saturn.cs.uml.edu>
Subject: Re: File copy system call proposal
To: phillips@bonn-fries.net (Daniel Phillips)
Date: Mon, 10 Dec 2001 00:44:54 -0500 (EST)
Cc: quinn@nmt.edu (Quinn Harris),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <E16Chyk-0000zH-00@starship.berlin> from "Daniel Phillips" at Dec 08, 2001 02:57:17 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips writes:

> There's some merit to this idea.  As Peter pointed out,
> an in-kernel cp isn' needed: mmap+write does the job.
> The question is, how to avoid the copy_from_user and
> double caching of data?

No, mmap+write does not do the job. SMB file servers have
a remote copy operation. There shouldn't be any need to
pull data over the network only to push it back again!

The user-space copy operation is also highly likely to
lose stuff that the kernel would know about:

extended attributes   (IRIX, OS/2, NT)
forks / extra streams   (MacOS, NT)
creation time stamp   (Microsoft: not ctime or mtime)
author   (GNU HURD: person who created the file)
file type   (MacOS)
creator app   (MacOS)
unique ID   (Win2K)
mandatory access control data   (Trusted Foo)
non-UNIX permission bits   (every other OS)
ACLs   (NFSv4, NT, Solaris...)
translator   (HURD)
trustees   (NetWare)
