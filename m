Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285134AbSAMPTQ>; Sun, 13 Jan 2002 10:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285709AbSAMPTF>; Sun, 13 Jan 2002 10:19:05 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:33286 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S285134AbSAMPSv>; Sun, 13 Jan 2002 10:18:51 -0500
Message-ID: <3C41A545.A903F24C@linux-m68k.org>
Date: Sun, 13 Jan 2002 16:18:29 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Robert Love <rml@tech9.net>, Kenneth Johansson <ken@canit.se>,
        arjan@fenrus.demon.nl, Rob Landley <landley@trommello.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Alan Cox wrote:

> All I have seen so far is benchmarks that say low latency is better as is,

If Andrew did a good job (what he obviously did), I don't doubt that.

> and evidence that preempt patches cause far more problems than they solve
> and have complex and subtle side effects nobody yet understands.

I'm aware of two side effects:
- preempt exposes already existing problems, which are worth fixing
independent of preempt.
- it can cause unexpected delays, which should be nonfatal, otherwise
worth fixing as well.

What somehow got lost in this discussion, that both patches don't
necessarily conflict with each other, they both attack the same problem
with different approaches, which complement each other. I prefer to get
the best of both patches.
The ll patch identifies problem, which preempt alone can't fix, on the
other hand the ll patch inserts schedule calls all over the place, where
preempt can handle this transparently. So far I haven't seen any
evidence, that preempt introduces any _new_ serious problems, so I'd
rather like to see to get the best out of both.

> Furthermore its obvious that the only way to fix these side effects is to
> implement full priority handling to avoid priority inversion issues (which
> is precisely what the IRQ problem is) , that means implementing interrupt
> handlers as threads, heavyweight locks and an end result I'm really not
> interested in using.

It's not really needed to go that far, it's generally a good idea to
keep interrupt handler as short as possible, we use bh or tasklets for
exactly that reason. I don't think we need to work around broken
hardware, but halfway decent hardware should not be a problem to get
decent latency.

bye, Roman
