Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314675AbSEPUen>; Thu, 16 May 2002 16:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314682AbSEPUem>; Thu, 16 May 2002 16:34:42 -0400
Received: from laclinux.com ([216.254.39.66]:6291 "EHLO laclinux.com")
	by vger.kernel.org with ESMTP id <S314675AbSEPUeh>;
	Thu, 16 May 2002 16:34:37 -0400
Date: Thu, 16 May 2002 14:34:41 -0600
From: G Sandine <lkml@laclinux.com>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: knfsd misses occasional writes
Message-ID: <20020516143441.A4322@laclinux.com>
In-Reply-To: <3CE250A5.47F71DF@uab.ericsson.se> <15586.20989.992591.474108@notabene.cse.unsw.edu.au> <3CE38E9D.986ACF7F@uab.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2002 at 12:49:01PM +0200, Sverker Wiberg wrote:
> Neil Brown wrote:
> > On Wednesday May 15, Sverker.Wiberg@uab.ericsson.se wrote:
> > > When copying lots of small files from multiple NFS clients to a kNFSd
> > > filesystem (i.e. doing backup of a cluster), exported with `sync', I
> > > find that some few files (1 out of 1000) were silently truncated to zero
>                                                   ^^^^^^^^
>                                                   no errors reported 
> > 
> > How are you mounting the file systems on the clients?
> > The symptoms sound exactly like you are using "soft" mounts.  "soft"
> > is a very bad mount option.  Use "hard".
> >
> > If you aren't using "soft", let me know and I will look harder.
> 
> Errrm, I am using "soft" mounts, as I (we) want the clients to survive
> server restarts.
> But shouldn't those timeouts become errors over at the clients?

I have seen this too, with a file system exported with rw,no_root_squash
and mounted hard,intr.  We were running vanilla 2.4.18 on the server
and clients.  We have a text file on the server serving to record
employees' time, and one day the time clock file remained a text file
but was truncated to zero.  All further punch ins/punch outs did not
record in the truncated file (user names, dates, and times should have
appended).  Deleting and recreating the text file on a client returned
behavior to normal.  No error messages whatsoever, and it has worked
fine for two weeks as we watch for the behavior to repeat.

Regards,
Gary S.
