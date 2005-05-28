Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262699AbVE1L1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262699AbVE1L1U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 07:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262702AbVE1L1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 07:27:20 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:35590 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S262699AbVE1L1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 07:27:12 -0400
Date: Sat, 28 May 2005 04:32:00 -0700
To: Bill Huey <bhuey@lnxw.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050528113200.GA3629@nietzsche.lynx.com>
References: <4296ADE9.50805@yahoo.com.au> <20050527120812.GA375@nietzsche.lynx.com> <429715DE.6030008@yahoo.com.au> <20050527233645.GA2283@nietzsche.lynx.com> <20050528065500.GA17005@infradead.org> <20050528102259.GA3072@nietzsche.lynx.com> <20050528103417.GA3390@nietzsche.lynx.com> <20050528105003.GA3491@nietzsche.lynx.com> <20050528104818.GA20488@infradead.org> <20050528110119.GA3541@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050528110119.GA3541@nietzsche.lynx.com>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2005 at 04:01:19AM -0700, Bill Huey wrote:
> On Sat, May 28, 2005 at 11:48:18AM +0100, Christoph Hellwig wrote:
> > Unfortunately my employment contract doesn't allow me to tell you the
> > details of GRIO.
> 
> SGI also released the XFS code to the public. I'm sure you can
> intelligently comment on that right and stop being a general ass ?

Obviously there's two kind of determinism going on:

1) submission of the IO request so that it arrives in a timely manner.
2) receiving and waking a thread to handle that data
3) RT decoding of the data so that it's frame locked.
4) repeat the cycles again.

If that loop is delivering drop free frames, then it's got to be
at least deterministic from the app decoding layers. If it's meeting
that, then it's also got to deliver that IO within that window or
at a rate greater than what it can buffer.

There's two kinds of determinism going on here, one CPU bound, the
other IO bound. A kernel with a 300 millisecond spike is obviously
going to violate that constraint on both fronts and make the
application glitch.

bill

