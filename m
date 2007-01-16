Return-Path: <linux-kernel-owner+w=401wt.eu-S1751018AbXAPCez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbXAPCez (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 21:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbXAPCez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 21:34:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:12478 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbXAPCey (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 21:34:54 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K0YXKEvm0n6L6FD1kBb4sYm2IG+IiAg020TkOLbQLvuT1jzJKRNmPB3Yp/o47sqBdjYdLK7FtuLPJDktjHzv9U5qRlnGsBOuj9zmvh1MD687q1xqudY8Ijxn5edBw2CSyB0EGbIuUlKHap/HpPF0n7JpqHzfNhRhm0rA8dherZA=
Message-ID: <afe668f90701151834u13c75a88sa4592a4a9482d510@mail.gmail.com>
Date: Tue, 16 Jan 2007 10:34:52 +0800
From: "Roy Huang" <royhuang9@gmail.com>
To: balbir@in.ibm.com
Subject: Re: [PATCH] Provide an interface to limit total page cache.
Cc: linux-kernel@vger.kernel.org, aubreylee@gmail.com, nickpiggin@yahoo.com.au,
       torvalds@osdl.org
In-Reply-To: <661de9470701150301i7f315280p5ffa2b388e883f50@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <afe668f90701150139q26e41720lf06d6ee445a917b0@mail.gmail.com>
	 <661de9470701150301i7f315280p5ffa2b388e883f50@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balbir,

Thanks for your comment.

On 1/15/07, Balbir Singh <balbir@in.ibm.com> wrote:

> wakeup_kswapd and shrink_all_memory use swappiness to determine what to reclaim
> (mapped pages or page cache).  This patch does not ensure that only
> page cache is
> reclaimed/limited. If the swappiness value is high, mapped pages will be hit.
>
You are right, it is possible to release mapped pages. It can be
avoided by add a field in "struct scan_control" to determine whether
mapped pages will be released.

> One could get similar functionality by implementing resource management.
>
> Resource  management splits tasks into groups and does management of
> resources for the
> groups rather than the whole system. Such a facility will come with a
> resource controller for
> memory (split into finer grain rss/page cache/mlock'ed memory, etc),
> one for cpu, etc.
I s there any more information in detail about resource controller?
Even there is a resource controller for tasks, all memory is also
possbile to be eaten up by page cache.
>
> Balbir
>
