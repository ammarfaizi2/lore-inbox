Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWC1HCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWC1HCe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 02:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWC1HCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 02:02:34 -0500
Received: from smop.co.uk ([81.5.177.201]:12190 "EHLO hades.smop.co.uk")
	by vger.kernel.org with ESMTP id S1750793AbWC1HCd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 02:02:33 -0500
Date: Tue, 28 Mar 2006 08:02:20 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-mm1 leaks in dvb playback
Message-ID: <20060328070220.GA29429@smop.co.uk>
Reply-To: adrian@smop.co.uk
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060326211514.GA19287@wyvern.smop.co.uk> <20060327172356.7d4923d2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060327172356.7d4923d2.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
From: adrian <adrian@smop.co.uk>
X-smop.co.uk-MailScanner: Found to be clean
X-smop.co.uk-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.705,
	required 5, autolearn=not spam, AWL -0.10, BAYES_00 -2.60,
	NO_RELAYS -0.00)
X-smop.co.uk-MailScanner-From: adrian@smop.co.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2006 at 17:23:56 -0800 (-0800), Andrew Morton wrote:
> 
> Do you mean that the problem has been present in -mm kernels since the
> 2.6.14/15 timeframe, and not in mainline?

Correct.

> Strange.  Are you sure that they really leak?  Doing
> 
> 	echo 3 > /proc/sys/vm/drop_caches
> 
> doesn't make them go away?

dentry_cache drops a little bit, but the vast majority stays.
sock_inode_cache I didn't notice drop.  If I don't reboot every
15/20mins the machine suddenly starts thrashing like mad and then
effectively locks up :-(

Last night I tried reverting the dvb-core ringbuffer part of -mm1 and
that didn't seem to help at all.  

I've just tried 2.6.16 with just the origin.patch from -mm1 and that
has the same leak in it.   So it looks like I should have spotted this
earlier before it was pushed into 2.6.16+  Just double checked and
in 2.5.16 sock_inode_cache isn't even on the slabtop screen.

I suppose that leads to a new question - what's the easiest way to
start to break down origin.patch and do you know of any likely
culprits?  I see Andi Kleen has seen dentry_cache leaking on x86_64
(this machine is x86(_32) uni processor. 

Thanks for your help,

Adrian
