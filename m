Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947242AbWKKNvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947242AbWKKNvz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 08:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947243AbWKKNvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 08:51:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:43954 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1947242AbWKKNvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 08:51:54 -0500
From: Andi Kleen <ak@suse.de>
To: tglx@linutronix.de
Subject: Re: [patch 13/19] GTOD: Mark TSC unusable for highres timers
Date: Sat, 11 Nov 2006 14:51:33 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@infradead.org>,
       Roman Zippel <zippel@linux-m68k.org>
References: <20061109233030.915859000@cruncher.tec.linutronix.de> <200611101029.59251.ak@suse.de> <1163243677.8335.245.camel@localhost.localdomain>
In-Reply-To: <1163243677.8335.245.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611111451.33511.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > And afaict the reason for that is that we're using jiffies to determine if
> > > the TSC has gone bad, and that test is getting false positives.
> > 
> > The i386 clocksource had always trouble with that. e.g.  I have a box
> > where the TSC works perfectly fine on a 64bit kernel, but since the new i386
> > clocksource code is in it always insists on disabling it shortly after boot.

shortly after boot means in user space here, not during the first idling.

> > My guess is that some of the checks in there are just broken and need
> > to be fixed.
> 
> It's the unconditional mark_unstable call in ACPI C2 state. /me looks.

The system doesn't support C2 states. It's an older single socket Athlon 64 
with VIA chipset. I haven't looked in detail on why it fails.

-Andi
