Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265642AbSKASLY>; Fri, 1 Nov 2002 13:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265648AbSKASLY>; Fri, 1 Nov 2002 13:11:24 -0500
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:11017
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S265642AbSKASLX>; Fri, 1 Nov 2002 13:11:23 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33C8D@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Richard B. Johnson'" <root@chaos.analogic.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [STATUS 2.5]  October 30, 2002
Date: Fri, 1 Nov 2002 10:17:45 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, November 01, 2002 at 9:00 AM, Richard B. Johnson wrote:
> [...]
> The correctable ECC is supposed to be just that (correctable). It's
> supposed to be entirely transparent to the CPU/Software. An additional
> read of the affected error produces the same correction so the CPU
> will never even know. The x86 CPU/Software is only notified on an
> uncorrectable error. I don't know of any SDRAM controller that
> generates an interrupt upon a correctable error. Some store "logging"
> information internally, very difficult to get at on a running system.
> 
> Given that, "scrubbing" RAM seems to be somewhat useless on a
> running system. The next write to the affected area will fix the
> ECC bits, that's what is supposed to clear up the condition.
> 

Scrubbing has nothing whatever to do with reporting of correctable errors to
the CPU, even if it does the scrubbing.

Scrubbing does not happen on the basis of chance detection of correctable
errors from normal activity, because that would sometimes be too late.
Remember, the hardware only finds out about an error when the word is
accessed. There is no detection of the bit cell getting its charge altered,
and the errors are cumulative between corrections. 

Scrubbing is intended to lower the probability that any given memory word
will be hit by a second error causing event (such as an alpha particle
emitted from a ceramic case) without having been accessed and corrected. The
scrub just continuously rolls through all of physical memory (at low
priority) again and again doing whatever level of access is necessary to
cause correction. This limits the maximum time between correction of any
memory word. Some memory systems automatically correct and rewrite
(atomically) on a read of a word with a single bit error. Some mainframe
memory systems do the whole ECC scrub/correction operation in hardware,
simultaneously in each bank. 

The primary benefit of logging is to catch deteriorating memory cells during
periodic maintenance that either do not correct at all (single stuck bit,
single hits become uncorrectable) or that repeatedly fail over time, perhaps
due to charge leaks from long term diffusion of contaminants. 

Cheers,
Ed
