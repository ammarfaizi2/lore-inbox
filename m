Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262515AbVCaG5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbVCaG5r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 01:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262511AbVCaG53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 01:57:29 -0500
Received: from grunt13.ihug.co.nz ([203.109.254.60]:65231 "EHLO
	grunt13.ihug.co.nz") by vger.kernel.org with ESMTP id S262515AbVCaG4c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 01:56:32 -0500
Date: Thu, 31 Mar 2005 18:43:26 +1200 (NZST)
From: Bart Oldeman <bartoldeman@users.sourceforge.net>
X-X-Sender: enbeo@enm-bo-lt.localnet
To: Arjan van de Ven <arjan@infradead.org>
cc: Arnd Bergmann <arnd@arndb.de>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, linux-msdos@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.12-rc1 breaks dosemu
In-Reply-To: <1111829310.6293.43.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.58.0503311833400.3352@enm-bo-lt.localnet>
References: <20050320021141.GA4449@stusta.de>  <200503251952.33558.arnd@arndb.de>
  <1111778074.6312.87.camel@laptopd505.fenrus.org>  <200503252354.53154.arnd@arndb.de>
  <1111825501.6293.25.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.58.0503262023250.3166@enm-bo-lt.localnet>
 <1111829310.6293.43.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Mar 2005, Arjan van de Ven wrote:

>
> > There is one more improbable thing I can think of: comcom. This is
> > dosemu's built-in command.com and uses some very tricky code
> > (coopthreads), which certainly does not work any more with address space
> > randomization. It's deprecated but was still present in 1.2.2, and Debian
> > packages still used it with dosemu 1.2.1. The fix for that one is easy:
> > replace your command.com with a real DOS command.com (e.g. FreeDOS
> > freecom).
>
>
>
> #define STACK_GRAN_SHIFT	17	/* 128K address space granularity */
> #define STACK_GRAN		(1U << STACK_GRAN_SHIFT)
> #define STACK_TOP		0xc0000000U
> #define STACK_BOTTOM		0xa0000000U
> #define STACK_TOP_PADDING	STACK_GRAN
> #define STACK_SLOTS		((STACK_TOP-STACK_BOTTOM) >> STACK_GRAN_SHIFT)
>
> #define roundup_stacksize(size) ((size + STACK_GRAN - 1) & (-((int)STACK_GRAN)))
>
> that certainly isn't boding well for things....
>
>
> ok this thing is evil.

In some private correspondence with Arnd it turned out that this code was
indeed the culprit for him. Fortunately it's easy to avoid -- when you do
as I wrote above it becomes dead code, and dosemu works just fine
(confirmed). In default dosemu 1.2.x setups it's also dead code; it's just
Debian that chose to continue using it.

Fear not. The offending code has since been removed, in development
versions of dosemu, if for no other reason than that except for the
original author (Hans Lermen) nobody understood it.

Hope that clears things up.

Bart
