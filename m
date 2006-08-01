Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751803AbWHATIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbWHATIg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 15:08:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbWHATIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 15:08:36 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:59709 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751803AbWHATIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 15:08:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Vzzyu8gNTjw18yQXWND0UfFqjYJ07aQIhMN9IC+ayoCf/8rhZ2AtrFthimwO7FklC/T3FMZ5u3nrUroS/KNlugOXOJdQWspbZI50iaio7z5tM0nLwVWzACST8H4/JmoWtoy0WdR8av3bU/vumncpiz+C+Nwi1O/Hyqx9fBH2RaU=
Message-ID: <84144f020608011208x3c40450cm85af5a2d18ac854d@mail.gmail.com>
Date: Tue, 1 Aug 2006 22:08:33 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Christoph Lameter" <clameter@sgi.com>
Subject: Re: Re: [BLOCK] bh: Ensure bh fits within a page
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Herbert Xu" <herbert@gondor.apana.org.au>,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.64.0608011034540.18006@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060801030443.GA2221@gondor.apana.org.au>
	 <20060731210418.084f9f5d.akpm@osdl.org>
	 <20060801050259.GA3126@gondor.apana.org.au>
	 <20060731225454.19981a5f.akpm@osdl.org>
	 <Pine.LNX.4.64.0608011034540.18006@schroedinger.engr.sgi.com>
X-Google-Sender-Auth: da9b0dc8944bc3b3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/1/06, Christoph Lameter <clameter@sgi.com> wrote:
> The slab allocator gives no guarantee that a structure is not straddling a
> page boundary regardless of debug or not. It may just happen that the
> objects are arranged if kmem_cache_cretae() is called with certain
> parameters. Another arch with other cacheline alignment and another page
> size may arrange the objects differently.

Indeed. You could try to force zero-order page allocations for a
cache, but we are probably better of using the page allocator directly
or crafting a special purpose allocator for the block layer.

                                 Pekka
