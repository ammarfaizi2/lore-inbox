Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266443AbSLVU5r>; Sun, 22 Dec 2002 15:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266456AbSLVU5r>; Sun, 22 Dec 2002 15:57:47 -0500
Received: from [195.208.223.248] ([195.208.223.248]:55168 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S266443AbSLVU5q>; Sun, 22 Dec 2002 15:57:46 -0500
Date: Mon, 23 Dec 2002 00:05:42 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Linus Torvalds <torvalds@transmeta.com>, davidm@hpl.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.5.x disable BAR when sizing
Message-ID: <20021223000542.C30070@localhost.park.msu.ru>
References: <Pine.LNX.4.44.0212211423390.1604-100000@home.transmeta.com> <m1y96il4oj.fsf@frodo.biederman.org> <20021222213945.A30070@localhost.park.msu.ru> <m1of7dltso.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m1of7dltso.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sun, Dec 22, 2002 at 12:47:51PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 22, 2002 at 12:47:51PM -0700, Eric W. Biederman wrote:
> Not if it is an NMI or an SCI interrupt.  The latter on x86 places
> the cpu in System Management Mode, and what the cpu does from that
> point forward is out of our control.
> 
> Though disabling cpu controlled IRQs help if you are dealing
> with any normal IRQs.

I meant the timer interrupt in the first place. I assumed it's the
only one that does matter on this stage of the boot process.
What else could happen (in the real world terms)?

> The window needs to be small from the PCI bus perspective, not in cpu
> clocks.  Write, Read, Write is only something like 9 PCI bus clocks.

No, the window is huge from the PCI bus perspective.
IIRC, PCI config read/write on x86 works like this (I may be wrong though):
i/o port write (BAR address)				~1us
i/o port read  (BAR value after writing ~0)		~1us
i/o port write (BAR address)				~1us
i/o port write (saved BAR value)			~1us

It's a little bit more than 9 PCI clocks. Am I missing something?

Ivan.
