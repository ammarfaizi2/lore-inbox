Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261974AbUK3ERa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbUK3ERa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 23:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbUK3ERa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 23:17:30 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:63420 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261974AbUK3ER2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 23:17:28 -0500
Date: Tue, 30 Nov 2004 05:16:56 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: marcelo.tosatti@cyclades.com, alan@lxorguk.ukuu.org.uk,
       bgagnon@coradiant.com, linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: Memory leak in 2.4.27 kernel, using mmap raw packet sockets
Message-ID: <20041130041656.GO4365@dualathlon.random>
References: <OFDDC77A23.4D34536B-ON85256F2D.00514F15-85256F2D.00517F52@coradiant.com> <20041015182352.GA4937@logos.cnet> <1097980764.13226.21.camel@localhost.localdomain> <20041125150206.GF16633@logos.cnet> <20041125203248.GD5904@dualathlon.random> <20041125171242.GL16633@logos.cnet> <20041125231313.GG5904@dualathlon.random> <20041125194509.GN16633@logos.cnet> <20041126010423.GI5904@dualathlon.random> <20041129200331.3cbcab70.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041129200331.3cbcab70.davem@davemloft.net>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 08:03:31PM -0800, David S. Miller wrote:
> 
> These changes have made 2.4.29-BK stop booting on sparc64.
> I'll get more information to find out exactly why.

hmm strange, I would suggest to put a dump_stack here to see where it
triggers:

                               if (!pages[i] || PageReserved(pages[i])) {
                                       if (pages[i] != ZERO_PAGE(start)) {
+					       dump_stack()
                                               savevma = vma;
                                               goto bad_page;   
                                       }

                               } else

The only thing I see that's probably missing for sparc is a
flush_dcache_page page_cache_get, but that wouldn't prevent booting,
it'd only corrupt userland as worse (and it was missing from the
previous code too ;).
