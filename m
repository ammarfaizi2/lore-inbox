Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280597AbRKOMLm>; Thu, 15 Nov 2001 07:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280618AbRKOMLd>; Thu, 15 Nov 2001 07:11:33 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:34565 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S280597AbRKOMLP>;
	Thu, 15 Nov 2001 07:11:15 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Martin Persson <martin@cendio.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with Linux 2.4.15-pre4 on an IBM ThinkPad 
In-Reply-To: Your message of "15 Nov 2001 10:25:34 BST."
             <vwk7wsv10x.fsf@akrulino.lkpg.cendio.se> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 15 Nov 2001 22:57:09 +1100
Message-ID: <1292.1005825429@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Nov 2001 10:25:34 +0100, 
Martin Persson <martin@cendio.se> wrote:
>However (there's always a however), now I have other problems with my
>laptop. The network comes right up and everything works just fine,
>except when I try to scp files on a few Mbytes from the laptop. When I
>try that, sometimes the scp just works nicely up to 99% where it
>stalls, sometimes it continues after a few seconds, sometimes it
>stalls infinitely (or at least for more than 10 minutes, I interrupted
>it).

I would suspect the Xircom driver (RBEM56G, right?).  I have similar
symptoms with RBEM56G in a Compaq laptop, ssh hangs during bulk
transfers and is sensitive to which direction the transfer was started.
"ifconfig eth0 -promisc" a few times will usually restart the transfer,
sometimes it takes "/etc/rc.d/init.d/pcmcia restart" to fix the
problem, then wait until TCP retransmission picks up again.

I don't believe ssh is at fault, it just causes the right set of
activity to trip the driver problem.  ifconfig eth0 -promisc reloads
CSR6 on the card and the problem goes away, without me touching the ssh
transfers.

This was on my list of problems to debug (after modutils, kdb, xfs,
kbuild 2.5, ...) but I managed to trip over the Ethernet cable and
completely broke the card.  The Realport cards are more resilient than
most PCMCIA network cards but they have their limits.

