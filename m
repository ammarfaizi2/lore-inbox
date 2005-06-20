Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbVFTSvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVFTSvT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 14:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVFTSvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 14:51:19 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:708 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S261445AbVFTSvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 14:51:16 -0400
Message-ID: <42B71025.6040006@zabbo.net>
Date: Mon, 20 Jun 2005 11:51:17 -0700
From: Zach Brown <zab@zabbo.net>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, wli@holomorphy.com, mason@suse.com,
       ysaito@hpl.hp.com
Subject: Re: Pending AIO work/patches
References: <20050620120154.GA4810@in.ibm.com> <20050620181007.GA4031@kvack.org>
In-Reply-To: <20050620181007.GA4031@kvack.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>(6) epoll - AIO integration (Zach Brown/Feng Zhou/wli)
>>	Status: Needs resurrection ?
> 
> 
> What are folks thoughts in this area?  Zach's patches took the approach of 
> making multishot iocbs possible, which helped avoid the overhead of plain 
> aio_poll's command setup, which was quite visible in pipetest.  Zach -- did 
> you do any benchmarking on your aio-epoll patches?

No, what little work I did on this was just pushing for stable
functionality.  I had a little test app that was still missing event
delivery occasionally.  I'm sure it'd be easy enough to track down.  It
still seems like a pretty reasonable translation of epoll event delivery
through the aio completion queue.  I'm not thrilled with the epoll edge
delivery semantics, though, it would be nice to make duplicate event
generation contigent on servicing an initial event.  EPOLLIN being
throttled until read activity is seen on the fd, that kind of thing.
Nontrivial work, of course.

>>(7) Vector AIO (aio readv/writev) (Yasushi Saito)
>>	Status: Needs resurrection ?
> 
> Zach also made some noises about this recently...

Yeah, I've got a patch working that adds CMD_AIO_P{WRITE,READ}V for ext3
via some aio->aio_p{read,werive}v ops.  It's currently against some
distro 2.6, but I'll port it up to current and post the patch.  It seems
pretty noncontroversial -- one obviously wants to scatter/gather
file-contiguous IO with tiny iovec elements, which bubble down well to
the generic fs/block helpers, rather than trying to get the various
layers to merge many large iocb submissions that can be found to be
file-contiguous.

- z
