Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262316AbREXVRK>; Thu, 24 May 2001 17:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262323AbREXVRB>; Thu, 24 May 2001 17:17:01 -0400
Received: from pop.gmx.net ([194.221.183.20]:42847 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S262297AbREXVQy>;
	Thu, 24 May 2001 17:16:54 -0400
Message-ID: <3B0D763C.26991788@gmx.de>
Date: Thu, 24 May 2001 22:59:40 +0200
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD 
 w/info-PATCH]device arguments from lookup)
In-Reply-To: <Pine.LNX.4.30.0105220957400.19818-100000@waste.org> <0105231550390K.06233@starship> <3B0C547F.DE9E9214@gmx.de> <0105241925230N.06233@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> > > Readdir fills in a directory type, so ls sees it as a directory and
> > > does the right thing.  On the other hand, we know we're on a device
> > > filesystem so we will next open the name as a regular file, and
> > > find ISCHR or ISBLK: good.
> >
> > ??? The kernel may know it, but the app?  Or do you really want to
> > give different stat data on stat(2) and fstat(2)?  These flags are
> > currently used by archive/backup prgs.  It's a hint that these files
> > are not regular files and shouldn't be opened for reading.
> > Having a 'd' would mean that they would really try to enter the
> > directory and save it's contents.  Don't know what happens in this
> > case to your "special" files ;-)
> 
> I guess that's much like the question 'what happens in proc?'.

And that's already bad enough.  Most of the "files" in proc should
be fifos!  And using proc as an excuse to introduce another set of
magic dirs?  No, thanks.

> Correct me if I'm wrong, but what we learn from the proc example
> is that tarring your whole source tree starting at / is not something
> you want to do.

IMHO it would be better to fix proc instead of adding more magic.  At
the moment you have to exclude /proc.  You want to add /dev.  And next?
Exclude all $HOME/dev (in case process name spaces get added)?  Or make
fifos magic too and add all of them to the exclude list?  But there's
no central place for fifos.  So lets add more magic :-(

> What *won't* happen is, you won't get side effects from opening
> your serial ports (you'd have to open them without O_DIRECTORY
> to get that) so that seems like a little step forward.

As already said: depending on O_DIRECTORY breaks POSIX compliance
and that alone should kill this idea...

Over and out, ET.

