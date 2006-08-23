Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbWHWMGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbWHWMGN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 08:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWHWMGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 08:06:13 -0400
Received: from cantor.suse.de ([195.135.220.2]:5098 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932436AbWHWMGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 08:06:12 -0400
To: Akinobu Mita <mita@miraclelinux.com>
Cc: akpm@osdl.org, okuji@enbug.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 0/5] RFC: fault-injection capabilities
References: <20060823113243.210352005@localhost.localdomain>
From: Andi Kleen <ak@suse.de>
Date: 23 Aug 2006 14:06:06 +0200
In-Reply-To: <20060823113243.210352005@localhost.localdomain>
Message-ID: <p73pser64i9.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akinobu Mita <mita@miraclelinux.com> writes:

> This patch set provides some fault-injection capabilities.
> 
> - kmalloc failures
> 
> - alloc_pages() failures
> 
> - disk IO errors
> 
> We can see what really happens if those failures happen.

Nice.

The SUSE kernel has a crasher module that is also quite useful for testing.
What it does basically is to always allocate/free memory and overwrite
the memory and check if the memory hasn't been changed by someone else.
Perhaps something like that could be incorporated into your framework too?

I put a copy of the suse patch in 
http://www.firstfloor.org/~andi/crasher-26.diff


> 
> In order to enable these fault-injection capabilities:

However I'm not sure they're too useful right now.  The problem is
that they're too global and might render the system unusable. Have you
considered adding some more filters, like uid/gid to fail only (
I think that would be useful because then it would be possible
to run test suites with faults while keeping other parts of the system
functional) or maybe even a list of callers to test? e.g. only
failing for module foo would be nice.

-Andi

