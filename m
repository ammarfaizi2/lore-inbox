Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279917AbRJ3LZx>; Tue, 30 Oct 2001 06:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279918AbRJ3LZm>; Tue, 30 Oct 2001 06:25:42 -0500
Received: from [195.66.192.167] ([195.66.192.167]:21770 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S279917AbRJ3LZa>; Tue, 30 Oct 2001 06:25:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Robert Love <rml@tech9.net>
Subject: Re: [BUG] Smbfs + preempt on 2.4.10
Date: Tue, 30 Oct 2001 13:23:52 +0000
X-Mailer: KMail [version 1.2]
In-Reply-To: <01102919120800.05333@nemo> <3BDDA646.B5D0E526@lexus.com> <1004388815.805.11.camel@phantasy>
In-Reply-To: <1004388815.805.11.camel@phantasy>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01103013235202.00855@nemo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 October 2001 20:53, you wrote:
> > > I narrowed down Samba weirdness I observe on 2.4.10 to preempt patch.
> > > Plain 2.4.10 works fine, 2.4.10+preempt (with latency measurement
> > > turned on) is sometimes oopses, and sometimes reports 'file already
> > > exists' when I attempt to copy a file from WinNT box to Linux.
> > > Sometimes it works ok (50% or so...)
> >
> > Why not try a recent kernel + preempt?
>
> Yes, would you mind retesting on a recent kernel and a recent patch?

Will try 2.4.13 and report.

BTW:
I'd like to reduce latency in one specific place which bites me most
(latencies up to 400000usec) coz I use VESA fb:
a BKL in tty_io.c:712 (in do_tty_write()).
It looks like we need to move BKL into write()
and/or replace it with spinlock.
I can't find where that write() func ptr is coming
(tracked it to tty->ldisc.write, but failed to find out
where that field is assigned to).
Somebody enlighten me...

BTW #2:
You're doing excellent work, Robert. Thank you.
--
vda
