Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262826AbSI3SFE>; Mon, 30 Sep 2002 14:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262827AbSI3SFE>; Mon, 30 Sep 2002 14:05:04 -0400
Received: from mx1.elte.hu ([157.181.1.137]:36741 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S262826AbSI3SFD>;
	Mon, 30 Sep 2002 14:05:03 -0400
Date: Mon, 30 Sep 2002 20:20:08 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] generic work queue handling, workqueue-2.5.39-D6
In-Reply-To: <20020930231537.A29582@in.ibm.com>
Message-ID: <Pine.LNX.4.44.0209302018550.25912-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Sep 2002, Dipankar Sarma wrote:

> Ingo,
> 
> Is it possible that queue_task() handlers in earlier driver code may
> have depended on implicit serialization against corresponding timer
> handlers since each of those is run from BHs ? If so, isn't that an
> issue now with no BHs ? Or, is it safe to assume that general smp-safety
> code in the drivers will take care of serialization between timers and
> work-queues ?

yes, this is true - such drivers need to use spinlocks. But since 
basically every driver abstraction within the kernel already necessiates 
per-driver spinlocks, this should be straightforward in most cases.

	Ingo

