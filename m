Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268104AbUIPOhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268104AbUIPOhi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 10:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268115AbUIPOhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 10:37:38 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:4749 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S268104AbUIPObu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 10:31:50 -0400
Date: Thu, 16 Sep 2004 16:26:38 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Helge Hafting <helge.hafting@hist.no>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, an.li.wang@intel.com
Subject: Re: truncate shows non zero data beyond the end of the inode with MAP_SHARED
Message-ID: <20040916142638.GW15426@dualathlon.random>
References: <20040915122920.GA4454@dualathlon.random> <20040915210106.GX9106@holomorphy.com> <20040915145524.079a8694.akpm@osdl.org> <20040915220016.GC9106@holomorphy.com> <20040915220819.GF15426@dualathlon.random> <4149539D.9070001@hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4149539D.9070001@hist.no>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 10:49:33AM +0200, Helge Hafting wrote:
> Could this "garbage" possibly be confidential data?

I don't buy much in this theory.

> I.e. one user repeatedly makes and mmaps a 1-byte file,
> extends it to 4k, and looks at the 4095 bytes of "garbage".
> Maybe he finds some "interesting stuff" when someone else's
> confidential file just got dropped from pagecache
> so he could mmap this 1-byte file?

the old data got flushed below the i_size anyways, it sounds very
strange that confidential data is present only over the i_size and not
below the i_size, and if this guy has confidential data below the i_size
then it'd better memset the whole page. And in theory nobody should touch
the data over the i_size even if mmap allows to map it.
