Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288830AbSCKTD1>; Mon, 11 Mar 2002 14:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288248AbSCKTDS>; Mon, 11 Mar 2002 14:03:18 -0500
Received: from mail.gmx.de ([213.165.64.20]:63403 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S288058AbSCKTDL>;
	Mon, 11 Mar 2002 14:03:11 -0500
Message-ID: <3C8CFF64.1B55CDBB@gmx.net>
Date: Mon, 11 Mar 2002 20:03:01 +0100
From: Gunther Mayer <gunther.mayer@gmx.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linuxdiskcert.org>
CC: Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6 IDE 19, return of taskfile
In-Reply-To: <Pine.LNX.4.10.10203110945480.10583-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:

> On Mon, 11 Mar 2002, Martin Dalecki wrote:
>
> >
> > It wasn't a claim but just a suspiction. So this is cleared.
> > But apparently there is no special IBM command using taskfile
> > to do magic things to it. So therefore it's still valid:
> > your example was indeed a mock-up.
>
> No, mine has there real test base, I goto there Lab people and submit
> examples and questions and learn.  I doubt they will listen to you reading
> your code base, since you have claimed taskfile is wrong.  It was
> developed in concert with IBM.
>

The ANSI/NCITS ATA Standard documents lack proper definition what
a "task file" or "taskfile" is !  ATA-1, -2, -3 don't mention this (at least acroread
didn't find),
ATAPI-4 has 3 references but no definition. This is a serious omission for a
well-written standard !
Andre, will this be corrected in some newer standard you participate? ( Don't know
about ata-5/6 yet)

These two meanings certainly explain some confusion about "taskfile":
1) The IDE register set (e.g. 0x1f0-0x1f7) used by a special state-machine (e.g.
ATAPI)
2)  Andres implementation to export the "task file" to user mode
      (as in his patches which were refused by Linus)

Andre, your approach to "parse" the takfile access and let only known commands
through
must be weighted against a "generic" taskfile ioctl, where _I_ give all needed
state-machine information
(incl. state-machine as needed) to serve my reuqest.

Currently your taskfile access is hardcoded in tables in your ide patches and this is

inflexible (e.g. cannot support future commands, unknown at the time of your writing)
!

Your "case" structures and accompanying code are considered kernel bloat, because
it can be done in user code (with a "generic ioctl" and a "generic task file state
machine" which surely
can be extracted from your patch).

Regards, Gunther

P.S.
For some more fun read
http://support.microsoft.com/default.aspx?scid=kb;EN-US;q239700


