Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319388AbSILAk5>; Wed, 11 Sep 2002 20:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319389AbSILAk5>; Wed, 11 Sep 2002 20:40:57 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:22284 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S319388AbSILAk4>; Wed, 11 Sep 2002 20:40:56 -0400
Date: Wed, 11 Sep 2002 17:45:20 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Heuristic readahead for filesystems
Message-ID: <20020912004520.GD10315@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <200209112104.41987.oliver@neukum.name> <Pine.LNX.3.95.1020911151848.32205A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1020911151848.32205A-100000@chaos.analogic.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2002 at 03:21:37PM -0400, Richard B. Johnson wrote:
> On Wed, 11 Sep 2002, Oliver Neukum wrote:
> > Am Mittwoch, 11. September 2002 20:43 schrieb Xuan Baldauf:

> > > > Aio should be able to do it. But even that want help you with the stat
> > > > data.
> > >
> > > Aio would help me announcing stat() usage for the future?
> > 
> > No, it won't. But it would solve the issue of reading ahead.
> > Stating needs a kernel implementation of 'stat ahead'
> > -
> 
> I think this is discussed in the future. Write-ahead is the
> next problem solved. ?;)

Gating back to the original issue which was "readahead" of
stat() info...

The userland open of a directory could trigger an advance
reading of the directory data and of the inode structs of
all it's immediate members.  Almost all instances of a
usermode open on a directory will be doing fstats.  Even a
command line ls often has options (colour, -F, etc) turned on
by default that require fstat on all the entries.
The question would be how far ahead of the user app would
the kernel be.

I could possibly see having a fcntl() for directories to
pre-read just the first block of each file to accelerate
file-managers that use magic and perhaps forestall readahead
pulling in more than magic will use.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
