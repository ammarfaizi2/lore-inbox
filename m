Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288018AbSABXj1>; Wed, 2 Jan 2002 18:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288016AbSABXhu>; Wed, 2 Jan 2002 18:37:50 -0500
Received: from mail.actcom.co.il ([192.114.47.13]:38794 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S287169AbSABXg2>; Wed, 2 Jan 2002 18:36:28 -0500
Message-Id: <200201022335.g02NZaj10253@lmail.actcom.co.il>
Content-Type: text/plain; charset=US-ASCII
From: Itai Nahshon <nahshon@actcom.co.il>
Reply-To: nahshon@actcom.co.il
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: Re: SCSI host numbers?
Date: Thu, 3 Jan 2002 01:35:32 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16LjdE-0003m4-00@the-village.bc.nu>
In-Reply-To: <E16LjdE-0003m4-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 January 2002 01:32 pm, Alan Cox wrote:
> > Under some scenarios Linux assigns the same
> > host_no to more than one scsi device.
> >
> > Can someone tell me what is the intended behavior?
>
> A number should never be reissued.
>
> > The problem is that a newly registered device gets
> > its host_no from max_scsi_host. max_scsi_host is
> > decremented when a device driver is unregistered
> > (see drivers/scsi/host.c) allowing a second new
> > host to reuse the same host_no.
>
> I guess it needs to either only decrement the count if we are the highest

I'll argue that it should never decrement. The host that was just
unregisrtered already has its host_id reserved and if we decrement,
this number will be reasigned to the next new scsi host.

Unless if the code for reservation that causes the conflicts
is removed (but I guess it has a reason).

> one (trivial hack) or scan for a free number/keep a free bitmap. The devfs
> code has a handy little unique_id function for that

That would not solve it. The problem is that one piece of code
tries to allocate unique numbers (and get them back to the pool
when they are not in use), another piece of code remembers the
old number that a scsi host had and whan it re-registers gives
it back its old host_no regardless if this number was re-assigned
to a new host.

Is there a function that given a string returns a unique number
for this string? That would do the job.

-- Itai


