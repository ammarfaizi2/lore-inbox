Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262142AbVDRRPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbVDRRPV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 13:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbVDRRPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 13:15:21 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:925 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S262142AbVDRRPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 13:15:08 -0400
Message-ID: <4263EB16.1090904@ammasso.com>
Date: Mon, 18 Apr 2005 12:15:02 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: Libor Michalek <libor@topspin.com>
CC: Andrew Morton <akpm@osdl.org>, Roland Dreier <roland@topspin.com>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs
 implementation
References: <200544159.Ahk9l0puXy39U6u6@topspin.com> <20050411142213.GC26127@kalmia.hozed.org> <52mzs51g5g.fsf@topspin.com> <20050411163342.GE26127@kalmia.hozed.org> <5264yt1cbu.fsf@topspin.com> <20050411180107.GF26127@kalmia.hozed.org> <52oeclyyw3.fsf@topspin.com> <20050411171347.7e05859f.akpm@osdl.org> <20050412180447.E6958@topspin.com>
In-Reply-To: <20050412180447.E6958@topspin.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Libor Michalek wrote:

> The problem we were seeing is that the minor fault by the app resulted
> in a new physical page getting mapped for the application. The page that
> had the elevated refcount was still waiting for the data to be written
> to by the driver at the time that the app accessed the page causing the
> minor fault. Obviously since the app had a new mapping the data written
> by the driver was lost.

Thanks Libor, this is much better explanation of the problem than what I posted.

> It looks like code was added to try_to_unmap_one() to address this, so
> hopefully it's no longer an issue...

I doubt it.  I tried this with an earlier 2.6 kernel, and get_user_pages() was still not 
enough to really pin the memory down.  Maybe it works in 2.6.12, but that doesn't help me 
any, because our driver needs to support all 2.4 and 2.6 kernels.  Currently, mlock() 
alone seems to be good enough, but I'm going to add calls to get_user_pages() just to be sure.

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com
