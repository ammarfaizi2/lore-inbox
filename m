Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWAJOoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWAJOoE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 09:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbWAJOoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 09:44:04 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:43938 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751085AbWAJOoD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 09:44:03 -0500
Date: Tue, 10 Jan 2006 15:44:12 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jens Axboe <axboe@suse.de>
Cc: Byron Stanoszek <gandalf@winds.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2G memory split
Message-ID: <20060110144412.GA9295@elte.hu>
References: <20060110125852.GA3389@suse.de> <20060110132957.GA28666@elte.hu> <20060110133728.GB3389@suse.de> <Pine.LNX.4.63.0601100840400.9511@winds.org> <20060110143931.GM3389@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060110143931.GM3389@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jens Axboe <axboe@suse.de> wrote:

> +	  Select the wanted split between kernel and user memory.
> +
> +	  If the address range available to the kernel is less than the
> +	  physical memory installed, the remaining memory will be available
> +	  as "high memory". Accessing high memory is a little more costly
> +	  than low memory, as it needs to be mapped into the kernel first.

make it _ALOT_ more clear that mere mortals should not touch this 
option! Also, you do not mention the userspace-VM fragmentation issues.  
Plus, if a user uses a 2G/2G split with more than 2G of RAM, the kernel 
should print a warning that it's running with a non-default split. Do 
the same if the user uses a non-default split with less than 960MB of 
RAM.

> +
> +	  Note that selecting anything but the default 3G/1G split will make
> +	  your kernel incompatible with binary only modules.

it's not 'will' but 'may', and even then, tons of .config things can 
break bin-only modules, so just skip this paragraph.

looks good to me otherwise, with the text fixes it's:

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
