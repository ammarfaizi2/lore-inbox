Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWJEUCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWJEUCE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 16:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWJEUCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 16:02:04 -0400
Received: from mx1.suse.de ([195.135.220.2]:26000 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751136AbWJEUCB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 16:02:01 -0400
To: Steve Bergman <sbergman@rueb.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Free memory level in 2.6.16?
References: <1160034527.23009.7.camel@localhost>
From: Andi Kleen <ak@suse.de>
Date: 05 Oct 2006 22:01:53 +0200
In-Reply-To: <1160034527.23009.7.camel@localhost>
Message-ID: <p73k63ezg3y.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Bergman <sbergman@rueb.com> writes:

> Due to some problems I was having with the CentOS4.4 kernel, I just
> moved a box (x86 with 4GB ram) to 2.6.16.29 from kernel.org.
> 
> All is well, but I am curious about one thing.  This is a fairly memory
> hungry box, serving about 40 gnome desktops via xdmcp.  All VM settings
> are at the default.  Swappiness=60, min_free_kbytes=3831.
> 
> However, it seems to seek out about 150MB for the level of free memory
> that it maintains.  Typically I see somewhere between 100MB an 500MB in
> swap, buffers+cache is about 500MB, and 150MB is free.
> 
> If I cat from /dev/md0 to /dev/null, the free memory does go down, to
> 25MB or so,  but then I can watch as it seeks out about 150MB of free
> memory.
> 
> To me, free memory is wasted memory.  Is this a bug or a feature?

Normally it keeps some memory free for interrupt handlers which
cannot free other memory. But 150MB is indeed a lot, especially
it's only in the ~900MB lowmem zone.

You could play with /proc/sys/vm/lowmem_reserve_ratio but must
likely some defaults need tweaking.

-Andi
