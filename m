Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318284AbSHPKN1>; Fri, 16 Aug 2002 06:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318286AbSHPKN1>; Fri, 16 Aug 2002 06:13:27 -0400
Received: from mx1.elte.hu ([157.181.1.137]:27847 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318284AbSHPKN0>;
	Fri, 16 Aug 2002 06:13:26 -0400
Date: Fri, 16 Aug 2002 12:17:57 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] complain about unknown CLONE_* flags
In-Reply-To: <20020815233802.A30018@kushida.apsleyroad.org>
Message-ID: <Pine.LNX.4.44.0208161207450.3782-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Aug 2002, Jamie Lokier wrote:

> Ingo, how do you handle this sort of backward compatibility in your
> latest pthreads library, or don't you do backward compatibility?

[btw., it's not me doing it but Ulrich Drepper. I'm mostly doing the 'lets
find out how the kernel could help' side of things.]

the proper way of doing this is a way of getting fundamental kernel
capabilities, not the 'probing' of the kernel in various ways. Glibc
starts looking like old ISA drivers trying to do nonintrusive
autodetection: 'lets try this port carefully without disturbing state,
perhaps this feature is there'.

one way to handle this cleanly would be to add a kernel capabilities
bitmask to sysconf(), and backport this to all mainstream Linux kernels
where current glibc is supposed to run. Support for something like this
would be added to glibc the day it's in the main kernel. Eg. glibc has to
symlink in the old pthreads library upon bootup, if the feature-set does
not enable the more integrated threading library.

(nevertheless your patch makes good sense, from an API-cleanliness POV.)

	Ingo

