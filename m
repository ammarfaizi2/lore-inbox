Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262429AbVAPE7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262429AbVAPE7B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 23:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbVAPE7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 23:59:01 -0500
Received: from waste.org ([216.27.176.166]:469 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262429AbVAPE66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 23:58:58 -0500
Date: Sat, 15 Jan 2005 20:58:43 -0800
From: Matt Mackall <mpm@selenic.com>
To: Ulrich Drepper <drepper@redhat.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: short read from /dev/urandom
Message-ID: <20050116045843.GH3823@waste.org>
References: <41E7509E.4030802@redhat.com> <20050116024446.GA3867@waste.org> <41E9E65F.1030100@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E9E65F.1030100@redhat.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2005 at 07:58:23PM -0800, Ulrich Drepper wrote:
> Matt Mackall wrote:
> >_Neither_ case mentions signals and the "and will return as many bytes
> >as requested" is clearly just a restatement of "does not have this
> >limit". Whoever copied this comment to the manpage was a bit sloppy
> >and dropped the first clause rather than the second:
> 
> It still means the documented API says there are no short reads.

I maintain that it's ambiguous. And read(2) makes it clear that short
reads can happen any time, any where. Further, your interpretation
makes for a nonsensical API as it implies being uninterruptible for
arbitrary lengths of time. 

Changing the longstanding, sensible code to match a silly and highly
non-standard interpretation of the documentation doesn't fix the
problem in apps either. Presumably they'll still be running on kernels
older than 2.6.11 and I believe most *BSDs have /dev/urandom as well.

> >So anyone doing a read() can expect a short read regardless of the fd
> >and is quite clear that reads can be interrupted by signals. "It is
> >not an error". Ever.
> 
> Of course are signal interruptions wrong if the signal uses SA_RESTART.

That's a separate problem. I'll take a look at fixing that.

-- 
Mathematics is the supreme nostalgia of our time.
