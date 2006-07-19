Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbWGSEFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbWGSEFb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 00:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbWGSEFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 00:05:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10477 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932472AbWGSEFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 00:05:31 -0400
Date: Tue, 18 Jul 2006 21:04:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Gary Funck" <gary@intrepid.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: 2.6.17-1.2145_FC5 mmap-related soft lockup
Message-Id: <20060718210458.45f9460e.akpm@osdl.org>
In-Reply-To: <200607190225.k6J2PGAq004975@intrepid.intrepid.com>
References: <20060715221942.9f1543ca.akpm@osdl.org>
	<200607190225.k6J2PGAq004975@intrepid.intrepid.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2006 19:25:16 -0700
"Gary Funck" <gary@intrepid.com> wrote:

> 
> > 
> > Are you able to confirm that setting CONFIG_DEBUG_SPINLOCK=n fixes it?
> > 
> > And are you able to get us a copy of that test app?
> 
> Yes, I just ran the test with 2.6.17.6.  With CONFIG_DEBUG_SPINLOCK=y
> the test fails and the soft lockup situation often results.
> However, when built with CONFIG_DEBUG_SPINLOCK=n, the test passes,
> and runs rather quickly in comparison to when it fails.
> 
> I've attached a slightly updated version of the test case.
> It is a little more carefully crafted and prints some
> output so that you have some idea that it is working.
> 

That's great, thanks.  That pretty much confirms that this long-standing
box-killing rwlock starvation bug is specific to Opterons.  Neither Ingo
nor I have Opteron machines so a fix will take a little longer than one
would expect.

Meanwhile, an appropriate workaround is to disable CONFIG_DEBUG_SPINLOCK.
