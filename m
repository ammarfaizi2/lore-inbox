Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282794AbRK0Egh>; Mon, 26 Nov 2001 23:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282798AbRK0EgZ>; Mon, 26 Nov 2001 23:36:25 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:37760 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S282794AbRK0Eft>; Mon, 26 Nov 2001 23:35:49 -0500
Date: Mon, 26 Nov 2001 21:39:24 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Mark Richards <richard@ecf.utoronto.ca>
Cc: Linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: Multiplexing filesystem
Message-ID: <20011126213924.A1287@vger.timpanogas.org>
In-Reply-To: <3C030FB4.C3303BE4@ecf.utoronto.ca> <20011126213438.A1254@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011126213438.A1254@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Mon, Nov 26, 2001 at 09:34:38PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Oh yeah.  The MS Distributed File System in W2K is actually 
a filter driver on top of their existings FS's.  So is 
the mail slot interface.

Jeff

On Mon, Nov 26, 2001 at 09:34:38PM -0700, Jeff V. Merkey wrote:
> 
> You may want to look at FS filter drivers in Windows 2000 as a good model
> for something like this.  Intermezzo also seems to do something a lot
> like this, but not to the Windows 2000 degree.  W2K has something 
> called a filter driver interface, which is super handy for 
> encryption, and going remote.  
> 
> The filter driver idea is pretty cool, and MS has been able to 
> implement some pretty cool stuff with it, like snap in virus 
> detection software across different file systems.  They also
> did something called a "mini-port" file system, which was a
> filter driver on top of their very complex IFS interface which
> made writing remote file systems, like network clients, as lot 
> easier and faster. 
> 
> The disadvantage to their approach was that several new 
> and nasty "viruses" showed up as filter drivers and used 
> this interface to trash file systems. 
> 
> Food for thought.
> 
> :-)
> 
> Jeff  
> 
> 
> 
> On Mon, Nov 26, 2001 at 10:59:48PM -0500, Mark Richards wrote:
> > Quick question, which I suspect has a long answer.
> > 
> > I would like to write a multiplexing filesystem.  The idea is as follows:
> > 
> > The filesystem would ideally wrap another filesystem, such as nfs or smbfs or
> > ext2.  Most operations would just be passed to the native fs call.  However, for
> > some files, selectable at run time by some control singal, would actually reside
> > on another file system.  The other filesystem would have to be mounted.
> > 
> > The idea is for a version controlling filesystem.  The server would be a network
> > server (hence the desire to wrap nfs) which presents a 'view' of the source
> > code.  When the user reserves a file for editing, the file is copied to the
> > local disk.  From that point on, the local file is referred to until the user
> > commits the change or unreserves the file.  Ideally, the local copy of the file
> > could be on any file system, not one that is necessarily local.  And this has to
> > be totally transparent to the user, except for the step where the user
> > 'reserves' the file.
> > 
> > I've thought about two ways to do this.  One is to wrap the 'versioning' file
> > system with a multiplexor that checks fs calls to see if they are referring to a
> > file that is on a different fs.  The other approach is to intercept calls to the
> > VFS to do the same trick.
> > 
> > I'm new to the whole filesystem-coding thing, so bear with me if what i've just
> > said makes no sense.  So, my question (I guess it wasn't quick after all) is:
> > Can it be done, and are either of my two approaches feasible?  Any suggestions
> > or tips?
> > 
> > Thanks,
> > Mark Richards
> > 
> > PS please CC me if possible.
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
