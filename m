Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751486AbWEOStk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbWEOStk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 14:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751623AbWEOStk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 14:49:40 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:26804 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751486AbWEOStj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 14:49:39 -0400
Date: Mon, 15 May 2006 20:49:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, apw@shadowen.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 NUMA panic compile error
Message-ID: <20060515184935.GB19576@elte.hu>
References: <20060515005637.00b54560.akpm@osdl.org> <200605152013.53728.ak@suse.de> <20060515113439.457f5809.akpm@osdl.org> <200605152037.54242.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605152037.54242.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen <ak@suse.de> wrote:

> > So shouldn't such a patch remove that code rather than panicing?
> 
> I would be for remove, but apparently we have one or two users in IBM 
> that run their x440s (32bit only) with CONFIG_NUMA. No distributions 
> do so though and I would expect x440s to usually run distributions 
> because they are quite expensive machines.
> 
> My arguments for remove:
> - The code is very hackish - it was written before the proper ACPI
> infrastructure is in place - and NUMA on 32bit in general needs a lot
> of hacks because of the limited ZONE_NORMAL.

works fine here now. The whole NUMA code is still quite hackish in 
general, (including most of arch/x86_64/*/*.c), so i'd not judge based 
on that.

> - NUMA on 32bit is kind of broken by design.

well. 32bit itself is broken by design, if you consider RAM larger than 
say 1GB.

> - It isn't used much.

it's an enabler of a feature-set that i couldnt test on these boxes 
otherwise. Look at it like the highmem= boot option. Or consider it a 
primitive form of NUMA emulation.

> - It breaks often

Martin says he's daily testing it in his grid.

> - It tends to not work on Opterons and hits the users who try it 
> there.

maybe due to the zone alignment problem?

	Ingo
