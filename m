Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311274AbSCLQf2>; Tue, 12 Mar 2002 11:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311275AbSCLQfT>; Tue, 12 Mar 2002 11:35:19 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:23561 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S311274AbSCLQe6>; Tue, 12 Mar 2002 11:34:58 -0500
Date: Tue, 12 Mar 2002 11:33:09 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <Pine.LNX.4.33.0203111638290.26250-100000@home.transmeta.com>
Message-ID: <Pine.LNX.3.96.1020312113106.31421A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002, Linus Torvalds wrote:

> 
> 
> On Mon, 11 Mar 2002, Bill Davidsen wrote:
> >
> > I think you might want to offer an opinion (or edict, mandate, whatever)
> > WRT taskfile. While I think that some protective editing of commands is
> > desirable, useful, etc, I'm damn sure that some form of raw access is
> > required long term to allow diagmostics. I wouldn't argue if that
> > interface was required for low level format and other really drastic
> > operations as well.
> 
> Quite frankly, my personal opinion is that there's no point in trying to
> parse the commands too much at all. The _only_ thing the kernel should try
> to care about is that the buffers passed to the command are valid (ie the
> actual data in/out area pointer should be a kernel buffer as far as
> possible, not under user control).
> 
> Basically, there are three "modes" of operation here:
> 
>  - regular kernel access (ie the normal read/write stuff)
> 
>    parsing: none. The kernel originated the request.
> 
>  - common ioctl's that have nothing to do with IDE per se (ie all the
>    stuff to open/close/lock removable media, unlocking DVD's, reading
>    sound sectors etc - stuff that really exists elsewhere too, and where
>    the kernel should do the translation from the generic problem space to
>    the specific commands for the bus in quesion)
> 
>    Parsing: common ioctl turning stuff into common SCSI commands in the
>    "struct request".

This next part is the one I believe should be a compile/boot option, since
it is the one which provides full access to the device.
 
>  - totally IDE-only stuff, where the kernel simply doesn't add any value,
>    and only has a way of passing it down to the drive, and passing back
>    the requests.
> 
>    Parsing: none. The kernel simply doesn't have anything to do with the
>    request, except to synchronize it with all other requests.

	[observations on sync and queue issues understood and snipped]
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

