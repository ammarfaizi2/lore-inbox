Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129031AbRBHKL4>; Thu, 8 Feb 2001 05:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129032AbRBHKLq>; Thu, 8 Feb 2001 05:11:46 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:57554 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129031AbRBHKLd>; Thu, 8 Feb 2001 05:11:33 -0500
From: Christoph Rohland <cr@sap.com>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: tmpfs swapoff oddity
In-Reply-To: <Pine.Linu.4.10.10102080953430.1381-100000@mikeg.weiden.de>
Organisation: SAP LinuxLab
Date: 08 Feb 2001 11:17:16 +0100
In-Reply-To: <Pine.Linu.4.10.10102080953430.1381-100000@mikeg.weiden.de>
Message-ID: <m366ilcwcz.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Thu, 8 Feb 2001, Mike Galbraith wrote:
> Hi Christoph,
> 
> While testing Jens' loop-4 patch (and not being able to find
> any way to lock it up), I stumbled onto a strange behavior.
> 
> I set up an interleaved swap with one swap partition, and one
> swapfile in a loopback mounted reiserfs - populated tmpfs with
> a kernel tree and did hefty make -j kernel builds to generate
> much I/O.  Afterward (bored), I figured I'd bounce the data in
> tmpfs back and forth between swap containers with swapoff.  It
> took much longer than I expected.

Oh, the swapoff handling in Linux is much less then suboptimal. So I
would expect that.

To explain: For every single page on swap we scan all processes vmas
and all shm/tmpfs objects swap tables :-( And we have to hold some
locks for that...

Greetings
		Christoph


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
