Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130692AbRCEVsc>; Mon, 5 Mar 2001 16:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130698AbRCEVsV>; Mon, 5 Mar 2001 16:48:21 -0500
Received: from smtp-rt-7.wanadoo.fr ([193.252.19.161]:39156 "EHLO
	embelia.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S130692AbRCEVsD>; Mon, 5 Mar 2001 16:48:03 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Question about IRQ_PENDING/IRQ_REPLAY
Date: Mon, 5 Mar 2001 22:39:49 +0100
Message-Id: <19350128151133.7893@smtp.wanadoo.fr>
In-Reply-To: <980l3v$7ct$1@penguin.transmeta.com>
In-Reply-To: <980l3v$7ct$1@penguin.transmeta.com>
X-Mailer: CTM PowerMail 3.0.6 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>And I seriously doubt that PPC SMP irq handling has gotten _nearly_ the
>amount of testing and hard work that the x86 counterpart has. Things
>like support for CPU affinity, per-irq spinlocks, etc etc.

Some of those are the reason I moved part of the x86 irq.c code to PPC
indeed.

>Now, I'm not saying that irq.c would necessarily work as-is. It probably
>doesn't support all the things that other architectures might need (but
>with three completely different irq controllers on just standard PCs
>alone, I bet it supports most of it), and I know ia64 wants to extend it
>to be more spread out over different CPU's, but most of the high-level
>stuff probably _can_ and should be fairly common.

And I think they are. One thing is that if made "common", do_IRQ have to
be split into an arch-specific function that retrives the irq_number (and
does the ack on some controller), and the actual "dispatch" function that
does all the flags game and calls the handler.

I've slightly extended it using the IRQ_PERCPU flag to prevent IRQ_INPROGRESS
from ever beeing set (a bit hackish but I wanted that for IPIs since they
use ordinary irq_desc structures for us in most cases).

Ben.

