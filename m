Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262817AbSJLGih>; Sat, 12 Oct 2002 02:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262826AbSJLGig>; Sat, 12 Oct 2002 02:38:36 -0400
Received: from packet.digeo.com ([12.110.80.53]:34032 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262817AbSJLGig>;
	Sat, 12 Oct 2002 02:38:36 -0400
Message-ID: <3DA7C4C2.58BCE2BC@digeo.com>
Date: Fri, 11 Oct 2002 23:44:18 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.41 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rob Mueller <robm@fastmail.fm>
CC: linux-kernel@vger.kernel.org, Jeremy Howard <jhoward@fastmail.fm>
Subject: Re: Strange load spikes on 2.4.19 kernel
References: <0f3201c2718c$750a13b0$1900a8c0@lifebook> <3DA77A20.2D28DBE7@digeo.com> <0f4301c27196$af8a8880$1900a8c0@lifebook> <3DA791E0.F0A1B11@digeo.com> <0fe701c271b9$e86ea910$1900a8c0@lifebook>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Oct 2002 06:44:18.0398 (UTC) FILETIME=[C9D747E0:01C271BA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Mueller wrote:
> 
> > If it was this, one would expect it to happen every time you'd written
> > 0.75 * 192 Mbytes to the filesystem.  Which seems about right.
> >
> > Easy enough to test though.
> 
> Hmmm, so why wouldn't the journal be flushing more regularly (the 5 seconds
> it's claiming in desg), or is that something we should ask on the ext3 list?

It commits your changes to the journal every five seconds.  But your data
is then only in the journal.  It still needs to be written into your files.
That writeback is controlled by the normal kernel 30-second writeback
timing.  If that writeback isn't keeping up, kjournald needs to
force the writeback so it can recycle that data's space in the journal.

While that writeback is happening, everything tends to wait on it.

It is suspected that ext3 gets the flushtime on those buffers
wrong as well, so the writeback isn't happening right.

> Apart from remounting the filesystem, is there any easy way to test this
> (again, silly mounted as /, so I think it's a reboot every time to try a new
> mounting configuration?)
> 

You'll need to reboot.
