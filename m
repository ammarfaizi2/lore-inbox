Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281059AbRK0PPz>; Tue, 27 Nov 2001 10:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281009AbRK0PPr>; Tue, 27 Nov 2001 10:15:47 -0500
Received: from zeke.inet.com ([199.171.211.198]:34775 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S280822AbRK0PPe>;
	Tue, 27 Nov 2001 10:15:34 -0500
Message-ID: <3C03AE07.59A5DC14@inet.com>
Date: Tue, 27 Nov 2001 09:15:19 -0600
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7-10enterprise i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Richards <richard@ecf.utoronto.ca>
CC: Linux-kernel@vger.kernel.org
Subject: Re: Multiplexing filesystem
In-Reply-To: <3C030FB4.C3303BE4@ecf.utoronto.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Richards wrote:
> 
> Quick question, which I suspect has a long answer.
> 
> I would like to write a multiplexing filesystem.  The idea is as follows:
> 
> The filesystem would ideally wrap another filesystem, such as nfs or smbfs or
> ext2.  Most operations would just be passed to the native fs call.  However, for
> some files, selectable at run time by some control singal, would actually reside
> on another file system.  The other filesystem would have to be mounted.
> 
> The idea is for a version controlling filesystem.  The server would be a network
> server (hence the desire to wrap nfs) which presents a 'view' of the source
> code.  When the user reserves a file for editing, the file is copied to the
> local disk.  From that point on, the local file is referred to until the user
> commits the change or unreserves the file.  Ideally, the local copy of the file
> could be on any file system, not one that is necessarily local.  And this has to
> be totally transparent to the user, except for the step where the user
> 'reserves' the file.
> 
> I've thought about two ways to do this.  One is to wrap the 'versioning' file
> system with a multiplexor that checks fs calls to see if they are referring to a
> file that is on a different fs.  The other approach is to intercept calls to the
> VFS to do the same trick.
> 
> I'm new to the whole filesystem-coding thing, so bear with me if what i've just
> said makes no sense.  So, my question (I guess it wasn't quick after all) is:
> Can it be done, and are either of my two approaches feasible?  Any suggestions
> or tips?

I've heard of 'transparent' or 'stackable' filesystems that let you
mount a set of filesystems on top of each other, and changes are made to
the top level filesystem.  (I think the BSDs might have (had) that...)
If you were to use something like that, the 'reserve' step would be
transparent to the user, but the 'commit' (to the lower layer fs) would
not be.  (Mount the lower layer in some other place as well and write to
it for your commit.)

You might want to consider that approach since I think you would find a
number of other people would have other uses for the same filesystem. 
(And thus you might get more help, and have a chance of getting it into
(one of) the standard kernel(s).)
Hmm... it just occurred to me... multisession CDs do something
similar... That might have some benefits for those who do multisession
cd mastering--and that gives you more potential contributors.

Just some thoughts...  have fun!

Eli
--------------------.     Real Users find the one combination of bizarre
Eli Carter           \ input values that shuts down the system for days.
eli.carter(a)inet.com `-------------------------------------------------
