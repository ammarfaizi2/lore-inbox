Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315388AbSILLez>; Thu, 12 Sep 2002 07:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315406AbSILLez>; Thu, 12 Sep 2002 07:34:55 -0400
Received: from chaos.analogic.com ([204.178.40.224]:8583 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S315388AbSILLey>; Thu, 12 Sep 2002 07:34:54 -0400
Date: Thu, 12 Sep 2002 07:41:09 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: jw schultz <jw@pegasys.ws>
cc: linux-kernel@vger.kernel.org
Subject: Re: Heuristic readahead for filesystems
In-Reply-To: <20020912004520.GD10315@pegasys.ws>
Message-ID: <Pine.LNX.3.95.1020912072949.2700A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Sep 2002, jw schultz wrote:

> On Wed, Sep 11, 2002 at 03:21:37PM -0400, Richard B. Johnson wrote:
> > On Wed, 11 Sep 2002, Oliver Neukum wrote:
> > > Am Mittwoch, 11. September 2002 20:43 schrieb Xuan Baldauf:
> 
> > > > > Aio should be able to do it. But even that want help you with the stat
> > > > > data.
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

Then you are tuning a file-system for a single program
like `ls`. Most real-world I/O to file-systems are not done
by `ls` or even `make`. The extra read-ahead overhead is
just that, 'overhead'. Since the cost of disk I/O is expensive,
you certainly do not want to read any more than is absolutely
necessary. There had been a lot so studies about this in the
70's when disks were very, very, slow. The disk-to-RAM speed
ratio hasn't changed much even though both are much faster.
Therefore, the conclusions of these studies, made by persons
from DEC and IBM, should not have changed. From what I recall,
all studies showed that read-ahead always reduced performance,
but keeping what was already read in RAM always increased
performance.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

