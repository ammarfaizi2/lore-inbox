Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266709AbSKHBtE>; Thu, 7 Nov 2002 20:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266710AbSKHBtE>; Thu, 7 Nov 2002 20:49:04 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:5130 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S266709AbSKHBs7>; Thu, 7 Nov 2002 20:48:59 -0500
Date: Thu, 7 Nov 2002 17:55:33 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Why are exe, cwd, and root priviledged bits of information?
Message-ID: <20021108015533.GC2249@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33L2.0211071052540.8252-100000@rtlab.med.cornell.edu> <20021107221615.GA2249@pegasys.ws> <20021107222854.GA31412@nevyn.them.org> <200211071641.01585.pollard@admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211071641.01585.pollard@admin.navo.hpc.mil>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 04:41:01PM -0600, Jesse Pollard wrote:
> On Thursday 07 November 2002 04:28 pm, Daniel Jacobowitz wrote:
> > On Thu, Nov 07, 2002 at 02:16:15PM -0800, jw schultz wrote:
> > > On Thu, Nov 07, 2002 at 11:05:21AM -0500, Daniel Jacobowitz wrote:
> > > > On Thu, Nov 07, 2002 at 10:57:06AM -0500, Calin A. Culianu wrote:
> > > > > In the /prod/PID subset of procfs, why are the exe, cwd, and root
> > > > > symlinks considered priviledged information?
> > > > >
> > > > > Exe is the big one for me, as this one can be usually infered from
> > > > > reading /prod/PID/maps.  Root I guess can't be inferred in any
> > > > > unpriviledged way, and neither can cwd.  At any rate.. I am not sure
> > > > > behind the philosophy to make these symlinks' destinations
> > > > > priviledged...  can someone clarify this?
> > > >
> > > > This came up a little while ago.  The answer is that maps should be
> > > > priviledged also.
> > > >
> > > > For instance:
> > > >   You can protect a directory by giving its parent directory no read
> > > > permissions.  The name of the directory is now secret.  You don't want
> > > > to reveal it in cwd.
> > >
> > > Daniel is correct in that the issue came up recently.  He
> > > gives _his_ answer above.  If you believe in security
> > > through obscurity you will agree with him.  I don't.
> > > I will agree that there should be no real reason to need
> > > access to this information.
> > >
> > > With ACLs you will be able to explicitly grant access and
> > > you won't have to depend on keeping shared info secret.
> > > Then this will be less of an issue.
> >
> > I recommend you go think about what security through obscurity actually
> > _means_.  If you think that an unreadable directory and a
> > randomly-generated subdirectory is security through obscurity, then in
> > what way is it actually different from a _password_?  That's what it
> > is.
> >
> > Yes, this is poor-man's-ACLs.  It works in a lot of places when ACLs
> > won't.  For instance, an anonymous FTP server...
> 
> It also isn't necessarily just for obscurity.
> 
> If the directory contains customer contact lists, where each customer
> is represented by a directory entry, and all communications to/from that
> customer is stored in files. You don't want the cwd to be exposed by
> a process that may set its' workspace to a specific customer.
> 
> That is NOT security by obscurity. Exposure is called a "leak".
> And it is entirely possible for sensitive information to be embeded
> in pathnames, process names, and parameters (most often).

I painted with too broad a brush.  I apologize.

I'm afraid i'll never consider shared secrets to be secure.
They may provide privacy but not security.

Jesse's example where confidential information is part of
paths not permitted is an extremely good example of why
access to /proc/pid/maps should be restricted and by no
means qualifies for the pejorative i flung so thoughtlessly.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
