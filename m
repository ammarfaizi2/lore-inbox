Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263239AbTFXSYp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 14:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbTFXSYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 14:24:45 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:43025 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263239AbTFXSYc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 14:24:32 -0400
Date: Tue, 24 Jun 2003 14:31:16 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Willy Tarreau <willy@w.ods.org>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
In-Reply-To: <20030620220331.GA1100@alpha.home.local>
Message-ID: <Pine.LNX.3.96.1030624142334.6519H-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Jun 2003, Willy Tarreau wrote:

> On Fri, Jun 20, 2003 at 06:13:53PM -0300, Marcelo Tosatti wrote:
> > > Actually, without another copy of the data on a different system to
> > > verify it with, you can't know that for sure. It could easily be getting
> > > to the tape (the actual media) just fine, but then get corrupted during
> > > the verify readback.
> > 
> > Right. Stephan, if you could use a bit of your time to isolate the problem
> > I would be VERY grateful.
> 
> I remember Stephan once said that he used tar to verify the tape, and that for
> one backup, he did several tests showing corruption on different files. Altough
> that doesn't mean that the tape is written totally correctly, it at proves that
> there's at least a read corruption.
> 
> I think that comparing multiple reads to find a pattern in corruption offsets
> (if any) is the only thing he could do (not speaking about mixing read/writes
> with good/bad kernels). Of course, storing several times 70GB on disk is not
> easy, but at least a 16 bits checksum for each 1kB block would result on about
> 140 MB files, which will be "easier" to compare. It could be enough to check
> for empty blocks, duplicated blocks or totally random ones.

Actually, to find problems like this, a change to cpio would be useful:

  find /home | cpio -oB -Hcrc >/dev/st0

as an example. When reading back you will see errors from the CRC on each
file. I use cpio for this reason in some cases where knowing it's right
is critical.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

