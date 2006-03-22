Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWCVI7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWCVI7g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 03:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWCVI7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 03:59:36 -0500
Received: from uproxy.gmail.com ([66.249.92.194]:1270 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751126AbWCVI7f convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 03:59:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GnX/MQaC130+7EduMMImS+Ypq8p+ifepFeBW/pWtD5BMgVMVY3wRwvKlbIJBnVMo2S7gPan90+FcWuDkK2n+a1cevZjO1fgUybPhPhOXsSBRO6CBFSw9OdqX/C65NFYOYSrJ39yWWyGvgD8tZn64NKAe0fT3CG1SidbWILU20Rc=
Message-ID: <bc56f2f0603220059x6b2a30b8h@mail.gmail.com>
Date: Wed, 22 Mar 2006 03:59:33 -0500
From: "Stone Wang" <pwstone@gmail.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: PATCH][1/8] 2.6.15 mlock: make_pages_wired/unwired
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <44209A26.3040102@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <bc56f2f0603200536scb87a8ck@mail.gmail.com>
	 <441FEFB4.6050700@yahoo.com.au>
	 <bc56f2f0603210803l28145c7dj@mail.gmail.com>
	 <44209A26.3040102@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/3/21, Nick Piggin <nickpiggin@yahoo.com.au>:
> Stone Wang wrote:
> > We dont account HugeTLB pages for:
> >
> > 1. HugeTLB pages themselves are not reclaimable.
> >
> > 2. If we count HugeTLB pages in "Wired",then we would have no mind
> >    how many of the "Wired" are HugeTLB pages, and how many are
> > normal-size pages.
> >    Thus, hard to get a clear map of physical memory use,for example:
> >      how many pages are reclaimable?
> >    If we must count HugeTLB pages,more fields should be added to
> > "/proc/meminfo",
> >    for exmaple: "Wired HugeTLB:", "Wired Normal:".
> >
>
> Then why do you wire them at all? Your unwire function does not appear
> to be able to unwire them.

We didnt wire them.

Check get_user_pages():

        /* We dont account wired HugeTLB pages */
        if (is_vm_hugetlb_page(vma)) {
            i = follow_hugetlb_page(mm, vma, pages, vmas,
                        &start, &len, i);
            continue;
        }


Shaoping Wang

>
> --
> SUSE Labs, Novell Inc.
> Send instant messages to your online friends http://au.messenger.yahoo.com
>
>
