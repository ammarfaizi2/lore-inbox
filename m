Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131980AbRBKJC1>; Sun, 11 Feb 2001 04:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131469AbRBKJCS>; Sun, 11 Feb 2001 04:02:18 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:14861 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S131980AbRBKJCD>; Sun, 11 Feb 2001 04:02:03 -0500
Message-ID: <3A864D6A.FDE7F6E4@namesys.com>
Date: Sun, 11 Feb 2001 11:29:30 +0300
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: David Ford <david@blue-labs.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Daniel Stone <daniel@kabuki.eyep.net>,
        Chris Mason <mason@suse.com>, David Rees <dbr@spoke.nols.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: [reiserfs-list] Re: Apparent instability of reiserfs on 2.4.1
In-Reply-To: <E14RbJG-0001ds-00@the-village.bc.nu> <3A85AFC8.9070107@blue-labs.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford wrote:
> 
> Alan Cox wrote:
> 
> >> I run Reiser on all but /boot, and it seems to enjoy corrupting my
> >> mbox'es randomly.
> >> Using the old-style Reiser FS format, 2.4.2-pre1, Evolution, on a CMD640
> >> chipset with the fixes enabled.
> >> This also occurs in some log files, but I put it down to syslogd
> >> crashing or something.
> >
> >
> > Before you put that down to reiserfs can you chek 2.4.2-pre2. It may be
> > problems below the reiserfs layer
> 
> Just as an aside, I've watched this conversation go on and on while I
> run reiserfs on several servers, workstations, and a notebook.  I have
> current kernels and have watched carefully for corruption.  I haven't
> seen any evidence of corruption on any of them including my notebook
> which has a bad battery and bad power connection so it tends to
> instantly die.
> 
> Alan, is there a particular trigger to this?
> 
> -d

Guys, instability is a relative word.  One of our users in Russia said that
reiserfs was as stable as a mountain, and he didn't understand my email.   We
have some number of users, I wish I really knew how many.  If you look at a few
hundred thousand mountains, you'll discover that a number of them are really
quite unstable.  We used to get a bug report a week, now we get one or two a
day.  Does this mean we went from a few hundred thousand mountains to a few
million?  I don't really know.....  

I can assure the users though that we have an extensive testing procedure, and
that our releases all pass a testing that can roughly be described as hammering
the filesystem every different way we can think of (this is more limited than
what being put into the kernel by Linus does) for twelve or more hours.

What I do know is the following:  there was a recent elevator bug fix.  Our
filesystem is a journaling filesystem and it is extremely dependent on an
assumption that nothing is going to get written to disk before it should.  I
think fsck even makes assumptions about certain states relating to rename being
made atomic never reaching disk (and I think this is being fixed thanks to this
bug).  Could this cause the bug in which syslog gets zeros in it?  Don't know,
we haven't reproduced that bug yet though it "should" be straightforward to
reproduce.  We do have an NFS bug, which Nikita is still fixing.

What I can tell you is that in a few weeks we will have it back to a bug report
every week or two, and until we do version 4 of ReiserFS is going to be stalled 
(not so different from Linux 2.5 being stalled until 2.4 satisfies Linus).

Hans
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
