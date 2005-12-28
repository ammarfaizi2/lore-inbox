Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbVL1M67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbVL1M67 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 07:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbVL1M66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 07:58:58 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:4757 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S964805AbVL1M66
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 07:58:58 -0500
Date: Wed, 28 Dec 2005 13:28:15 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 02/2] allow gcc4 to optimize unit-at-a-time
Message-ID: <20051228122815.GA9365@mars.ravnborg.org>
References: <20051228114701.GC3003@elte.hu> <20051228120435.GS22293@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051228120435.GS22293@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2005 at 07:04:35AM -0500, Jakub Jelinek wrote:
> > +# Disable unit-at-a-time mode on pre-gcc-4.0 compilers, it makes gcc use
> > +# a lot more stack due to the lack of sharing of stacklots:
> > +CFLAGS				+= $(shell if [ $(GCC_VERSION) -lt 0400 ] ; then echo "-fno-unit-at-a-time"; fi ;)
> 
> -fno-unit-at-a-time option has been introduced in GCC 3.4 (and 3.3-hammer
> branch).  So unless the minimum supported GCC version to compile kernel is
> 3.4+, you need to replace
> echo "-fno-unit-at-a-time"
> with
> $(call cc-option,-fno-unit-at-a-time)
The test "$(GCC_VERSION) -lt 0400" takes care of this.

	Sam
