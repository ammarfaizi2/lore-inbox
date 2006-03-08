Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWCHAdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWCHAdd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 19:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751920AbWCHAdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 19:33:33 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:2533 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751825AbWCHAdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 19:33:32 -0500
Subject: Re: [PATCH] Document Linux's memory barriers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <9551.1141762147@warthog.cambridge.redhat.com>
References: <1141756825.31814.75.camel@localhost.localdomain>
	 <31492.1141753245@warthog.cambridge.redhat.com>
	 <9551.1141762147@warthog.cambridge.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Mar 2006 00:32:03 +0000
Message-Id: <1141777924.2455.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-03-07 at 20:09 +0000, David Howells wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> > Better meaningful example would be barriers versus an IRQ handler. Which
> > leads nicely onto section 2
> 
> Yes, except that I can't think of one that's feasible that doesn't have to do
> with I/O - which isn't a problem if you are using the proper accessor
> functions.

We get them off bus masters for one and you can construct silly versions
of the other.


There are several kernel instances of

	while(*ptr != HAVE_RESPONDED && time_before(jiffies, timeout))
		rmb();

where we wait for hardware to bus master respond when it is fast and
doesn't IRQ.


