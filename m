Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316898AbSEaVUT>; Fri, 31 May 2002 17:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316952AbSEaVUS>; Fri, 31 May 2002 17:20:18 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:25716 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316898AbSEaVUR>; Fri, 31 May 2002 17:20:17 -0400
Date: Fri, 31 May 2002 23:19:51 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Cc: Andreas Hartmann <andihartmann@freenet.de>, linux-kernel@vger.kernel.org
Subject: Re: Memory management in Kernel 2.4.x
Message-ID: <20020531211951.GZ1172@dualathlon.random>
In-Reply-To: <fa.iklie8v.5k2hbj@ifi.uio.no> <fa.na0lviv.e2a93a@ifi.uio.no> <actahk$6bp$1@ID-44327.news.dfncis.de> <3CF23893.207@loewe-komp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2002 at 03:45:55PM +0200, Peter Wächtler wrote:
> Andreas Hartmann wrote:
> >Zwane Mwaikambo wrote:
> >
> >
> >>On Mon, 27 May 2002, Andreas Hartmann wrote:
> >>
> >>
> >>>rsync allocates all of the memory the machine has (256 MB RAM, 128 MB
> >>>swap). When this occures, processes get killed like described in the
> >>>posting before. The machine doesn't respond as long as the rsync -
> >>>process isn't killed, because it fetches all the memory which gets free
> >>>after a process has been killed.
> >>>
> >>And the rsync process never gets singled out? nice!
> >>
> >
> >Until it's killed by the kernel (if overcommitment isn't deactivated). If 
> >overcommitment is deactivated, the services of the machine are dead 
> >forever. There will be nothing, which kills such a process. Or am I wrong?
> >
> 
> There is still the oom killer (Out Of Memory).
> But it doesn't trigger and the machine pages "forever".
> Usually kswapd eats the CPU then, discarding and reloading pages,
> searching lists for pages to evict and so on.

can you reproduce with 2.4.19pre9aa2? I expect at least the deadlock
(if it's a deadlock and not a livelock) should go away.

Also I read in another email that somebody grown the per-socket buffer
to hundred mbytes, if you do that on a 32bit arch with highmem you'll
run into troubles, too much ZONE_NORMAL ram will be constantly pinned
for the tcp pipeline and the machine can enter livelocks.

Andrea
