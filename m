Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131157AbRDPQAx>; Mon, 16 Apr 2001 12:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131205AbRDPQAm>; Mon, 16 Apr 2001 12:00:42 -0400
Received: from nat-hdqt.valinux.com ([198.186.202.17]:38477 "EHLO
	macallan.engr.valinux.com") by vger.kernel.org with ESMTP
	id <S131157AbRDPQAb>; Mon, 16 Apr 2001 12:00:31 -0400
From: Walt Drummond <drummond@engr.valinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15067.5912.594118.354056@macallan.engr.valinux.com>
Date: Mon, 16 Apr 2001 09:00:24 -0700
To: "Hubertus Franke" <frankeh@us.ibm.com>
Cc: george anzinger <george@mvista.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Bug in sys_sched_yield
In-Reply-To: <OF33FEDED1.EDF6D260-ON85256A2D.006D99DE@pok.ibm.com>
In-Reply-To: <OF33FEDED1.EDF6D260-ON85256A2D.006D99DE@pok.ibm.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Reply-To: drummond@engr.valinux.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke writes:
> I think that all data accesses particularly to __aligned_data
> should be performed through logical ids. There's a lot of remapping
> going on, due to the mix of logical and physical IDs.
> 
> If indeed the physical numbers are sparse (like we had on a 4x4
> NUMA system) then indexing doesn't work anyway.

This is exactly right.  On IA64, we have to hide the physical
processor ID (processor bus/local ID pair) completely.  As far as I
can see, but it's been awhile, so forgive me if I miss one or two,
IA64 doesn't expose the physical processor ID at all, outside the IPI
and AP startup code.

> The right approach to me seems to move everything including p->processor
> to logical and the few locations where needed otherwise (?) should
> be moved to have the translation from performed there.

Yep.  If not simply to make the generic kernel code clearer, this will
also make it easier to support non-linear (NUMA) systems.

--Walt
