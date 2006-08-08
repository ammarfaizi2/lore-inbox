Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWHHCSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWHHCSH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 22:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWHHCSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 22:18:07 -0400
Received: from mail.suse.de ([195.135.220.2]:14756 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751208AbWHHCSG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 22:18:06 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] x86_64: Make NR_IRQS configurable in Kconfig
Date: Tue, 8 Aug 2006 04:17:59 +0200
User-Agent: KMail/1.9.3
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>,
       linux-kernel@vger.kernel.org
References: <m1irl4ftya.fsf@ebiederm.dsl.xmission.com> <m1slk89ozd.fsf@ebiederm.dsl.xmission.com> <20060807165512.dabefb63.akpm@osdl.org>
In-Reply-To: <20060807165512.dabefb63.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608080417.59462.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> And it's a pretty nasty one because it can get people into the situation
> where the kernel worked fine for those who released it, but users who
> happen to load more modules (or the right combination of them) will
> experience per-cpu memory exhaustion.

Yes, and a high value will waste a lot of memory for normal users.
 
> So shouldn't we being scaling the per-cpu memory as well?

If we move it into vmalloc space it would be easy to extend at runtime - just the
virtual address space would need to be prereserved, but then more pages
could be mapped. Maybe we should just do that instead of continuing to kludge around?

Drawback would be some more TLB misses.

-Andi
