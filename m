Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbUKIOrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbUKIOrF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 09:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbUKIOrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 09:47:05 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:53636
	"EHLO x30.random") by vger.kernel.org with ESMTP id S261522AbUKIOrD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 09:47:03 -0500
Date: Tue, 9 Nov 2004 15:46:59 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: [PATCH] zap_pte_range should not mark non-uptodate pages dirty
Message-ID: <20041109144659.GC17639@x30.random>
References: <20041021223613.GA8756@dualathlon.random> <20041021160233.68a84971.akpm@osdl.org> <20041021232059.GE8756@dualathlon.random> <20041021164245.4abec5d2.akpm@osdl.org> <20041022003004.GA14325@dualathlon.random> <20041022012211.GD14325@dualathlon.random> <20041021190320.02dccda7.akpm@osdl.org> <20041022161744.GF14325@dualathlon.random> <20041022162433.509341e4.akpm@osdl.org> <1100009730.7478.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100009730.7478.1.camel@localhost>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 08:15:30AM -0600, Dave Kleikamp wrote:
> Andrew & Andrea,
> What is the status of this patch?  It would be nice to have it in the
> -mm4 kernel.

I think we should add an msync in front of O_DIRECT reads too (msync
won't hurt other users, and it'll provide full coherency), everything
else is ok (the msync can be added as an incremental patch). We applied
it to SUSE (without the msync) to fix your crash in pdflush.
