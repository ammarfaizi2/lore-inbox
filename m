Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbVBAFjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVBAFjr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 00:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVBAFjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 00:39:47 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:34124 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261560AbVBAFjp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 00:39:45 -0500
Date: Tue, 1 Feb 2005 06:41:49 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] ppc64: Implement a vDSO and use it for signal trampoline
Message-ID: <20050201054149.GA8136@mars.ravnborg.org>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <1107151447.5712.81.camel@gaston> <20050131192713.GA16268@mars.ravnborg.org> <1107218282.5906.33.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107218282.5906.33.camel@gaston>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2005 at 11:38:02AM +1100, Benjamin Herrenschmidt wrote:
> 
> > Also notice that ':=' uses all over. No need to use late evaluation when
> > no dynamic references are used ($ $@ etc.).
> 
> Hrm... Rusty tells me that you got it backward ;) Anyway, I'll stick
> to := for now, it's not really an issue.

:=
Right hand side is evaluated when encountered.
Often what you want. So for example
CC := cc
here CC is assigned the value cc when seen.

=
Right hand side is evaluated only when left hand side is used.
Also very usefull. Example just mocked up:
cmd_vdso32_cc = $(CC) -T $^ -o $@

Doing late evaluation will cause correct replacement of $^ and $@ when
used. When cmd_vdso_32 is defined make does not know the desired values
for $^ and $@ - this is only known when cmd_vdso_32 is actually used.

Hope this clarifies it.

	Sam
