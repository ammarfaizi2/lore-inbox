Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbTJFPHu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 11:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbTJFPHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 11:07:50 -0400
Received: from chaos.analogic.com ([204.178.40.224]:55938 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262232AbTJFPHr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 11:07:47 -0400
Date: Mon, 6 Oct 2003 11:09:42 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: John Bradford <john@grabjohn.com>
cc: Mikael Pettersson <mikpe@csd.uu.se>, Dave Jones <davej@redhat.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: FDC motor left on
In-Reply-To: <200310061425.h96EPhkP000548@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.53.0310061059220.9165@chaos>
References: <Pine.LNX.4.53.0310031322430.499@chaos> <20031003235801.GA5183@redhat.com>
 <Pine.LNX.4.53.0310060834180.8593@chaos> <16257.26407.439415.325123@gargle.gargle.HOWL>
 <Pine.LNX.4.53.0310060932340.8753@chaos> <200310061425.h96EPhkP000548@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Oct 2003, John Bradford wrote:

> > If you can end up with another floppy drive motor on under
> > any condition when the kernel is given control, then you
> > can simply reset both (or all) floppy motor control bits.
>
> This is not a problem to deal with in the kernel - what if there is
> hardware other than a floppy controller at that address?
>

In the ix86 architecture (and it is in arch-specific code), there
cannot be anything at this address except a floppy or nothing.
In both cases, you are covered.

I any embedded systems developer decides to put something besides
a FDC at that address, it is up to them to fix the problems they
create, not linux.

> The bootloader needs to ensure that the hardware is at least in a
> sensible state when the kernel is entered.  Infact, unless the system
> is being booted from floppy, why is the BIOS accessing the floppy at
> all?
>

The BIOS accesses the floppy (if one exists) because of the
boot order having been selected. Many who have computers,
that are not accessible to others, have the BIOS set up so
that the first thing to check for a boot-loader is the floppy,
then the CD-ROM, then the hard disk. This lets them do their
normal work without having to muck with the BIOS.

It is not an error to configure a machine this way. It
is an option. It is an error, however, to leave a floppy
disk-drive motor ON forever.

> Re-configure the BIOS not to try to boot from the floppy, or to seek
> the drive to see whether it is capable of 40 or 80 tracks.
>

The BIOS can be (correctly) set to any of many possible boot-
options.

> If that is not possible, (on a laptop with an obscure BIOS for
> example), add a delay to the bootloader.  Assumng interupts are still
> enabled, the BIOS will switch the floppy off after a few seconds.
>

An arbitrary delay is a very bad hack. If you need something OFF,
you turn it OFF. One should never work-around a primative like
ON or OFF. The digital-output registers at the FDC's specified
address is where this is done.

> John.
>

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


