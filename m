Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277966AbRJWQmr>; Tue, 23 Oct 2001 12:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277968AbRJWQmh>; Tue, 23 Oct 2001 12:42:37 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57606 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277966AbRJWQm3>; Tue, 23 Oct 2001 12:42:29 -0400
Subject: Re: x86 smp_call_function recent breakage
To: andrea@suse.de (Andrea Arcangeli)
Date: Tue, 23 Oct 2001 17:49:35 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        robert_macaulay@dell.com (Robert Macaulay)
In-Reply-To: <20011023182954.O26029@athlon.random> from "Andrea Arcangeli" at Oct 23, 2001 06:29:54 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15w4kB-0006Vf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This isn't the right fix:

The cache thing you may be right on. The core fix is not about caching
its about fixing races on IPI replay. We have to handle an IPI reoccuring
potentially with a small time delay due to a retransmit of a message
lost by one party on the bus. Furthermore it seems other messages can
pass the message that then gets retransmitted.

> Robert, this explains the missed IPI during drain_cpu_caches, it isn't
> ram fault or IPI missed by the hardware, so I suggest to just backout
> the second diff above and try again. Will be fixed also in next -aa of
> course.

I'm not sure I follow why it explains a missed IPI. Please explain in
more detail.

Alan
