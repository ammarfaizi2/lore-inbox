Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315457AbSILMh3>; Thu, 12 Sep 2002 08:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315483AbSILMh3>; Thu, 12 Sep 2002 08:37:29 -0400
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:8861 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S315457AbSILMh1> convert rfc822-to-8bit; Thu, 12 Sep 2002 08:37:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: Heuristic readahead for filesystems
Date: Thu, 12 Sep 2002 07:41:28 -0500
User-Agent: KMail/1.4.1
References: <200209112104.41987.oliver@neukum.name> <Pine.LNX.3.95.1020911151848.32205A-100000@chaos.analogic.com> <20020912004520.GD10315@pegasys.ws>
In-Reply-To: <20020912004520.GD10315@pegasys.ws>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209120741.28278.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 September 2002 07:45 pm, jw schultz wrote:
> On Wed, Sep 11, 2002 at 03:21:37PM -0400, Richard B. Johnson wrote:
> > On Wed, 11 Sep 2002, Oliver Neukum wrote:
> > > Am Mittwoch, 11. September 2002 20:43 schrieb Xuan Baldauf:
> > > > > Aio should be able to do it. But even that want help you with the
> > > > > stat data.
> > > >
> > > > Aio would help me announcing stat() usage for the future?
> > >
> > > No, it won't. But it would solve the issue of reading ahead.
> > > Stating needs a kernel implementation of 'stat ahead'
> > > -
> >
> > I think this is discussed in the future. Write-ahead is the
> > next problem solved. ?;)
>
> Gating back to the original issue which was "readahead" of
> stat() info...
>
> The userland open of a directory could trigger an advance
> reading of the directory data and of the inode structs of
> all it's immediate members.  Almost all instances of a
> usermode open on a directory will be doing fstats.  Even a
> command line ls often has options (colour, -F, etc) turned on
> by default that require fstat on all the entries.
> The question would be how far ahead of the user app would
> the kernel be.
>
> I could possibly see having a fcntl() for directories to
> pre-read just the first block of each file to accelerate
> file-managers that use magic and perhaps forestall readahead
> pulling in more than magic will use.

The problem now is that this becomes filesystem dependant.
Some of the filesystems will already have the inode loaded, and
if the inode is loaded, then the first block of the file is also loaded.

If the proposed readahead is done at the VFS level then multiple
reads will be issued for the same block, with some physical IO
reduction done due to cache hits.

This is starting to sound like a bit of overoptimization.

Still.. Try it. and on different filesystems and see what happens.

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
