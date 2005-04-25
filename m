Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVDYWWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVDYWWx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 18:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVDYWWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 18:22:53 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:59594 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S261257AbVDYWWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 18:22:46 -0400
Message-ID: <426D6D68.6040504@ammasso.com>
Date: Mon, 25 Apr 2005 17:21:28 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Roland Dreier <roland@topspin.com>, hch@infradead.org, hozer@hozed.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>	<20050411142213.GC26127@kalmia.hozed.org>	<52mzs51g5g.fsf@topspin.com>	<20050411163342.GE26127@kalmia.hozed.org>	<5264yt1cbu.fsf@topspin.com>	<20050411180107.GF26127@kalmia.hozed.org>	<52oeclyyw3.fsf@topspin.com>	<20050411171347.7e05859f.akpm@osdl.org>	<4263DEC5.5080909@ammasso.com>	<20050418164316.GA27697@infradead.org>	<4263E445.8000605@ammasso.com>	<20050423194421.4f0d6612.akpm@osdl.org>	<426BABF4.3050205@ammasso.com>	<52is2bvvz5.fsf@topspin.com>	<20050425135401.65376ce0.akpm@osdl.org>	<521x8yv9vb.fsf@topspin.com> <20050425151459.1f5fb378.akpm@osdl.org>
In-Reply-To: <20050425151459.1f5fb378.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> The way we expect get_user_pages() to be used is that the kernel will use
> get_user_pages() once per application I/O request.
> 
> Are you saying that RDMA clients will semi-permanently own pages which were
> pinned by get_user_pages()?  That those pages will be used for multiple
> separate I/O operations?

Yes, absolutely!

The memory buffer is allocated by the process (usually just via malloc) and 
registed/pinned by the driver.  It then stays pinned for the life of the process (typically).

> If so, then that's a significant design departure and it would be good to
> hear why it is necessary.

That's just how RMDA works.  Once the memory is pinned, if the app wants to send data to 
another node, it does two things:

1) Puts the data into its buffer
2) Sends a "work request" to the driver with (among other things) the offset and length of 
the data.

This is a time-critical operation.  It must occurs as fast as possible, which means the 
memory must have already been pinned.

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com

One thing a Southern boy will never say is,
"I don't think duct tape will fix it."
      -- Ed Smylie, NASA engineer for Apollo 13
