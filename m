Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131978AbRACQRi>; Wed, 3 Jan 2001 11:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132101AbRACQR3>; Wed, 3 Jan 2001 11:17:29 -0500
Received: from www.wen-online.de ([212.223.88.39]:2572 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S131978AbRACQRQ>;
	Wed, 3 Jan 2001 11:17:16 -0500
Date: Wed, 3 Jan 2001 16:39:39 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Daniel Phillips <phillips@innominate.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: scheduling problem?
In-Reply-To: <3A533C7D.A9C50DB@innominate.de>
Message-ID: <Pine.Linu.4.10.10101031614540.541-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2001, Daniel Phillips wrote:

> Mike Galbraith wrote:
> > Semaphore timed out during boot, leaving bdflush as zombie.
> 
> Wait a sec, what do you mean by 'semaphore timed out'?  These should
> wait patiently forever.

IKD has a semaphore deadlock detector.  Any place you take a semaphore
and have to wait longer than 5 seconds (what I had it set to because
with trace buffer set to 3000000 entries, it can only cover ~8 seconds
of disk [slowest] load), it triggers and freezes the trace buffer for
later use.  It firing under load may not be of interest. (but it firing
looks to be very closly coupled to observed stalls with virgin source.
Linus fixes big stall and deadlock detector mostly shuts up.  I fix a
smaller stall and it shuts up entirely.. for this workload)

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
