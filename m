Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268017AbUHPXGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268017AbUHPXGq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 19:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268023AbUHPXDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 19:03:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14481 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266451AbUHPXB6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 19:01:58 -0400
Date: Tue, 17 Aug 2004 00:01:54 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: Possible dcache BUG
Message-ID: <20040816230154.GM12308@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408150009.45034.gene.heskett@verizon.net> <20040815084856.GD12308@parcelfarce.linux.theplanet.co.uk> <200408161852.50310.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408161852.50310.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 06:52:50PM -0400, Gene Heskett wrote:
> Well, I am seing some dups, but they are so volatile that no two runs 
> will report the same allocations as dups, and its never more than 2
> using /proc/fs/ext3 | sort | uniq -c | sort -nr |grep -v ' 1 '
> 
> Consecutive runs will show anywhere from 3 to 10 or 12 dups, but never 
> is an address repeated between runs.
> 
> How is this to be interpreted?

That's OK.  Keep in mind that you have a *lot* of these guys and your
cat(1) makes a lot of read(2) calls.  So what you see is

<starting to read>
<see inode #n that is about to be evicted>
<read some more>
<inode #n gets evicted, quite possibly - due to memory pressure from cat(1)
or sort(1)>
<read more>
<somebody wants the same inode again>
<read more>
<see the inode #n we'd just had read from disk again>

So few duplicates are all right.
