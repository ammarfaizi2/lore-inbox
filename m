Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314260AbSEBDpc>; Wed, 1 May 2002 23:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314264AbSEBDpb>; Wed, 1 May 2002 23:45:31 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:61429
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S314260AbSEBDpb>; Wed, 1 May 2002 23:45:31 -0400
Date: Wed, 1 May 2002 20:45:30 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Andre Hedrick <andre@linux-ide.org>, Stephen Samuel <samuel@bcgreen.com>,
        linux-kernel@vger.kernel.org
Subject: Re: A CD with errors (scratches etc.) blocks the whole system while reading damadged files
Message-ID: <20020502034530.GT574@matchmail.com>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	Andre Hedrick <andre@linux-ide.org>,
	Stephen Samuel <samuel@bcgreen.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10204260028140.10216-100000@master.linux-ide.org> <Pine.LNX.3.96.1020429173812.26335B-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2002 at 05:46:28PM -0400, Bill Davidsen wrote:
> On Fri, 26 Apr 2002, Andre Hedrick wrote:
> 
> > 
> > Basically it is a global design flaw from the beginning, and since I have
> > only 2.4 to address it is a real nasty!  Short version, each subdriver
> > personally does not do unique error handling.
> 
>   I'm snipping because obviously lots of folks are reading the previous
> posts. Since you clearly can see the issue, I will let this thread rest in
> hopes that we will have a patch to try and that it will make the whole
> problem shrink if not vanish.
> 
>   It seems the casual assumption that anyone who has a problem must be
> putting both devices on the same cable has been laid to rest, time to wait
> for new data and/or patches. I will try again next weekend to test the
> same problem using a totally separate (Promise) controller for the CD.

I found a CD that was having trouble reading, and put it on a 12x cd-rom
drive at /dev/hdc (hda - d = PIIX3).  The hard drive is on the Promise
controller (hde - h = Promise 20262).  Currently there are only two drives
in this system.

I ran:
while true; do find / -xdev -type f -print0 |xargs -0 cat > /dev/null; done

vmstat 1 > /dev/tty9

Then I ran `dd conv=noerror < /dev/hdc > /dev/null` and saw many resets and errors.

Now while this is happening and I'm listening to the hard drive tick away,
and hear the cd-rom drive trying to read the CD, and watching the vmstat
output. All is working great and smooth.

Now, I moved the cd-rom drive over to the promise controller (/dev/hdg,
that's on the *same* controller, but *different* cables (remember, there's
no hope if it's on the same cable as that's an IDE hardware design issue))
and reran the above test, and it was smooth too.

This is with 2.4.19-pre6-vm33, I haven't tested with other kernels.

I'll be adding 3 zip100s, 1 zip250, 1 cd-rw, and 1 ls-120 drive to this
system over the next few days as time permits, so I'll do more testing and
report.  As you can see, it'll be a big issue on this system if one drive
dominates the entire system.

Can someone else test some other kernel versions/trees?  I'd like this to see more
systematic testing so we can see what exactly triggers the problem.  

Oh BTW, I have a cmd649 ide controller I can test too, and in a month or three
I'll be able to test on a via chipset (but with an intel processor though).

Mike

lspci:
00:07.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]
00:0b.0 Unknown mass storage controller: Promise Technology, Inc. 20262 (rev 01)

hde: IBM-DPTA-372730, ATA DISK drive
hdg: TOSHIBA CD-ROM XM-5702B, ATAPI CD/DVD-ROM drive
