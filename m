Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154407AbQAYPi0>; Tue, 25 Jan 2000 10:38:26 -0500
Received: by vger.rutgers.edu id <S154271AbQAYPeY>; Tue, 25 Jan 2000 10:34:24 -0500
Received: from smtp6.mindspring.com ([207.69.200.110]:2534 "EHLO smtp6.mindspring.com") by vger.rutgers.edu with ESMTP id <S154365AbQAYPdg>; Tue, 25 Jan 2000 10:33:36 -0500
Message-ID: <388DFBD8.5A89B100@10xinc.com>
Date: Tue, 25 Jan 2000 11:39:04 -0800
From: Iain McClatchie <iain@10xinc.com>
Organization: 10x
X-Mailer: Mozilla 4.6 [en] (X11; I; Linux 2.2.12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: SMP Theory (was: Re: Interesting analysis of linux kernel threading  by IBM)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

One of the problems with this forum is that you can't hear the murmur
of assent ripple through the hardware design crowd when Larry rants
about this stuff.  Larry has had his head out of the box for a long
time.

Look at the ASCI project.  The intention was for SGI to build an
Origin with around 1000 CPUs.  That Origin had extra cache coherence
directory RAM and special encodings in that RAM so that the hardware
could actually keep the memory across all 1000 CPUs coherent.  We
added extra physical address bits to the R10K to make this machine
possible.

Last I heard, the machine is mostly programmed with message passing.

I remember having a talk with an O/S guy who was implementing some
sort of message delivery utility inside the O/S.  This was when
Cellular IRIX was in development, and they were investigating having
the various O/S images talk to each other with messages across the
shared memory.  Then someone found out the O/S images could signal
each other FASTER through the HIPPI connections than they could
through shared memory.  That is, this machine had a HIPPI port local
to each O/S image, and all those HIPPI ports were connected together
via a HIPPI switch.

Those HIPPI connections were build with the _same_physical_link_ as
the shared memory - an 800 MB/s source-synchronous channel.  But if
you're sending a message, it's better to have the I/O system just
send the bits one way than have the shared memory system do two round
trips, one to invalidate the mailbox buffer for writing and another to
process the remote cache miss to receive the message.

-Iain McClatchie
www.10xinc.com
iain@10xinc.com
650-364-0520 voice
650-364-0530 FAX

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
