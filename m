Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262663AbRE0A7y>; Sat, 26 May 2001 20:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262665AbRE0A7f>; Sat, 26 May 2001 20:59:35 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:8205 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S262664AbRE0A7c>; Sat, 26 May 2001 20:59:32 -0400
From: Andrzej Krzysztofowicz <kufel!ankry@green.mif.pg.gda.pl>
Message-Id: <200105262023.WAA02740@kufel.dom>
Subject: Re: vm in 2.4.5
To: kufel!conectiva.com.br!riel@green.mif.pg.gda.pl (Rik van Riel)
Date: Sat, 26 May 2001 22:23:14 +0200 (CEST)
Cc: kufel!able.es!jamagallon@green.mif.pg.gda.pl (J . A . Magallon),
        kufel!vger.kernel.org!linux-kernel@green.mif.pg.gda.pl (Linux Kernel)
In-Reply-To: <Pine.LNX.4.21.0105261049130.30264-100000@imladris.rielhome.conectiva> from "Rik van Riel" at maj 26, 2001 10:54:16 
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, 26 May 2001, J . A . Magallon wrote:
> > It does not begin to use swap in a growing fashion, it just appears
> > full in a moment.
> 
> It gets _allocated_ in a moment, but things don't actually get
> swapped out. This isn't a problem.
> 
> The real problem is that we don't actively reclaim swap space
> when it gets full. We just assign swap to parts of processes,
> but we never reclaim it when we need swap space for something
> else; at least, not until the process exit()s or exec()s.

As I understand the original message, before the compilation and after the
system is in a "similar" state ("the same" processes should be running; even
less of them if some were killed by OOM).

:              total       used       free     shared    buffers     cached
: -/+ buffers/cache:      49908     205780
: Swap:       152576          0     152576

~49 MB in use befere the test,

: -/+ buffers/cache:      14844     240844
: Swap:       152576     152576          0

~149 MB allocated swap. By processes of total size of 49 MB ? Strange...

Either the test shows some leak in running userspace processes (they
allocate a lot of memory) as an effect of memory shortage (strange) or there
is some leak in the kernel. Or the test is bad (something else is running
when it finishes).

Am I right ?

Andrzej

