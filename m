Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265052AbTLMMMO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 07:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265053AbTLMMMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 07:12:14 -0500
Received: from holomorphy.com ([199.26.172.102]:49281 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265052AbTLMMMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 07:12:12 -0500
Date: Sat, 13 Dec 2003 04:12:07 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Yaroslav Rastrigin <yarick@relex.ru>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: 2.6.0-test11-wli-2
Message-ID: <20031213121207.GG14258@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Yaroslav Rastrigin <yarick@relex.ru>, linux-kernel@vger.kernel.org,
	lse-tech@lists.sourceforge.net
References: <20031211052929.GN19856@holomorphy.com> <20031213012703.GR19856@holomorphy.com> <200312131145.27509.yarick@relex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312131145.27509.yarick@relex.ru>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 09:29:29PM -0800, William Lee Irwin III wrote:
>>> Successfully tested on a Thinkpad T21 and 32GB NUMA-Q. Any feedback
>>> regarding performance would be very helpful. Desktop users should
>>> notice top(1) is faster, kernel hackers that kernel compiles are faster,
>>> and highmem users should see much less per-process lowmem overhead

On Sat, Dec 13, 2003 at 11:45:26AM +0300, Yaroslav Rastrigin wrote:
> Performance is, indeed, better. My Thinkpad T21 feels slightly on
> steroids with -wli-2 :-). Some problems, though, were encountered:
> 1. fs/dcache.c/d_validate() function was removed in your patch, but
> it is used in at least one place ( fs/smbfs/cache.c/smb_dget_fpos() ).

Didn't I cover this in the announcement?

It appears that making smbfs depend on CONFIG_BROKEN doesn't seem to be
enough to get it removed from .config's by make oldconfig. d_validate()
is bad, trust me on this one. Is cifs a good enough replacement for you?


On Sat, Dec 13, 2003 at 11:45:26AM +0300, Yaroslav Rastrigin wrote:
> 2. With 2.6.0-test11 vanilla, suspend-to-ram/suspend-to-disk was
> working nicely. With -wli-2 suspend fails on 'stopping tasks' phase,
> and aborts with 
> Dec 13 01:08:47 localhost kernel: Stopping tasks: ======================                                                    
> Dec 13 01:08:47 localhost kernel:  stopping tasks failed (1 tasks remaining)                                                
> Dec 13 01:08:47 localhost kernel: Restarting tasks...<6> Strange, swapper not 
> stopped

That's relatively unusual; for one, I can't imagine why it's bothering to
stop pid 0 (or why it thinks it should or can). I'll have to try non-APM
-based suspend for this.


-- wli
