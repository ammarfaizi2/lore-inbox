Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282985AbRK0XkM>; Tue, 27 Nov 2001 18:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282987AbRK0XkD>; Tue, 27 Nov 2001 18:40:03 -0500
Received: from outlook.developonline.com ([206.80.205.3]:43282 "EHLO
	usazdolexch0.developonline.home") by vger.kernel.org with ESMTP
	id <S282985AbRK0Xjs>; Tue, 27 Nov 2001 18:39:48 -0500
Subject: Re: Multiplexing filesystem
From: Blake Barnett <blake.barnett@developonline.com>
To: Mark Richards <richard@ecf.utoronto.ca>
Cc: Linux-kernel@vger.kernel.org
In-Reply-To: <3C030FB4.C3303BE4@ecf.utoronto.ca>
In-Reply-To: <3C030FB4.C3303BE4@ecf.utoronto.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 27 Nov 2001 16:39:38 -0700
Message-Id: <1006904378.6664.46.camel@shiva>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You may want to look into utilizing CVS for the check-in/check-out
mechanism and just virtualizing that layer on top of whatever FS is
being used.... 

This may be a good place to start looking.
http://sourceforge.net/projects/cvsfs/

If you don't need all the sophistication of CVS perhaps RCS would do.
 
The way Coda does it is by "hoarding" files, you specify what files you
want to hoard, and it refers to those as local only, when you "un-hoard"
them it syncs them with the server  (I think this is the process, it's
been a while since I played with it.)

I think intermezzo has something similar, but neither does any revision
control.


On Mon, 2001-11-26 at 20:59, Mark Richards wrote:
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
> 
> Thanks,
> Mark Richards
> 
> PS please CC me if possible.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Blake Barnett (bdb)  <blake.barnett@developonline.com>
Sr. Unix Administrator
DevelopOnline.com                 office: 480-377-6816

"Do, or do not.  There is no try." --Yoda

