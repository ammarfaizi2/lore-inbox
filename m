Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264958AbSJPIK2>; Wed, 16 Oct 2002 04:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264959AbSJPIK1>; Wed, 16 Oct 2002 04:10:27 -0400
Received: from mx2.elte.hu ([157.181.151.9]:24019 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S264958AbSJPIJz>;
	Wed, 16 Oct 2002 04:09:55 -0400
Date: Wed, 16 Oct 2002 10:27:07 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@digeo.com>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] mmap-speedup-2.5.42-C3
In-Reply-To: <20021016040754.C5659@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0210161023530.4906-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Oct 2002, Jakub Jelinek wrote:

> Libraries mapped by dynamic linker are mapped without MAP_FIXED and
> unless you use prelinking, with 0 virtual address, ie. they all end up
> above 1GB. And 99% of libraries uses different protections, for the
> read-only and read-write segment.

right - only the bss (brk-allocated) ones are below 1GB it appears. I did
a quick check on a KDE app and 3 mappings were below 1GB, and 116(!)  
mappings were above 1GB. And even if it wasnt for the different
protections, they use different files to map to so they have to be in
different vmas, no matter what.

i'm wondering about prelinking though - wont that reduce the number of
mappings radically?

in any case, doing a test of KDE's profile with and without the patch
applied sounds like a good idea.

	Ingo

