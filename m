Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbUDHPeS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 11:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbUDHPeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 11:34:18 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:7079
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261980AbUDHPeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 11:34:16 -0400
Date: Thu, 8 Apr 2004 17:34:12 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Hugh Dickins <hugh@veritas.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] rmap: parisc __flush_dcache_page
Message-ID: <20040408153412.GD31667@dualathlon.random>
References: <Pine.LNX.4.44.0404081500520.7116-100000@localhost.localdomain> <1081435237.1885.144.camel@mulgrave> <20040408151415.GB31667@dualathlon.random> <1081438124.2105.207.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1081438124.2105.207.camel@mulgrave>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2004 at 10:28:44AM -0500, James Bottomley wrote:
> Exactly why wouldn't a simple spinlock to protect page->mapping work?  I
> know we don't want to bloat struct page, but such a thing could go in
> struct address_space?

yes, the spinlock in struct address_space would be enough, and that's
what 2.4 does too, Andrew changed it to a semaphore in 2.6 but it can be
made a spinlock again. Then you can fix it (as far as you never call it
from an irq and as far as you don't generate exceptions inside the
critical section, but I'm sure you don't).
