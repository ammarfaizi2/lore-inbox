Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286322AbSAZS1l>; Sat, 26 Jan 2002 13:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286365AbSAZS1V>; Sat, 26 Jan 2002 13:27:21 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:6404 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286322AbSAZS1J>; Sat, 26 Jan 2002 13:27:09 -0500
Subject: Re: [PATCH] syscall latency improvement #1
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sat, 26 Jan 2002 18:39:35 +0000 (GMT)
Cc: dhowells@redhat.com (David Howells), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201251626490.2042-100000@penguin.transmeta.com> from "Linus Torvalds" at Jan 25, 2002 04:39:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16UXjj-0005su-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> NOTE! There are potentially other ways to do all of this, _without_ losing
> atomicity. For example, you can move the "flags" value into the slot saved
> for the CS segment (which, modulo vm86, will always be at a constant
> offset on the stack), and make CS=0 be the work flag. That will cause the
> CPU to trap atomically at the "iret".

Is the test even needed. Suppose we instead patch the return stack if we
set need_resched/sigpending, and do it on the rare occassion we set the
value.
