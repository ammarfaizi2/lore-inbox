Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030296AbWA0LH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbWA0LH4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 06:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbWA0LH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 06:07:56 -0500
Received: from uproxy.gmail.com ([66.249.92.194]:23267 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964986AbWA0LHz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 06:07:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t0Yp87dAaBWU9vLRgmqzIvGX7ZZ6ByvYk+ykF+OiE23xk0p+LcC88KjOpiO1CD/0bijlJ4UrOe0c/X1iM4nP2ZMxHA1RbqdOoA3Wq/FS2vOJgJiBjo58+CqsXMxLrBVhu3gUsymnLHhSTMls1ru6E64PjmV8u4jvYIPCYSp109w=
Message-ID: <84144f020601270307t7266a4ccs5071d4b288a9257f@mail.gmail.com>
Date: Fri, 27 Jan 2006 13:07:54 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Paul Jackson <pj@sgi.com>
Subject: Re: [patch 0/9] Critical Mempools
Cc: colpatch@us.ibm.com, bcrl@kvack.org, clameter@engr.sgi.com,
       linux-kernel@vger.kernel.org, sri@us.ibm.com, andrea@suse.de,
       pavel@suse.cz, linux-mm@kvack.org
In-Reply-To: <20060127021050.f50d358d.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1138217992.2092.0.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0601260954540.15128@schroedinger.engr.sgi.com>
	 <43D954D8.2050305@us.ibm.com>
	 <Pine.LNX.4.62.0601261516160.18716@schroedinger.engr.sgi.com>
	 <43D95BFE.4010705@us.ibm.com> <20060127000304.GG10409@kvack.org>
	 <43D968E4.5020300@us.ibm.com>
	 <84144f020601262335g49c21b62qaa729732e9275c0@mail.gmail.com>
	 <20060127021050.f50d358d.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Pekka wrote:
> > As as side note, we already have __GFP_NOFAIL. How is it different
> > from GFP_CRITICAL and why aren't we improving that?

On 1/27/06, Paul Jackson <pj@sgi.com> wrote:
> Don't these two flags invoke two different mechanisms.
>   __GFP_NOFAIL can sleep for HZ/50 then retry, rather than return failure.
>   __GFP_CRITICAL can steal from the emergency pool rather than fail.
>
> I would favor renaming at least the __GFP_CRITICAL to something
> like __GFP_EMERGPOOL, to highlight the relevant distinction.

Yeah you're right. __GFP_NOFAIL guarantees to never fail but it
doesn't guarantee to actually succeed either. I think the suggested
semantics for __GFP_EMERGPOOL are that while it can fail, it tries to
avoid that by dipping into page reserves. However, I do still think
it's a bad idea to allow the slab allocator to steal whole pages for
critical allocations because in low-memory condition, it should be
fairly easy to exhaust the reserves and waste most of that memory at
the same time.

                            Pekka
