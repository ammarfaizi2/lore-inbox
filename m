Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVDYWnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVDYWnp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 18:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVDYWno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 18:43:44 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:60875 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S261208AbVDYWnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 18:43:33 -0400
Message-ID: <426D725C.4070103@ammasso.com>
Date: Mon, 25 Apr 2005 17:42:36 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: roland@topspin.com, hch@infradead.org, hozer@hozed.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>	<20050411142213.GC26127@kalmia.hozed.org>	<52mzs51g5g.fsf@topspin.com>	<20050411163342.GE26127@kalmia.hozed.org>	<5264yt1cbu.fsf@topspin.com>	<20050411180107.GF26127@kalmia.hozed.org>	<52oeclyyw3.fsf@topspin.com>	<20050411171347.7e05859f.akpm@osdl.org>	<4263DEC5.5080909@ammasso.com>	<20050418164316.GA27697@infradead.org>	<4263E445.8000605@ammasso.com>	<20050423194421.4f0d6612.akpm@osdl.org>	<426BABF4.3050205@ammasso.com>	<52is2bvvz5.fsf@topspin.com>	<20050425135401.65376ce0.akpm@osdl.org>	<521x8yv9vb.fsf@topspin.com>	<20050425151459.1f5fb378.akpm@osdl.org>	<426D6DFA.4090908@ammasso.com> <20050425153542.70197e6a.akpm@osdl.org>
In-Reply-To: <20050425153542.70197e6a.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> This is because there is no file descriptor or anything else associated
> with the pages which permits the kernel to clean stuff up on unclean
> application exit.  Also there are the obvious issues with permitting
> pinning of unbounded amounts of memory.

Then that might explain the "bug" that we're seeing with get_user_pages().  We've been 
assuming that get_user_pages() mappings are permanent.

Well, I was just about to re-implement get_user_pages() support in our driver to 
demonstrate the bug.  I guess I'll hold off on that.

If you look at the Infiniband code that was recently submitted, I think you'll see it does 
exactly that: after calling mlock(), the driver calls get_user_pages(), and it stores the 
page mappings for future use.

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com

One thing a Southern boy will never say is,
"I don't think duct tape will fix it."
      -- Ed Smylie, NASA engineer for Apollo 13
