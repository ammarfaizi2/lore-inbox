Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751798AbWCEBK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbWCEBK5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 20:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751835AbWCEBK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 20:10:57 -0500
Received: from dsl093-016-182.msp1.dsl.speakeasy.net ([66.93.16.182]:65239
	"EHLO cinder.waste.org") by vger.kernel.org with ESMTP
	id S1751798AbWCEBK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 20:10:56 -0500
Date: Sat, 4 Mar 2006 19:10:44 -0600
From: Matt Mackall <mpm@selenic.com>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: akpm@osdl.org, ram.gupta5@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix potential jiffies overflow
Message-ID: <20060305011044.GH7110@waste.org>
References: <728201270603020843s4feacb1cv3a8acc620e636ffa@mail.gmail.com> <20060303.113246.01208537.nemoto@toshiba-tops.co.jp> <20060302184502.5177c9db.akpm@osdl.org> <20060303.123110.32501622.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060303.123110.32501622.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 12:31:10PM +0900, Atsushi Nemoto wrote:
> >>>>> On Thu, 2 Mar 2006 18:45:02 -0800, Andrew Morton <akpm@osdl.org> said:
>  	sec = get_cmos_time() + clock_cmos_diff;
> -	sleep_length = (get_cmos_time() - sleep_start) * HZ;
> +	sleep_length = (u64)(get_cmos_time() - sleep_start) * HZ;

Calls to get_cmos_time() currently take an average of .5 seconds as it
waits for a clock edge to go by. I've got some patches queueing up to
eliminate this but it's probably worth caching the result here anyway.

-- 
Mathematics is the supreme nostalgia of our time.
