Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbTJPQb3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 12:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263085AbTJPQb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 12:31:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21153 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263057AbTJPQb1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 12:31:27 -0400
Message-ID: <3F8EC7D0.5000003@pobox.com>
Date: Thu, 16 Oct 2003 12:31:12 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: Eli Billauer <eli_billauer@users.sourceforge.net>,
       linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [RFC] frandom - fast random generator module
References: <3F8E552B.3010507@users.sf.net> <3F8E58A9.20005@cyberone.com.au> <3F8E70E0.7070000@users.sf.net> <3F8E8101.70009@pobox.com> <20031016102020.A7000@schatzie.adilger.int>
In-Reply-To: <20031016102020.A7000@schatzie.adilger.int>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> Actually, there are several applications of low-cost RNG inside the kernel.
> 
> For Lustre we need a low-cost RNG for generating opaque 64-bit handles in
> the kernel.  The use of get_random_bytes() showed up near the top of
> our profiles and we had to invent our own low-cost crappy PRNG instead (it's
> good enough for the time being, but when we start working on real security
> it won't be enough).
> 
> The tcp sequence numbers probably do not need to be crypto-secure (I could
> of course be wrong on that ;-) and with GigE or 10GigE I imagine the number
> of packets being sent would put a strain on the current random pool.


We don't need "low cost RNG" and "high cost RNG" in the same kernel. 
That just begs a "reduce RNG cost" solution...  I think security experts 
can easily come up with arguments as to why creating your own "low-cost 
crappy PRNG" isn't needed -- you either need crypto-secure, or you 
don't.  If you don't, then you could just as easily create an ascending 
64-bit number for your opaque filehandle, or use a hash value, or some 
other solution that doesn't require an additional PRNG in the kernel.

For VIA CPUs, life is easy.  Use xstore insn and "You've got bytes!"  :)

	Jeff



