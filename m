Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288297AbSAHUlG>; Tue, 8 Jan 2002 15:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288299AbSAHUk4>; Tue, 8 Jan 2002 15:40:56 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:18447 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288297AbSAHUkw>; Tue, 8 Jan 2002 15:40:52 -0500
Message-ID: <3C3B579D.7B8E534F@zip.com.au>
Date: Tue, 08 Jan 2002 12:33:33 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "marc. h." <heckmann@hbe.ca>, Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: [problem captured] Re: cerberus on 2.4.17-rc2 UP
In-Reply-To: <20020108164816.A5453@hbe.ca> from "marc. h." at Jan 08, 2002 04:48:17 PM <E16Nysp-0006tn-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > end_request: buffer-list destroyed
> > hda1: bad access: block=12440, count=-8
> > end_request: I/O error, dev 03:01 (hda), sector 12440
> > hda1: bad access: block=12448, count=-16
> 
> That looks like a race in the IDE/block layer (or somewhere above it maybe)
> Someone trashed a request in progress.
> 
> > Is this a bug or could it be the hardware's fault? The hardware is new lspci
> 
> Other people have reported it too. Its clearly a kernel race

Yes, I can generate it at will on two quite different IDE machines
with the run-bash-shared-mapping script from
http://www.zip.com.au/~akpm/ext3-tools.tar.gz

It's on my list of things-to-do, filed under "hard".  It even happens
on uniprocessor, with unmask_irq=0.

Interestingly, I _think_ it only ever occurs against the
swap device.  But I need to confirm this.  Marc, do you
have swap on /dev/hda1?

-
