Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbTD3MPh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 08:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbTD3MPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 08:15:36 -0400
Received: from chaos.analogic.com ([204.178.40.224]:19855 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262148AbTD3MPf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 08:15:35 -0400
Date: Wed, 30 Apr 2003 08:29:14 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: James Courtier-Dutton <James@superbug.demon.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Bug in linux kernel when playing DVDs.
In-Reply-To: <200304301201.h3UC19u23911@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.53.0304300822520.12971@chaos>
References: <3EABB532.5000101@superbug.demon.co.uk>
 <200304290538.h3T5cLu16097@Port.imtp.ilyichevsk.odessa.ua>
 <3EAE5DF5.1040209@superbug.demon.co.uk> <200304301201.h3UC19u23911@Port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Apr 2003, Denis Vlasenko wrote:

> On 29 April 2003 14:11, James Courtier-Dutton wrote:
> > >See? Sector # is increasing... Linux retries the read several times,
> > >then reports EIO to userspace and goes to next sectors.
> > > Unfortunately, they are bad too, so the loop repeats. Eventually it
> > > will pass by all bad sectors (if not, it's a bug) but it can take
> > > longish time.
> > >
> > >Apart of making max retry # settable by the user, I don't see how
> > >this can be made better. Pity. This is common problem on CDs...
> >
> > What is this EIO report. The CPU is never returned to user space
> > apps, so the app never sees any error.
>
> Are you sure that CPU never returned to the app?
> (strace is your friend...)
>
> > As for retries, for DVD playing we do not want the Linux kernel to do
> > any retries, because during DVD playback, we just want a very quick
> > response saying there was an error.
>
> Kernel is not yet telepathic.
>
> > The DVD playing application can
> > then skip forward 0.5 seconds and continue. If one sector fails on a
> > DVD, there is little or not point in reading the next sector. One has
> > to start reading from the next VOBU. (i.e. about 0.5 seconds skip.)
>
> You need a way to tell kernel that you want such behavior.
> "skip 0.5 sec on error" requirement is rather hard
> to describe to the kernel.
> --
> vda

The usual way of reading DVDs is to ignore all errors! You need
to handle DVD errors differently than CD/ROM errors. With CDs,
it is expected that all data that is read is perfect. With
DVDs, this is not the case. The implimentation problem becomes
one of how to tell the kernel that the combined DVD/CDROM is
one or the other. I don't know what W$ does about this, but
on my Compaq lap-top, DVDs just stream right along, even though
there are whole corrupted frames, while the same drive containing
a defective CD will retry practically forever.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

