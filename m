Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268688AbRGZU0S>; Thu, 26 Jul 2001 16:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268696AbRGZU0J>; Thu, 26 Jul 2001 16:26:09 -0400
Received: from postfix2-1.free.fr ([213.228.0.9]:6931 "HELO postfix2-1.free.fr")
	by vger.kernel.org with SMTP id <S268688AbRGZUZv> convert rfc822-to-8bit;
	Thu, 26 Jul 2001 16:25:51 -0400
Date: Thu, 26 Jul 2001 22:23:18 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@zip.com.au>,
        lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <E15Pn4D-0003vy-00@the-village.bc.nu>
Message-ID: <20010726221515.B1567-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Thu, 26 Jul 2001, Alan Cox wrote:

> > them, and MTAs are portable, they choose chattr +S on Linux. And that's
> > a performance problem because it doesn't come for free, but also with
> > synchronous data updates, which are unnecessary because there is
> > fsync().
>
> chattr +S and atomic updates hitting disk then returning to the app will
> give the same performance. You can also fsync() the directory.
>
> > the "my rename call has returned 0" event. They expect that with the
> > call returning the rename operation has completed ultimately, finally,
> > for good, definitely and the old file will not reappear after a crash.
>
> Actually the old file re-appearing after the crash is irrelevant. It will
> have a previously logged message id. And if you are not doing message id
> histories then you have replay races at the SMTP level anyway
>
> > This still implies the drive doesn't lie to the OS about the completion
> > of write requests: write cache == off.
>
> Write cache off is not a feature available on many modern disks. You
> already lost the battle before you started.

Losing the battle of brain-dead hardware is not a problem... :-)

SCSI hard disks are expected to follow the specifications. But, may be,
you are referring to IDE disks, only ...

With SCSI, you can enable write caching and also ask the device to signal
completion of actual write to the media by setting the FUA bit in the SCSI
command block (not available in WRITE(6), but available in WRITE(10)).

  Gérard.

