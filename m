Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288149AbSAQHyX>; Thu, 17 Jan 2002 02:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288266AbSAQHyN>; Thu, 17 Jan 2002 02:54:13 -0500
Received: from mx2.elte.hu ([157.181.151.9]:62926 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288149AbSAQHx4>;
	Thu, 17 Jan 2002 02:53:56 -0500
Date: Thu, 17 Jan 2002 10:50:58 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Problems with O(1) scheduler on non-x86 arch's
In-Reply-To: <200201170229.g0H2TnY04563@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0201171046480.2000-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Jan 2002, James Bottomley wrote:

> I've been on a bug hunting expedition to try to make the new scheduler
> work with the voyager architecture port in kernel 2.4.2.  I'm not sure
> if this is a side effect of the port or an intentional architecture
> shift.  Some of the architecture ports (mine included) store the
> physical cpu number in p->processor (now p->cpu) rather than the
> logical one.  I'm not sure if shifting to logical cpu numbering was
> behind the name change or not, but anyway, in case this is merely an
> oversight, the attached patch fixes the problem for me.

it's merely an oversight.

in the long term i think the correct approach would be to always store the
logical CPU number in p->cpu. Architectures that have some strange
physical numbering can always do a mapping themselves. This way we could
remove tons of cpu-id conversions from the generic code. And we are always
going to have these problems, now that the x86 SMP boot code renumbers
physical CPU ids to match the logical order.

i've checked the architectures, and besides your architecture it appears
that only Alpha does a non-identity ID conversion. So it would be much
cleaner for the generic kernel if we stored the logical CPU id in p->cpu,
and all SMP interfaces towards lowlevel SMP code used the logical CPU ID.

	Ingo

