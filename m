Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262163AbUKVQlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbUKVQlA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 11:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbUKVQhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 11:37:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12738 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262159AbUKVQHH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 11:07:07 -0500
Date: Mon, 22 Nov 2004 16:07:05 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Ray Bryant <raybry@sgi.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>, holt@sgi.com,
       Dean Roe <roe@sgi.com>, Brian Sumner <bls@sgi.com>,
       John Hawkes <hawkes@tomahawk.engr.sgi.com>
Subject: Re: scalability of signal delivery for Posix Threads
Message-ID: <20041122160705.GG25636@parcelfarce.linux.theplanet.co.uk>
References: <41A20AF3.9030408@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A20AF3.9030408@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 09:51:15AM -0600, Ray Bryant wrote:
> Since signals are sent much more often than sigaction() is called, it would
> seem to make more sense to make sigaction() take a heavier weight lock of
> some kind (to update the signal handler decription) and to have the signal
> delivery mechanism take a lighter weight lock.  Making 
> current->sighand->siglock a rwlock_t really doesn't improve the situation
> much, since cache line contention is just a severe in that case (if not 
> worse) than it is with the current definition.

What about RCU or seqlock?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
