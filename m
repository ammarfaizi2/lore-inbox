Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311775AbSCNUsj>; Thu, 14 Mar 2002 15:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311773AbSCNUsR>; Thu, 14 Mar 2002 15:48:17 -0500
Received: from [206.40.202.198] ([206.40.202.198]:65433 "EHLO
	scsoftware.sc-software.com") by vger.kernel.org with ESMTP
	id <S311772AbSCNUsN>; Thu, 14 Mar 2002 15:48:13 -0500
Date: Thu, 14 Mar 2002 12:43:44 -0800 (PST)
From: John Heil <kerndev@sc-software.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>,
        Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
Subject: Re: IO delay, port 0x80, and BIOS POST codes
In-Reply-To: <a6qtb8$6fg$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0203141234170.1286-100000@scsoftware.sc-software.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2002, Linus Torvalds wrote:

> Date: Thu, 14 Mar 2002 19:23:20 +0000 (UTC)
> From: Linus Torvalds <torvalds@transmeta.com>
> To: linux-kernel@vger.kernel.org
> Subject: Re: IO delay, port 0x80, and BIOS POST codes
>
> In article <E16lZg3-0001Ug-00@the-village.bc.nu>,
> Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
> >> Unfortunately we can't read this information because Linux uses
> >> port 80 as "dummy" port for delay operations. (outb_p and friends,
> >> actually there seem to be a more hard-coded references to port
> >> 0x80 in the code).
> >
> >The dummy port needs to exist. By using 0x80 we have probably the only
> >port we can safely use in this way. We know it fouls old style POST
> >boards on odd occasions.
>
> In fact, port 0x80 is safe exactly _because_ it is used for BIOS POST
> codes, which pretty much guarantees that it will never be used for
> anything else. That tends to not be as true of any other ports.
>
> Also, it should be noted that to get the 1us delay, the port should be
> behind the ISA bridge in a legacy world (in a modern all-PCI system it
> doesn't really matter, because the ports that need more delays are
> faster too, so this works out ok).  That's why I personally would be
> nervous about using some of the well-specified (but irrelevant) ports
> that are on the PCI side of a super-IO controller.
>
> I suspect the _real_ solution is to stop using "inb_p/outb_p" and make
> the delay explicit, although it may be that some drivers depend on the
> fact that not only is the "outb $0x80" a delay, it also tends to act as
> a posting barrier.
>
> 			Linus

No, the better/correct port is 0xED which removes the conflict.

We've used 0xED w/o problem doing an embedded linux implementation
at kernel 2.4.1, where SMM issues were involved. (It was recommended
to me by an x-Phoenix BIOS developer, because of its safety as well as
conflict resolution,

Johnh

-
-----------------------------------------------------------------
John Heil
South Coast Software
Custom systems software for UNIX and IBM MVS mainframes
1-714-774-6952
johnhscs@sc-software.com
http://www.sc-software.com
-----------------------------------------------------------------

