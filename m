Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281244AbRKTTk4>; Tue, 20 Nov 2001 14:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281284AbRKTTkm>; Tue, 20 Nov 2001 14:40:42 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:23545 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281244AbRKTTk3>;
	Tue, 20 Nov 2001 14:40:29 -0500
Date: Tue, 20 Nov 2001 12:39:15 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: =?iso-8859-1?Q?Lu=EDs_Henriques?= <lhenriques@criticalsoftware.com>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: copy to suer space
Message-ID: <20011120123915.W1308@lynx.no>
Mail-Followup-To: =?iso-8859-1?Q?Lu=EDs_Henriques?= <lhenriques@criticalsoftware.com>,
	Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20011120165440.00a745b0@pop.cus.cam.ac.uk> <200111201714.fAKHEc276467@criticalsoftware.com> <20011120114124.T1308@lynx.no> <200111201849.fAKInr205178@criticalsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.4i
In-Reply-To: <200111201849.fAKInr205178@criticalsoftware.com>; from lhenriques@criticalsoftware.com on Tue, Nov 20, 2001 at 06:44:08PM +0000
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 20, 2001  18:44 +0000, Luís Henriques wrote:
> > Maybe if you describe the actual problem that you are trying to solve, and
> > not the actual way you are trying to solve it, there may be a better
> > method. Usually, if something you are trying to do is very hard to do,
> > there is a different (much better) way of doing it.
> 
> I'm developping a kernel module that needs to delay a process, that is, he 
> receives a PID and, when a specific event occurs, that process shall be 
> delayed. This delay shall be done in a way that the process keeps burning CPU 
> time (it can not be, e.g., put in a waiting-list...).

Putting it into a waiting-list is by far the best solution.  This is a normal
Unix operation, like SIGSTOP, SIGCONT, and could even be done from user space.

What is the requirement that it keeps burning CPU for?  Generally, this is
what you do NOT want to do.

Depending on what that is for, you could just increment the "system time"
ticks in the process, which is kind of a hack, but not nearly so ugly as
changing the user-space code (which is truly dreadful, and I don't think
anyone on this list would ever help you do that, even if they could).

The other alternative is to make your module such that upon entry, the
user process simply busy-waits until the delay is complete.  This is also
easy to do, with something like udelay().

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

