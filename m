Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281831AbRKRACJ>; Sat, 17 Nov 2001 19:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281832AbRKRACA>; Sat, 17 Nov 2001 19:02:00 -0500
Received: from holomorphy.com ([216.36.33.161]:39307 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S281831AbRKRABy>;
	Sat, 17 Nov 2001 19:01:54 -0500
Date: Sat, 17 Nov 2001 16:01:34 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Martin Mares <mj@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] tree-based bootmem
Message-ID: <20011117160134.A11913@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Martin Mares <mj@ucw.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <20011117011415.B1180@holomorphy.com> <20011118001657.A467@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20011118001657.A467@ucw.cz>; from mj@ucw.cz on Sun, Nov 18, 2001 at 12:16:57AM +0100
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2001 at 12:16:57AM +0100, Martin Mares wrote:
> I don't understand why does it use segment trees instead of a simple
> linked list. Bootmem allocations are obviously not going to be time
> critical and shaving off a couple of ms during the boot process is
> not worth the extra complexity involved.
> 
> (Nevertheless, treaps are a very nice structure...)
> 
> 				Have a nice fortnight

Thanks for your comments.

Your opinions are valid and worthwhile, and I hope you don't mind if I
Cc: the Linux kernel mailing list in my reply.

The trees are largely there out of a personal distaste for exhaustive
search when not strictly necessary. My approach to this was to research
what data structures were appropriate for the search problem I found,
and to use that in preference to exhaustive search.

Some profiling by Jack Steiner prior to the initial post of this patch
to lkml revealed that it is a very rare system that has any issues with
the performance of the bitmap-based bootmem, and it's even less likely
there will be a noticeable difference in absolute terms between a search
tree structure and a linked list of ranges. While there were some
performance concerns motivating this, the primary concern was
interfacing with the callers and requiring less work to set up; that is,
making it easier to say "This memory belongs to this node." I had hoped
that in addition to suggestions regarding the mechanics, some suggestions
about how to make life easier for those who have to call bootmem
functions might arise from discussions about this.

Part of the motivation for the RFC is to solicit commentary like this
regarding the design, and in my responses, to adjust, alter, or even
entirely rewrite this patch in order to produce something useful and
desirable to the largest number of people. If linked lists are wanted,
then they can be used instead.

Is there a more general consensus regarding this aspect of the design?


Thanks,
Bill
