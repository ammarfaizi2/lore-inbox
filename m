Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVABRVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVABRVY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 12:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVABRVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 12:21:24 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:40967
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261291AbVABRVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 12:21:23 -0500
Date: Sun, 2 Jan 2005 18:21:30 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Robert_Hentosh@Dell.com,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH][1/2] adjust dirty threshold for lowmem-only mappings
Message-ID: <20050102172130.GK5164@dualathlon.random>
References: <Pine.LNX.4.61.0412241118590.11520@chimarrao.boston.redhat.com> <20041224164024.GK4459@dualathlon.random> <Pine.LNX.4.61.0412241711180.11520@chimarrao.boston.redhat.com> <20041225020707.GQ13747@dualathlon.random> <Pine.LNX.4.61.0412251253090.18130@chimarrao.boston.redhat.com> <20041225190710.GZ771@holomorphy.com> <20041225200349.GA11116@dualathlon.random> <20041226030721.GA771@holomorphy.com> <20050102161008.GF5164@dualathlon.random> <Pine.LNX.4.61.0501021152280.23180@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501021152280.23180@chimarrao.boston.redhat.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2005 at 11:53:09AM -0500, Rik van Riel wrote:
> 2.6 does not ignore highmem when calculating the dirty memory
> limits, which is causing problems.  That's why I sent in the
> patch in the first place ;)

Ok great, things are clear now, I apparently missed your original patch
in the noise last time I checked this thread and I only focused on
Andrew's proposed fix, and the two patches are both good and 
orthogonal with each other.  I agree your patch is needed and it should
fix the blkdev write on > 1G. Without it the VM is guaranteed to run oom
in your setup, since whatever we writeback, it can be made dirty again
before we can attempt to free it.
