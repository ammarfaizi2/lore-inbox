Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263529AbTEDGjz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 02:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263534AbTEDGjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 02:39:55 -0400
Received: from rtlab.med.cornell.edu ([140.251.145.175]:4511 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id S263529AbTEDGjx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 02:39:53 -0400
Date: Sun, 4 May 2003 02:52:21 -0400 (EDT)
From: "Calin A. Culianu" <calin@ajvar.org>
X-X-Sender: <calin@rtlab.med.cornell.edu>
To: Ingo Molnar <mingo@redhat.com>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
In-Reply-To: <Pine.LNX.4.44.0305030249280.30960-100000@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.33L2.0305040243390.2890-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I don't really get it, but I could be a bit braindead now.  I still don't
understand how the 0-16MB addresses are considered 'unjumpable' using the
ASCII string stack-smashing exploit.

IIRC, x86 ints have the high-order byte _last_ (ie the fourth byte).
What's to stop someone from, say, smashing a buffer (and consequently
return-address) on the stack using something like {0x01, 0x01, 0x01, 0x00}
which is really address '65793' in base-10.  The above is a valid ASCII
string (3 1's followed by a NUL) which could conceivably end up on the
stack as the result of an errant strcpy() or gets() or whatever...

Clearly this address is less than 16MB, so then it must be possible to
jump to memory below 16MB.

Am I missing something??

-Calin

On Sat, 3 May 2003, Ingo Molnar wrote:

>
> On Fri, 2 May 2003, Carl-Daniel Hailfinger wrote:
>
> > Ingo Molnar wrote:
> > >
> > > Furthermore, the kernel also remaps all PROT_EXEC mappings to the
> > > so-called ASCII-armor area, which on x86 is the addresses 0-16MB. These
> > [snipped]
> > > In the above layout, the highest executable address is 0x01003fff, ie.
> > > every executable address is in the ASCII-armor.
> >
> > If my math is correct,
> > 0x01000000 is 16 MB boundary
> > 0x01003fff is outside the ASCII-armor.
>
> the ASCII-armor, more precisely, is between addresses 0x00000000 and
> 0x0100ffff. Ie. 16 MB + 64K. [in the remaining 64K the \0 character is in
> the second byte of the address.] So the 0x01003fff address is still inside
> the ASCII-armor.
>
> > Another question: Last time I checked, there were some problems with
> > binary only drivers (to name one, NVidia graphics) and a non-executable
> > stack. Has this been resolved?
>
> i'm not using any binary-only drivers, so i have no idea. But as long as
> they use PROT_EXEC areas for code, they should be safe.
>
> 	Ingo
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


