Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261846AbSJIPsS>; Wed, 9 Oct 2002 11:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261847AbSJIPsS>; Wed, 9 Oct 2002 11:48:18 -0400
Received: from chaos.analogic.com ([204.178.40.224]:15749 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261846AbSJIPsR>; Wed, 9 Oct 2002 11:48:17 -0400
Date: Wed, 9 Oct 2002 11:56:00 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Andreas Schwab <schwab@suse.de>
cc: "J.A. Magallon" <jamagallon@able.es>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Writable global section?
In-Reply-To: <jen0pn1wj4.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.3.95.1021009114700.6928B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2002, Andreas Schwab wrote:

> "Richard B. Johnson" <root@chaos.analogic.com> writes:
> 
> |> If a variable is in the ".data" section, it is "seen" by all procedures
> |> that are linked to the shared library, but any attempt to write to this
> |> variable will seg-fault the task that attempts to modify it.
> 
> Your tests must be flawed, because a .data section *is* writable.  The
> only difference between .data and .bss is that the latter has no
> allocation in the image file, but they are mapped to the same, writable
> segment.
> 
> Andreas.

Well, yes I found out.. This anomaly with the assembler.....

.section .data
.global	pars
.type	pars,@object
.size	pars,4
.align  4
pars:	.long	0
.end


I accidentally left out .size, guess what? Even though I had an
offset recognized and a ".long", initialized to 0, there was no
space allocated and therefore the seg-fault. I would have seen
this, but the problem doesn't exist if the ".section" is ".bss",
the first section I was messing with. Go figure?

And the writable, is a COW. It isn't seen by others. It's a shame.
It would be very useful to have a writable global section available 
like VAXen did.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

