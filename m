Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131712AbQLQUyi>; Sun, 17 Dec 2000 15:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131856AbQLQUy2>; Sun, 17 Dec 2000 15:54:28 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:21262 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131712AbQLQUyR>; Sun, 17 Dec 2000 15:54:17 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: 2.4.0-test13-pre1 lockup: run_task_queue or tty_io are wrong
Date: 17 Dec 2000 12:23:33 -0800
Organization: Transmeta Corporation
Message-ID: <91j7c5$pl1$1@penguin.transmeta.com>
In-Reply-To: <20001217192351.A18244@pcep-jamie.cern.ch> <Pine.LNX.4.10.10012171200310.25447-100000@penguin.transmeta.com> <20001217140530.A14173@vger.timpanogas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20001217140530.A14173@vger.timpanogas.org>,
Jeff V. Merkey <jmerkey@vger.timpanogas.org> wrote:
>
>Try thinking about the work to do model (since task queues are so similiar)
>Having to "kick" these things should be automatic in the kernel.  I could
>do a lot of cool stuff with this in there, manos aside.....

No, the "kicking" should _not_ be automatic.

Th ewhol epoint of a lot of the task queues is that they are manual. The
main use for them (apart from the tty layer, which could easily use
something else) is the disk starter - where we want to delay the
submission of requests to the disk until we've aggregated as many as
possible. Which means that the "tq_disk" queue must absolutely not be
kicked automatically.

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
