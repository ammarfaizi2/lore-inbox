Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbWABDk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWABDk3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 22:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWABDk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 22:40:29 -0500
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:1486 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932312AbWABDk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 22:40:28 -0500
Date: Sun, 1 Jan 2006 22:43:50 -0500
From: Kurt Wall <kwall@kurtwerks.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Arjan's noinline Patch
Message-ID: <20060102034350.GD5213@kurtwerks.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060101155710.GA5213@kurtwerks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060101155710.GA5213@kurtwerks.com>
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.15-rc6krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 01, 2006 at 10:57:10AM -0500, Kurt Wall took 0 lines to write:
> After applying Arjan's noline patch (http://www.fenrus.org/noinlin), I
> see almost a 10% reduction in the size of .text (against 2.6.15-rc6)
> with no apparent errors and no reduction in functionality:
> 
> $ size vmlinux.*
>    text    data     bss     dec     hex filename
> 2578246  462000  479920 3520166  35b6a6 vmlinux.inline
> 2327319  462000  479920 3269239  31e277 vmlinux.noinline

The above was built with gcc 3.4.4. With gcc 4.0.2 on the same config:

$ size vmlinux.402.*
   text    data     bss     dec     hex filename
2626474  461856  479984 3568314  3672ba vmlinux.402.inline
2313578  461800  479984 3255362  31ac42 vmlinux.402.noinline

An 11.9% size reduction in .text. What I also notice is the 4.0.2
appears to inline more aggressively than 3.4.4 because the same
config is almost 50K larger in the inline case when compiled with gcc
3.4.4. the "noinline" cases were built with Arjan's patch and
CONFIG_CC_OPTIMIZE_FOR_SIZE; the "inline" kernels were built,
obviously, without the patch and without CONFIG_CC_OPTIMIZE_FOR_SIZE.

Kurt
-- 
Fifth Law of Procrastination:
	Procrastination avoids boredom; one never has the feeling that
there is nothing important to do.
