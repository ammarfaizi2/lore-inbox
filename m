Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288928AbSAETVq>; Sat, 5 Jan 2002 14:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288929AbSAETVg>; Sat, 5 Jan 2002 14:21:36 -0500
Received: from 240.209-115-183-0.interbaun.com ([209.115.183.240]:60589 "EHLO
	polarbear.homenet") by vger.kernel.org with ESMTP
	id <S288928AbSAETVT>; Sat, 5 Jan 2002 14:21:19 -0500
Message-ID: <3C375208.99FF7DBC@phys.ualberta.ca>
Date: Sat, 05 Jan 2002 12:20:40 -0700
From: Dmitri Pogosyan <pogosyan@phys.ualberta.ca>
Organization: Dept of Physics, University of Alberta
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.9-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: ASUS KT266A/VT8233 board and UDMA setting
In-Reply-To: <E16MRhE-0003Rx-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> > Some RH kernels (may include yours) deliberately disable UDMA3, 4 and 5
> > on any VIA IDE controller. I don't know why. Unpatch your kernel and
> > it'll likely work.
>
> RH 2.4.2-x. That was before we had the official VIA solution to the chipset
> bug. It was better to be safe than sorry for an end user distro.
>

Yes, indeed.  Seems RH-2.4.16-0.13 kernel still enforces disabling UDMA>2 for
VIA,
by means of setting cable type to 40w, even if 80w is present

#cat /proc/ide/via

------------   ---Primary IDE-----Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:                    yes                  no
Post Write Buffer:               yes                  no
Enabled:                               yes                 yes
Simplex only:                         no                  no
Cable Type:                        40w                 40w


If I force higher UDMA by ide0=ata66 kernel option, as  discussed in RH bug
35274,
ide0 zero is set to UDMA5    (not the cable though) and everything is working.

I'll file a bug against RH kernel.

                Thanks everybody, Dmitri

