Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWIFHiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWIFHiZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 03:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbWIFHiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 03:38:24 -0400
Received: from mail.suse.de ([195.135.220.2]:21898 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751628AbWIFHiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 03:38:24 -0400
From: Andi Kleen <ak@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [Feature] x86_64 page tracking for Stratus servers
Date: Wed, 6 Sep 2006 09:36:19 +0200
User-Agent: KMail/1.9.3
Cc: Kimball Murray <kimball.murray@gmail.com>, linux-kernel@vger.kernel.org,
       akpm@digeo.com
References: <20060905173229.14149.60535.sendpatchset@dhcp83-86.boston.redhat.com> <44FE6CD6.4040809@yahoo.com.au>
In-Reply-To: <44FE6CD6.4040809@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609060936.19268.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Silly question, why can't you do all this from stop_machine_run context (or
> your SMI) that doesn't have to worry about other CPUs dirtying memory?

Because that would be too slow for continuous mirroring.

You can't go through 10+GB of virtual memory (or more with shared 
memory because the scan has to be virtual) in an interrupt.

The only sane way is to do it continuously.

> [*] Though if it gets included, it would not stop me lamenting the
> proliferation of complexities to support *tiny* obscure userbases. Can
> we wait until your hardware is smart enough to snoop the cc? :)


My guess is that if we had a generic memory mirror subsystem other people would
find uses for it too. e.g. a lot of systems support spare DIMMs these days and mirroring
some memory to it seems like a smart idea. That means normally the hardware
does it, but perhaps some stuff can be done better by doing it in software.

Or it is also a bit similar to the algorithms Xen uses for live migration.
If that was implemented on the kernel level something like this might 
be useful too. I think OpenVZ has some kind of migration support, but it's
currently not live.

-andi

