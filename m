Return-Path: <linux-kernel-owner+w=401wt.eu-S932443AbXAGJEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbXAGJEW (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 04:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbXAGJEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 04:04:22 -0500
Received: from 1wt.eu ([62.212.114.60]:1810 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932443AbXAGJET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 04:04:19 -0500
Date: Sun, 7 Jan 2007 10:03:36 +0100
From: Willy Tarreau <w@1wt.eu>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
       nigel@nigel.suspend2.net, "J.H." <warthog9@kernel.org>,
       Randy Dunlap <randy.dunlap@oracle.com>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       webmaster@kernel.org
Subject: Re: How git affects kernel.org performance
Message-ID: <20070107090336.GA7741@1wt.eu>
References: <458434B0.4090506@oracle.com> <1166297434.26330.34.camel@localhost.localdomain> <1166304080.13548.8.camel@nigel.suspend2.net> <459152B1.9040106@zytor.com> <1168140954.2153.1.camel@nigel.suspend2.net> <45A08269.4050504@zytor.com> <45A083F2.5000000@zytor.com> <Pine.LNX.4.64.0701062130260.3661@woody.osdl.org> <20070107085526.GR24090@1wt.eu> <45A0B63E.2020803@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A0B63E.2020803@zytor.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2007 at 12:58:38AM -0800, H. Peter Anvin wrote:
> Willy Tarreau wrote:
> >
> >At work, we had the same problem on a file server with ext3. We use rsync
> >to make backups to a local IDE disk, and we noticed that getdents() took
> >about the same time as Peter reports (0.2 to 2 seconds), especially in
> >maildir directories. We tried many things to fix it with no result,
> >including enabling dirindexes. Finally, we made a full backup, and switched
> >over to XFS and the problem totally disappeared. So it seems that the
> >filesystem matters a lot here when there are lots of entries in a
> >directory, and that ext3 is not suitable for usages with thousands
> >of entries in directories with millions of files on disk. I'm not
> >certain it would be that easy to try other filesystems on kernel.org
> >though :-/
> >
> 
> Changing filesystems would mean about a week of downtime for a server. 
> It's painful, but it's doable; however, if we get a traffic spike during 
> that time it'll hurt like hell.
> 
> However, if there is credible reasons to believe XFS will help, I'd be 
> inclined to try it out.

The problem is that I have no sufficient FS knowledge to argument why
it helps here. It was a desperate attempt to fix the problem for us
and it definitely worked well.

Hmmm I'm thinking about something very dirty : would it be possible
to reduce the current FS size to get more space to create another
FS ? Supposing you create a XX GB/TB XFS after the current ext3,
you would be able to mount it in some directories with --bind and
slowly switch some parts to it. The problem with this approach is
that it will never be 100% converted, but as an experiment it might
be worth it, no ?

Willy

