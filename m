Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261549AbSIXEbp>; Tue, 24 Sep 2002 00:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261551AbSIXEbp>; Tue, 24 Sep 2002 00:31:45 -0400
Received: from adedition.com ([216.209.85.42]:40196 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S261549AbSIXEbJ>;
	Tue, 24 Sep 2002 00:31:09 -0400
Date: Tue, 24 Sep 2002 00:35:02 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: Nanosecond resolution for stat(2)
Message-ID: <20020924003502.A3226@mark.mielke.cc>
References: <20020923214836.GA8449@averell> <20020924040528.GA22618@pimlott.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020924040528.GA22618@pimlott.net>; from andrew@pimlott.net on Tue, Sep 24, 2002 at 12:05:28AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2002 at 12:05:28AM -0400, Andrew Pimlott wrote:
> On Mon, Sep 23, 2002 at 11:48:36PM +0200, Andi Kleen wrote:
> > The kernel internally always keeps the nsec (or rather 1ms) resolution
> > stamp. When a filesystem doesn't support it in its inode (like ext2) 
> > and the inode is flushed to disk and then reloaded then an application
> > that is nanosecond aware could in theory see a backwards jumping time.
> > I didn't do anything anything against that yet, because it looks more
> > like a theoretical problem for me.
> ...
> I fear that there are applications that will be harmed by any
> spurious change in [mac]time, even if it's not backwards.  Apps that
> trigger on any change in mtime may trigger twice for every change.
> Eg, I suspect there is some scenario in which an rsync-like
> application that supports nanoseconds could suffer (just in
> performance, but still).

The behaviour does seem wrong. Resolution should not be faked to be
more accurate than the granularity offered by the underlying file
system. Timestamps can be persistently stored, or stored for longer
periods of times, for all sorts of reasons beyond 'make', each with
consequence that cannot be determined here.

What would it take to get microsecond or better time stored in ext[23]?

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

