Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbULHCve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbULHCve (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 21:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbULHCve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 21:51:34 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:3812 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S262006AbULHCvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 21:51:32 -0500
Date: Wed, 8 Dec 2004 03:51:27 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Time sliced CFQ io scheduler
Message-ID: <20041208025127.GL16322@dualathlon.random>
References: <20041202134801.GE10458@suse.de> <20041202114836.6b2e8d3f.akpm@osdl.org> <20041202195232.GA26695@suse.de> <20041208003736.GD16322@dualathlon.random> <1102467253.8095.10.camel@npiggin-nld.site> <20041208013732.GF16322@dualathlon.random> <20041207180033.6699425b.akpm@osdl.org> <20041208022020.GH16322@dualathlon.random> <20041207182557.23eed970.akpm@osdl.org> <1102473213.8095.34.camel@npiggin-nld.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102473213.8095.34.camel@npiggin-nld.site>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2004 at 01:33:33PM +1100, Nick Piggin wrote:
> I think we could detect when a disk asks for more than, say, 4
> concurrent requests, and in that case turn off read anticipation
> and all the anti-starvation for TCQ by default (with the option
> to force it back on).

What do you mean with "disk asks for more than 4 concurrent requests?"
You mean checking the TCQ capability of the hardware storage?

> I think this would be a decent "it works" solution that would make
> AS acceptable as a default.

Perhaps the code would be the same but if you disable it completely on
certain hardware that's not AS anymore...

Then I believe it would be better to switch to cfq for storage capable
of more than 4 concurrent tagged queued requests instead of sticking
with a "disabled AS". What's the point of AS if the features of AS are
disabled?

One relevant feature of cfq is the fairness property of pid against pid
or user against user. You don't get that fairness with the other I/O
schedulers. It was designed for fairness since the first place. Fariness
of writes against writes and reads against reads and write against reads
and read against writes.
