Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288559AbSADJJm>; Fri, 4 Jan 2002 04:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288557AbSADJJg>; Fri, 4 Jan 2002 04:09:36 -0500
Received: from mail.s.netic.de ([212.9.160.11]:13587 "EHLO mail.netic.de")
	by vger.kernel.org with ESMTP id <S288555AbSADJII>;
	Fri, 4 Jan 2002 04:08:08 -0500
To: Tom Rini <trini@kernel.crashing.org>
Cc: Momchil Velikov <velco@fadata.bg>, linux-kernel@vger.kernel.org,
        gcc@gcc.gnu.org, linuxppc-dev@lists.linuxppc.org,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <87g05py8qq.fsf@fadata.bg>
	<20020102190910.GG1803@cpe-24-221-152-185.az.sprintbbd.net>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Fri, 04 Jan 2002 09:42:55 +0100
In-Reply-To: <20020102190910.GG1803@cpe-24-221-152-185.az.sprintbbd.net>
 (Tom Rini's message of "Wed, 2 Jan 2002 12:09:10 -0700")
Message-ID: <87sn9m33sg.fsf@deneb.enyo.de>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/21.1 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini <trini@kernel.crashing.org> writes:

> 1) Change this particular strcpy to a memcpy

That doesn't fix the undefined behavior.

> 2) Add -ffreestanding to the CFLAGS of arch/ppc/kernel/prom.o (If this
> optimization comes back on with this flag later on, it would be a
> compiler bug, yes?)

That doesn't fix the undefined behavior.

> 3) Modify the RELOC() marco in such a way that GCC won't attempt to
> optimize anything which touches it [1]. (Franz, again by Jakub)

That *does* fix the undefined behavior, and it seems that GCC is going
to stay the same in the future, so this is a feasible workaround.

> 4) Introduce a function to do the calculations [2]. (Corey Minyard)

That doesn't fix the undefined behavior.

> 5) 'Properly' set things up so that we don't need the RELOC() macros
> (-mrelocatable or so?), and forget this mess altogether.

This is the clean approach, and thus preferable in the long term.  (3)
seems to be the best short-time solution.
