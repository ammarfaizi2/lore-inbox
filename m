Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbVL1NE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbVL1NE4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 08:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbVL1NEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 08:04:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:19929 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964803AbVL1NEz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 08:04:55 -0500
Date: Wed, 28 Dec 2005 08:04:35 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 02/2] allow gcc4 to optimize unit-at-a-time
Message-ID: <20051228130435.GU22293@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20051228114701.GC3003@elte.hu> <20051228120435.GS22293@devserv.devel.redhat.com> <20051228122815.GA9365@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051228122815.GA9365@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2005 at 01:28:15PM +0100, Sam Ravnborg wrote:
> On Wed, Dec 28, 2005 at 07:04:35AM -0500, Jakub Jelinek wrote:
> > > +# Disable unit-at-a-time mode on pre-gcc-4.0 compilers, it makes gcc use
> > > +# a lot more stack due to the lack of sharing of stacklots:
> > > +CFLAGS				+= $(shell if [ $(GCC_VERSION) -lt 0400 ] ; then echo "-fno-unit-at-a-time"; fi ;)
> > 
> > -fno-unit-at-a-time option has been introduced in GCC 3.4 (and 3.3-hammer
> > branch).  So unless the minimum supported GCC version to compile kernel is
> > 3.4+, you need to replace
> > echo "-fno-unit-at-a-time"
> > with
> > $(call cc-option,-fno-unit-at-a-time)
> The test "$(GCC_VERSION) -lt 0400" takes care of this.

No.
-fno-unit-at-a-time should be used with GCCs that
a) support it
b) are older than GCC 4.0

The "$(GCC_VERSION) -lt 0400" test cares of b),
$(call cc-option,-fno-unit-at-a-time) cares of a).

	Jakub
