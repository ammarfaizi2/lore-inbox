Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275696AbTHOHqJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 03:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275697AbTHOHqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 03:46:09 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:24585 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S275696AbTHOHqG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 03:46:06 -0400
Date: Fri, 15 Aug 2003 09:46:04 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030815094604.B2784@pclin040.win.tue.nl>
References: <16188.27810.50931.158166@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16188.27810.50931.158166@gargle.gargle.HOWL>; from neilb@cse.unsw.edu.au on Fri, Aug 15, 2003 at 03:16:18PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 03:16:18PM +1000, Neil Brown wrote:

>  I have a notebook (Dell Latitude D800) which has some keys (actual
>  fn+something combinations) that generate Down events but no Up events
>  (clever, isn't it).
> 
>  This makes those keys unusable with 2.6.0 as it is because the input
>  layer insists on there being up events.  Once it sees a down, it will
>  ignore any future down events until it sees an up event.  It will
>  also auto-repeat the key until some other key is pressed.  On the
>  whole, not very useful for these keys.
> 
>  After some thought, the simplest way I could think of to fix it was
>  to have a bitmap of keys that don't generate up events themselves.

I think we should go for a much simpler fix: only enable the timer-induced
repeat when the user asks for that (say, by boot parameter).
The keyboard already knows which keys repeat and which don't.

If we forget about the kernel-invented repetition, we solve, I suppose,
the problems of those people who see impossibly fast repeat, and
also your problem.

Your solution, which involves an ioctl, would force changes to user space.
Too inconvenient.

Andries


[By the way, I am a collector of data on strange keyboards - could you
on a 2.4 system use showkey -s and tell me about the combinations
without Up events? - aeb@cwi.nl]

