Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129161AbQJ3JYS>; Mon, 30 Oct 2000 04:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129217AbQJ3JYH>; Mon, 30 Oct 2000 04:24:07 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:15366 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129161AbQJ3JXs>; Mon, 30 Oct 2000 04:23:48 -0500
Date: Mon, 30 Oct 2000 02:20:24 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Message-ID: <20001030022024.B20023@vger.timpanogas.org>
In-Reply-To: <20001030015546.B19869@vger.timpanogas.org> <Pine.LNX.4.21.0010301114480.3186-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0010301114480.3186-100000@elte.hu>; from mingo@elte.hu on Mon, Oct 30, 2000 at 11:27:04AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2000 at 11:27:04AM +0100, Ingo Molnar wrote:
> 
> On Mon, 30 Oct 2000, Jeff V. Merkey wrote:
> 
> > For example, if you put a MOV EAX, CR3;  MOV CR3, EAX; in a context
> > switching path, on a PPro 200, you can do about 35,000 context
> > switches/second
> 
> in 2.4 & Xeons we can do more than 100,000 context switches/second, and
> that is more than enough. But the point is: network IO performance does
> not depend on context switching speed too much. Also, in Linux we are
> using global pages which makes kernel-space TLBs persistent even across
> CR3 flushes.

This is putrid.  NetWare does 353,00,000/second on a Xenon, pumping out
gobs of packets in between them.  MANOS does 857,000,000/second.  This 
is terrible.  No wonder it's so f_cking slow!!!

> 
> > [...] There's also the use of segment registers all over the place to
> > copy from kernel to user and user to kernel space memory. [...]
> 
> we do not use the fs segment register for user-space copies anymore,
> neither in 2.2, nor in 2.4. You must be reading old books and probably
> forgot to cross-check with the kernel source? :-)


ds: and es: are both used in copy-to-user and copy-from-user and they get 
reloaded.


> 
> > [...] Having the fast paths you mention does help a lot, but it's the
> > fact that this goes on at all that will make it tough to walk into a
> > NetWare shop with Linux and rip out NetWare servers and replace them
> > unless we look at a NetWare vs. NetLinux (that's what we call it! a
> > NetWare-like Linux platform).
> 
> the worst thing you can do is to mis-identify performance problems and
> spend braincells on the wrong problem. The problems limiting Linux network
> scalability have been identified during the last 12 months by a small
> team, and solved in TUX. TUX is a fileserver, it shouldnt be alot of work
> to enable it for (TCP-only?) netware serving. It's *done*, Jeff, it's not
> a hypotetical thing, it's here, it works and it performs.
> 

NetWare is here too, and it handles 5000+ file and print users, Linux does not.
Let's fix it.  I know why NetWare is fast.  Let's apply some of the same 
principles and see what happens.  Love to have you involved.

> 	Ingo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
