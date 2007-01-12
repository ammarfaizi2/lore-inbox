Return-Path: <linux-kernel-owner+w=401wt.eu-S1030304AbXALD7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030304AbXALD7q (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 22:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030445AbXALD7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 22:59:46 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:11770 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030304AbXALD7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 22:59:45 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rCTigRKh6kGtXqvCRKHgzfms4nnzw4o8p2Icc10K4pyNLwapJjz3K3Rp9BKEG+rX0twetQaP4Sabb9irsRU+EuJdfl3p/JCjvKU16ACQtCK2DGdv0sjZromPQqU8+AOTrAmVus9QFV4QjntfpDYqMFPX74xW+RE6hvA4qibn9Sg=
Message-ID: <afe668f90701111959i2099b32fh5e8df2ed181635f8@mail.gmail.com>
Date: Fri, 12 Jan 2007 11:59:43 +0800
From: "Roy Huang" <royhuang9@gmail.com>
To: Aubrey <aubreylee@gmail.com>
Subject: Re: O_DIRECT question
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>, "Andrew Morton" <akpm@osdl.org>,
       "Linus Torvalds" <torvalds@osdl.org>, "Hua Zhong" <hzhong@gmail.com>,
       "Hugh Dickins" <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, mjt@tls.msk.ru,
       "Robin Getz" <rgetz@blackfin.uclinux.org>
In-Reply-To: <6d6a94c50701111812q64035fcdheeadfaaf0da9a68c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>
	 <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org>
	 <6d6a94c50701102150w4c3b46d0w6981267e2b873d37@mail.gmail.com>
	 <20070110220603.f3685385.akpm@osdl.org>
	 <6d6a94c50701102245g6afe6aacxfcb2136baee5cbfa@mail.gmail.com>
	 <20070110225720.7a46e702.akpm@osdl.org>
	 <45A5E1B2.2050908@yahoo.com.au>
	 <6d6a94c50701102354l7ab41a3bp4761566204f1d992@mail.gmail.com>
	 <afe668f90701110005ya2e8187pc6604c5aad24cc84@mail.gmail.com>
	 <6d6a94c50701111812q64035fcdheeadfaaf0da9a68c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Limiting total page cache can be considered first. Only if total page
cache overrun limit, check whether the file overrun its per-file
limit. If it is true, release partial page cache and wake up kswapd at
the same time.

On 1/12/07, Aubrey <aubreylee@gmail.com> wrote:
> On 1/11/07, Roy Huang <royhuang9@gmail.com> wrote:
> > On a embedded systerm, limiting page cache can relieve memory
> > fragmentation. There is a patch against 2.6.19, which limit every
> > opened file page cache and total pagecache. When the limit reach, it
> > will release the page cache overrun the limit.
>
> The patch seems to work for me. But some suggestions in my mind:
>
> 1) Can we limit the total page cache, not the page cache per each file?
>     think about if total memory is 128M, 10% of it is 12.8M, here if
> one application is running, it can use 12.8M vfs cache, then the
> performance will probably not be impacted. However, the current patch
> limit the page cache per each file, which means if only one
> application runs it can only use CONFIG_PAGE_LIMIT pages cache. It may
> be small to the application.
> ------------------snip---------------
> if (mapping->nrpages >= mapping->pages_limit)
>                balance_cache(mapping);
> ------------------snip---------------
>
> 2) A percent number should be better to control the value. Can we add
> a proc interface to make the value tunable?
>
> Thanks,
> -Aubrey
>
