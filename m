Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262449AbTAVTZm>; Wed, 22 Jan 2003 14:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262472AbTAVTZm>; Wed, 22 Jan 2003 14:25:42 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:65494 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S262449AbTAVTZl>;
	Wed, 22 Jan 2003 14:25:41 -0500
Date: Wed, 22 Jan 2003 19:34:46 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org
Subject: Re: {sys_,/dev/}epoll waiting timeout
Message-ID: <20030122193446.GA5438@bjl1.asuk.net>
References: <20030122132040.GA4752@bjl1.asuk.net> <Pine.LNX.4.33L2.0301221112160.3511-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0301221112160.3511-100000@dragon.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> | > Why assume HZ=1000?  Would not:
> | >
> | > timeout = (unsigned long)(timeout*HZ+(HZ-1))/HZ+1;
> | >
> | > make more sense?
> |
> | No, that's silly.  Why do you want to multiply by HZ and then divide by HZ?
> 
> OK, I don't get it.  All Ed did was replace 1000 with HZ and
> 999 with (HZ-1).  What's bad about that?  Seems to me like
> the right thing to do.  Much more portable.
> 
> What if HZ changes?  Who's going to audit the kernel for changes?

You're being dense.  The input timeout is measured in milliseconds;
see poll(2).  The calculated timeout is measured in jiffies.  Hence
multiply by jiffies and divide by milliseconds.

-- Jamie
