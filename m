Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbUAAWya (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 17:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbUAAWya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 17:54:30 -0500
Received: from dp.samba.org ([66.70.73.150]:12498 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261758AbUAAWy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 17:54:28 -0500
Date: Fri, 2 Jan 2004 09:43:29 +1100
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: joneskoo@derbian.org, linux-kernel@vger.kernel.org
Subject: Re: swapper: page allocation failure. order:3, mode:0x20
Message-ID: <20040101224329.GO28023@krispykreme>
References: <20040101093553.GA24788@derbian.org> <20040101101541.GJ28023@krispykreme> <20040101022553.2be5f043.akpm@osdl.org> <20040101130147.GM28023@krispykreme> <20040101124504.69c80a14.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040101124504.69c80a14.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> This seems a bit odd.  It means that the further apart the message bursts
> are, the longer they are allowed to be.  Or something.
>
> Wouldn't it be better to say "after each greater-than-five second window,
> allow up to ten printk's as long as they happen in the next five
> milliseconds"?

Its 100% copied from the networking code. I would have thought we really
want that behaviour, if Im on a serial console I can only tolerate a
decent sized backtrace every few seconds. If I allow 10 bursts every 5
seconds then im screwed.

Instead we allow the burst of 10 once but then ratelimit it to one
per 5 seconds until we have had a long enough period of silence. The
main thing is that over the long term we have an average of one message
per 5 seconds.

Anton
