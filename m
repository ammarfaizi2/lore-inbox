Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267034AbTAUMMW>; Tue, 21 Jan 2003 07:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267039AbTAUMMV>; Tue, 21 Jan 2003 07:12:21 -0500
Received: from edu.joroinen.fi ([195.156.135.125]:21898 "EHLO edu.joroinen.fi")
	by vger.kernel.org with ESMTP id <S267034AbTAUMMS>;
	Tue, 21 Jan 2003 07:12:18 -0500
Date: Tue, 21 Jan 2003 14:21:23 +0200
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To: Andy Johnson <andy@asjohnson.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Megaraid crash (Blocked mailbox......!!) with 2.4.19-aa and 2.4.20-aa
Message-ID: <20030121122123.GV19326@edu.joroinen.fi>
References: <fa.i7lhfnc.1ulm3ac@ifi.uio.no> <3E1E6492.3020300@asjohnson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E1E6492.3020300@asjohnson.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2003 at 12:13:38AM -0600, Andy Johnson wrote:
> Pasi Kärkkäinen wrote:
> >Hello!
> >
> >I've seen this at least 5 times now in one month.. One of our boxes die
> >when postgresql maintenance script AND backup cron jobs are ran at the =
> >same
> >time (by mistake - normally they are not ran at the same time)..
> >
> >So it seems to be related to high disk i/o. The adapter is 
> >HP NetRAID 1M with latest firmware. There is one RAID5 array with 3 dis=
> >ks
> >configured to it.
> >
> >Usually this crash happens 1 to 2 times a week.. always when cron start=
> >s to
> >run the stuff at the night. The console will be flooded with "Blocked
> >mailbox......!!" text (which surprisingly means that the megaraid firmw=
> >are
> >has stopped responding.. according to google)
> >
> >This box doesn't have high disk i/o at the daytime, only at the night w=
> >hen
> >cron starts to do things..
> >
> >When the cron jobs are not ran at the same time, the box is stable.
> >
> >
> >Other box using the same kind of adapter, but RAID1 array instead, havi=
> >ng
> >high disk i/o all the time doesn't have any problems.. (with the same k=
> >ernels).
> >
> >
> >Kernels are compiled with gcc 2.95.4 (Debian 3.0).
> >
> >
> >Any thoughts?
> 
> I saw this on one of our boxes running RH 6.2 with the 2.2.16 kernel
> a few times in one month.  Software doesn't get old and break, usually,
> so I turned the box off, reseated all the drives, and after I turned it
> back on, we never had that problem again.  I think this is one of those
> intermittent hardware problems.  The kind that are the most "fun" to
> solve.
> 
> Good Luck,
> 

Hello!

I got a couple of private replies too, and I think the problem is now fixed..

It seems to be a hardware/firmware problem with 4kB blocksize.
I was using the latest firmware, so I re-initialized the array with bigger
blocksize, and now everything works OK.

I also upgraded at the same time to the newest version of the megaraid
driver (1.18f), so that might have something to do with this also..

Anyway, the box seems to be stable now *knocking wood*.

The newest driver is available from here: 
http://domsch.com/linux/megaraid/

Remember to read the changelog, there are some notices about needed changes
to the sd.c (but they seem to be already taken care of in 2.4.20-aa).

Thanks to all who replied!


-- Pasi Kärkkäinen
       
                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.
