Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945936AbWKJB4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945936AbWKJB4j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 20:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945943AbWKJB4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 20:56:39 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:15798 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1945936AbWKJB4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 20:56:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=LRItX/hh/nFCDUaqrosesp7TKeEWNZL+6lrWaaen1WRdf04Y40jig2l0+Nf3KDyVu7VPiCGiYSBbz8OLLolHGLL4yOrX1i6BfnS84Kz+g0T7eTyD3rj3jmJM+X6m4AtEJR3W7U15rZtsUOvXQLp5gqZ2Nb/UqK0t60g6e5myXwI=
Message-ID: <661de9470611091756i3b2a4c7er85e5a581cadfc276@mail.gmail.com>
Date: Fri, 10 Nov 2006 07:26:37 +0530
From: "Balbir Singh" <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: [ckrm-tech] [RFC][PATCH 8/8] RSS controller support reclamation
Cc: dev@openvz.org, ckrm-tech@lists.sourceforge.net, haveblue@us.ibm.com,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Linux MM" <linux-mm@kvack.org>, rohitseth@google.com
In-Reply-To: <1163101543.3138.528.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061109193523.21437.86224.sendpatchset@balbir.in.ibm.com>
	 <20061109193636.21437.11778.sendpatchset@balbir.in.ibm.com>
	 <1163101543.3138.528.camel@laptopd505.fenrus.org>
X-Google-Sender-Auth: 567aca12c1a7320f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/06, Arjan van de Ven <arjan@infradead.org> wrote:
> On Fri, 2006-11-10 at 01:06 +0530, Balbir Singh wrote:
> >
> > Reclaim memory as we hit the max_shares limit. The code for reclamation
> > is inspired from Dave Hansen's challenged memory controller and from the
> > shrink_all_memory() code
>
>
> Hmm.. I seem to remember that all previous RSS rlimit attempts actually
> fell flat on their face because of the reclaim-on-rss-overflow behavior;
> in the shared page / cached page (equally important!) case, it means
> process A (or container A) suddenly penalizes process B (or container B)
> by making B have pagecache misses because A was using a low RSS limit.
>
> Unmapping the page makes sense, sure, and even moving then to inactive
> lists or whatever that is called in the vm today, but reclaim... that's
> expensive...
>

I see your point, one of things we could do is that we could track
shared and cached pages separately and not be so severe on them.

I'll play around with this idea and see what I come up with.

Thanks for the feedback,
Balbir
