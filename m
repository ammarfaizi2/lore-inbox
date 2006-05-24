Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbWEXVQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbWEXVQz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 17:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWEXVQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 17:16:55 -0400
Received: from mail8.fw-sd.sony.com ([160.33.66.75]:41695 "EHLO
	mail8.fw-sd.sony.com") by vger.kernel.org with ESMTP
	id S932399AbWEXVQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 17:16:54 -0400
Message-ID: <4474CD38.5090206@am.sony.com>
Date: Wed, 24 May 2006 14:16:40 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Martin Peschke <mp3@de.ibm.com>
CC: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 3/6] statistics infrastructure - prerequisite: timestamp
References: <1148055080.2974.15.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
In-Reply-To: <1148055080.2974.15.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Peschke wrote:
> The original piece of code was a bit promiscuous, IMHO.
> Please accept the little cleanup that comes with my patch.

In general, I like the cleanup.  See comments below.

> And I think that I have fixed a printed_len related miscalculation.
> printed_len needs to be increased if no valid log level has been found
> and a log level prefix has been added by printk(). Otherwise, printed_len
> must not be increased. The old code did it the other way around (in the
> timestamp case).

I'm not following your change here.  I can't find the problem you
mention in the original code.  And your fix appears to mess up the
printed_len.

> +		if (new_line) {
> +			/* The log level token is first. */
> +			int loglev_char;
> +			if (p[0] == '<' && p[1] >='0' &&
> +			    p[1] <= '7' && p[2] == '>') {
> +				loglev_char = p[1];
> +				p += 3;
> +				printed_len -= 3;
Here you subtract from the printed_len to account for skipping
the submitted log level.

> +			} else	{
> +				loglev_char = default_message_loglevel + '0';
> +			}
> +			emit_log_char('<');
> +			emit_log_char(loglev_char);
> +			emit_log_char('>');

But here you don't re-count the chars for the log-level
you are adding back in.  There's a discrepancy here.

Please look at this again.  NAK
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================
