Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280167AbRJaLzC>; Wed, 31 Oct 2001 06:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280179AbRJaLyw>; Wed, 31 Oct 2001 06:54:52 -0500
Received: from fep01-0.kolumbus.fi ([193.229.0.41]:2473 "EHLO
	fep01-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id <S280178AbRJaLyp>; Wed, 31 Oct 2001 06:54:45 -0500
Date: Wed, 31 Oct 2001 13:56:05 +0200 (EET)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: <makisara@kai.makisara.local>
To: Richard Kettlewell <rjk@greenend.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: problem with ide-scsi and IDE tape drive
In-Reply-To: <wwvady8vhfs.fsf@rjk.greenend.org.uk>
Message-ID: <Pine.LNX.4.33.0110311347580.3081-100000@kai.makisara.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2001, Richard Kettlewell wrote:

> Hi,
>
> I have a Seagate STT20000A IDE tape drive, which I am trying to use
> with the ide-scsi driver.  It worked well enough when moving data
> around to repartition recently, but I have discovered a repeatable
> problem.
>
> If I try and save a tar to the tape twice in succession, rewinding and
> reading forward to the same point each time first, the second attempt
> fails (details below).
[details cut]

Looking at your log everything seems to work perfectly from the point of
view of the drivers. The problem is that the first write command (from the
log cmd: a 1 0 0 3c 0 Len: 30720) is refused by your drive (the sense key
Illegal Request). The command looks OK (i.e., it is a write of 60 512 byte
blocks in fixed block mode).

Does your drive only accept writes from the beginning of the tape (there
are drives that have this limitation)? In this case the problem is that
you rewind and space forward between the two tar commands. You don't have
to rewind between the commands. The same result is obtained if you just
use two consecutive tar commands (and this means that writing only starts
from the beginning of the tape, from the drive's point of view).

	Kai


