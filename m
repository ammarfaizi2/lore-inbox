Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271034AbTGPSNx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 14:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271031AbTGPSL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 14:11:56 -0400
Received: from chaos.analogic.com ([204.178.40.224]:22406 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S271034AbTGPSKT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 14:10:19 -0400
Date: Wed, 16 Jul 2003 14:27:52 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Andrey Borzenkov <arvidjaar@mail.ru>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test1 - CRC errors on floppy block the whole system
In-Reply-To: <200307162159.16021.arvidjaar@mail.ru>
Message-ID: <Pine.LNX.4.53.0307161415210.29886@chaos>
References: <200307162159.16021.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jul 2003, Andrey Borzenkov wrote:

> Under KDE I went into floppy and made rm *. After this keyboard was lost -
> even CAPS LED did not respond to keypress. I stil could use mouse to start
> new windows and even execute some commands by copy'n'paste from available
> text :)
>
> Attempt to exit KDE ended in black screen. I had to press reset; after that
> the following text was found in syslog (slightly abridged, it had much more
> those "floppy driver state"s).
>
> Floppies are not that robust, everyone knows it. It is rather unfriendly to
> handle media errors in such manner :)
[SNIPPED...]

Yes. You should see how it handles a SCSI disk error!

A media error when running `badblocks` on Linux Version 2.6.0 results
in the same misbehavior with a BusLogic controller.

I tried to boot, it came up but encountered some kind of disk
error. I tried to run `badblocks` on an unmounted partition
that reported zillions of errors during the normal e2fsck check
upon startup.

I booted several times with `init=/bin/bash`. Most times it would
panic with 'trying to kill init' errors. One time I was able to
get it up and I attempted to run badblocks. --Impossible... It
thinks everything is bad and badblocks doesn't help by re-reading
bad blocks. The SCSI system takes 1 minute to reset after a bad
block. I gave up around noon after trying since 8:00 in the AM.
Because of the re-read by badblocks, it's possible that there
may be only one bad block that it never gets past!

With 2.4.20, badblocks reports no errors and e2fsck was able to
rebuild all partitions trashed by version 2.6.0.

If anybody has a Buslogic driver fix, I'll be happy to try it.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.3% of all statistics are fiction.

