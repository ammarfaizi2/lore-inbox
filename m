Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbUKHKZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbUKHKZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 05:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbUKHKZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 05:25:58 -0500
Received: from p5485472F.dip.t-dialin.net ([84.133.71.47]:62852 "EHLO
	oscar.local.net") by vger.kernel.org with ESMTP id S261419AbUKHKZx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 05:25:53 -0500
Date: Mon, 8 Nov 2004 11:25:53 +0100
From: Patrick Mau <mau@oscar.ping.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Patrick Mau <mau@oscar.ping.de>
Subject: Re: Workaround for wrapping loadaverage
Message-ID: <20041108102553.GA31980@oscar.prima.de>
Reply-To: Patrick Mau <mau@oscar.ping.de>
References: <20041108001932.GA16641@oscar.prima.de> <20041108012707.1e141772.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041108012707.1e141772.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 01:27:07AM -0800, Andrew Morton wrote:
> Patrick Mau <mau@oscar.ping.de> wrote:
> >
> >  We can only account for 1024 runnable processes, since we have 22 bits
> >  precision, I would like to suggest a patch to calc_load in kernel/timer.c
> 
> It's better than wrapping to zero...
> 
> Why do we need 11 bits after the binary point?

I tried various other combinations, the most interesting alternative was
8 bits precision. The exponential values would be:

1 / e (5/60) * 256
235.53

1 / e (5/300) * 256
251.76

1 / e (5/900) * 256
254.58

If you would use 236, 252 and 255 the last to load calculations would
get optimized into register shifts during calculation. The precision
would be bad, but I personally don't mind loosing the fraction.

Best regards,
Patrick
