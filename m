Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316681AbSGLRVw>; Fri, 12 Jul 2002 13:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316693AbSGLRVt>; Fri, 12 Jul 2002 13:21:49 -0400
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:25290 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S316681AbSGLRVs>; Fri, 12 Jul 2002 13:21:48 -0400
Message-Id: <200207121724.g6CHOU8100100@d12relay01.de.ibm.com>
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Subject: Re: spinlock assertion macros
To: Daniel Phillips <phillips@arcor.de>, linux-kernel@vger.kernel.org
Mail-Copies-To: arndb@de.ibm.com
Date: Fri, 12 Jul 2002 21:24:40 +0200
References: <200207102128.g6ALS2416185@eng4.beaverton.ibm.com> <E17SjRh-0002VI-00@starship> <20020712140751.A14671@suse.de> <E17Szx2-0002es-00@starship>
Organization: IBM Deutschland Entwicklung GmbH
User-Agent: KNode/0.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:

> Any idea how one might implement NEVER_SLEEPS()?  Maybe as:

Why would you want that? AFAICS there are two kinds of "never
sleeping" functions: 1. those that don't sleep but don't care
about it and 2. those that must not sleep because a lock is
held.

For 1. no point marking it because it might change without
being a bug. You also don't want to mark every function
in the kernel SLEEPS() or NEVER_SLEEPS().

For 2. we already have MUST_HOLD(foo) or similar, which implicitly 
means it can never sleep. The same is true for functions
with spinlocks or preempt_disable around their body.

        Arnd <><
