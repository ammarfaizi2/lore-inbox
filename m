Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293027AbSCFB76>; Tue, 5 Mar 2002 20:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293041AbSCFB7m>; Tue, 5 Mar 2002 20:59:42 -0500
Received: from bitmover.com ([192.132.92.2]:26335 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S293027AbSCFB72>;
	Tue, 5 Mar 2002 20:59:28 -0500
Date: Tue, 5 Mar 2002 17:59:27 -0800
From: Larry McVoy <lm@bitmover.com>
To: Shawn Starr <spstarr@sh0n.net>, Dave Jones <davej@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [opensource] Re: Petition Against Official Endorsement of BitKeeper by Linux Maintainers
Message-ID: <20020305175927.C12235@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Shawn Starr <spstarr@sh0n.net>, Dave Jones <davej@suse.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020306022224.B6531@suse.de> <Pine.LNX.4.40.0203052045380.2082-100000@coredump.sh0n.net> <20020306015049.GA336@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020306015049.GA336@matchmail.com>; from mfedyk@matchmail.com on Tue, Mar 05, 2002 at 05:50:49PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2002 at 05:50:49PM -0800, Mike Fedyk wrote:
> On Tue, Mar 05, 2002 at 08:46:27PM -0500, Shawn Starr wrote:
> > 
> > The only problem I have with BK is it's slow on a Pentium 200Mhz, vs
> > CVS. ;/ Wish that would be fixed.
> > 
> 
> How much (wall clock) time will it take to produce a patch with bk
> compared to cvs?

On a 1Ghz Athlon (love those CPUs, AMD rocks my world),

[/tmp/linux-2.5] time bk export -tpatch -r+ > /tmp/P

real    0m2.410s
user    0m1.170s
sys     0m0.050s

That's a hot cache number, it's slower if we have to go to disk.

Bk could be faster, it's on our list.  The main thing for performance is
memory.  BK uses the file system as a cache, it mmaps the files and wants
them in the cache, life sucks if you don't have enough memory to fit the 
entire tree in memory.  "Sucks" is defined as "it takes too long".  Our
holy grail in terms of performance is to have all operations take less than
250 milliseconds, i.e., you hit return and you get your prompt back.

We have a long way to go to achieve that, bummer, but true.  For some
things, we are really fast.  We pull changes from a remote site
amazingly fast.  The downside is that we are paranoid about data and
we run the equiv of a fsck on the repository every time you update it.
So if you have a repository with 20,000 files and you pull on a one line,
one file, bugfix, we still open up and check every single file's checksum.
Which sucks from a performance point of view.

On the other hand, it finds bad disks, bad memory, etc.  Right away, before
it corrupts all your data.  It found some bad juju at one of our commercial
customers today, in fact.

We're working on nested repositories (think CVS modules) and those will limit
the check to the update "module", that will help a lot.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
