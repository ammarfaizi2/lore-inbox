Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261719AbTCaROu>; Mon, 31 Mar 2003 12:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261726AbTCaROu>; Mon, 31 Mar 2003 12:14:50 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:36813 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S261719AbTCaROt>; Mon, 31 Mar 2003 12:14:49 -0500
Date: Mon, 31 Mar 2003 09:24:04 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: bert hubert <ahu@ds9a.nl>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andries.Brouwer@cwi.nl,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Wim Coekaerts <Wim.Coekaerts@oracle.com>
Subject: Re: 64-bit kdev_t - just for playing
Message-ID: <20030331172403.GM32000@ca-server1.us.oracle.com>
References: <UTC200303272027.h2RKRbf27546.aeb@smtp.cwi.nl> <Pine.LNX.4.44.0303272245490.5042-100000@serv> <1048805732.3953.1.camel@dhcp22.swansea.linux.org.uk> <Pine.LNX.4.44.0303280008530.5042-100000@serv> <20030327234820.GE1687@kroah.com> <Pine.LNX.4.44.0303281031120.5042-100000@serv> <20030328180545.GG32000@ca-server1.us.oracle.com> <Pine.LNX.4.44.0303281924530.5042-100000@serv> <20030331083157.GA29029@outpost.ds9a.nl> <Pine.LNX.4.44.0303311039190.5042-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303311039190.5042-100000@serv>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 31, 2003 at 10:52:53AM +0200, Roman Zippel wrote:
> > Can you envision solutions based on 16 bit kdev_t infrastructure? 
> 
> I know that 16bit is getting small (but with dynamic assignment even 
> that is still enough for most people), but OTOH I don't understand the 
> obsession for 64bit. 32bit is more than enough on a 32bit system.

	There are big companies out there that require thousands of
disks.  Many don't want to use hardware raid, they just want JBOD.
There are installations today with 2k-4k disks covering the gamut from
massive databases to HPC to research facilities.  Today.
	A 32bit dev_t with the 12/20 Linus split provides 64k minors.
That's 16k disks with our current 15-partitions-per limit.  But if
someone wants 35 partitions (I've seen that somewhere) you're down to
8k.  And the places using 2-4k disks today will be getting to 8k disks
soon after 2.6 becomes usable, if not before.  They will likely hit 16k
disks before 2.6 becomes an afterthought.

> Somehow it sounds that we just have to introduce a huge dev_t and all our 
> problems are magically solved and I doubt that. If people want to encode 

	64bit dev_t is not a panacea.  However, if we have to do this
change, we want to do it once.  This only solves the space issue.  All
of the other issues, such as naming, are orthogonal to this change.
Holding one change until everything else has been written is silly.

> (Slowly I'm getting the feeling that there is some sort of 64bit dev_t 
> conspiracy going on here, with the amount of answers I'm (not) getting 
> here.)

	There is no conspiracy.  Everyone agrees we need more dev_t
space.  Peter, Andries, and others see it like I do; we only want to do
this once, and we already can see a day when 20bits of minors isn't
enough.

Joel

-- 

Life's Little Instruction Book #207

	"Swing for the fence."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
