Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261754AbULUNXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbULUNXc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 08:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbULUNXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 08:23:32 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:65250 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261754AbULUNXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 08:23:30 -0500
Date: Tue, 21 Dec 2004 14:22:55 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: James Pearson <james-p@moving-picture.com>
Cc: Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
Subject: Re: Reducing inode cache usage on 2.4?
Message-ID: <20041221132255.GI2143@dualathlon.random>
References: <41C316BC.1020909@moving-picture.com> <20041217151228.GA17650@logos.cnet> <41C37AB6.10906@moving-picture.com> <20041217172104.00da3517.akpm@osdl.org> <20041220192046.GM4630@dualathlon.random> <41C80A04.9070504@moving-picture.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C80A04.9070504@moving-picture.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2004 at 11:33:24AM +0000, James Pearson wrote:
> Setting vm_mapped_ratio to 20 seems to give a 'better' memory usage 
> using my very contrived test - running a find will result in about 900Mb 
> of dcache/icache, but then running a cat to /dev/null will shrink the 
> dcache/icache down to between 100-300Mb - running the find and cat at 
> the same time results in about the same dcache/icache usage.
> 
> I'll give this a go on the production NFS server and I'll see if it 
> improves things.

Ok great. If 20 isn't enough just set it to 40, just be careful that if
you set it too high the system may swap a bit too early.

Overall this is still a workaround, real fix would be a background
scanning of the icache/dcache collisions in the hash buckets but that's
not for 2.4 ;).
