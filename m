Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131075AbQLCTOY>; Sun, 3 Dec 2000 14:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131085AbQLCTOP>; Sun, 3 Dec 2000 14:14:15 -0500
Received: from kanga.kvack.org ([216.129.200.3]:29191 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id <S131075AbQLCTOC>;
	Sun, 3 Dec 2000 14:14:02 -0500
Date: Sun, 3 Dec 2000 13:41:31 -0500 (EST)
From: <kernel@kvack.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: David Mansfield <lkml@dm.ultramaster.com>, linux-kernel@vger.kernel.org
Subject: Re: mmap_sem (and generic) semaphore fairness question
In-Reply-To: <BBA8C940BB2@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.3.96.1001203132940.29427B-100000@kanga.kvack.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2000, Petr Vandrovec wrote:

> Yes, it can happens. It for sure happens in ncpfs - as ncpfs uses
> ping-pong protocol, and I'm lazy to use different thing than semaphore,
> connection to server is guarded by semaphore.

If you use a rw semaphore taken for writing by two writers, it will
alternate between the two because the second writer will bias the lock
(its next state is predetermined when the second writer goes to sleep).
This is also true for the mix of reader -> writer and writer -> reader.

		-ben

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
