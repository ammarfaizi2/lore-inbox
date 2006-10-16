Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161018AbWJPIHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161018AbWJPIHc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 04:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161204AbWJPIHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 04:07:32 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:47162 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161018AbWJPIHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 04:07:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=crL1fmWw9uAUynOAFrAPZek5DNCZe+n4ByDx6h7PYC1EW8hhGX2L+TxiNNxOFzUxvD18Kjq88Mg5niK3L0g5UYuD7W2sZZCr+B+WbR+XAjjXQZTGx7idobLRLbcGFzrvY7SlPeLORzZqs/ftGmiELoGw11oqhu5HYOgpEeIpgcU=
Message-ID: <b0943d9e0610160107qff115d2r8adef99452560e16@mail.gmail.com>
Date: Mon, 16 Oct 2006 09:07:30 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Mike Galbraith" <efault@gmx.de>
Subject: Re: Major slab mem leak with 2.6.17 / GCC 4.1.1
Cc: "Pekka Enberg" <penberg@cs.helsinki.fi>,
       "nmeyers@vestmark.com" <nmeyers@vestmark.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1160976752.6477.3.camel@Homer.simpson.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061013004918.GA8551@viviport.com>
	 <84144f020610122256p7f615f93lc6d8dcce7be39284@mail.gmail.com>
	 <b0943d9e0610130459w22e6b9a1g57ee67a2c2b97f81@mail.gmail.com>
	 <1160899154.5935.19.camel@Homer.simpson.net>
	 <1160976752.6477.3.camel@Homer.simpson.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/06, Mike Galbraith <efault@gmx.de> wrote:
> On Sun, 2006-10-15 at 07:59 +0000, Mike Galbraith wrote:
>
> > 2.6.19-rc1 + patch-2.6.19-rc1-kmemleak-0.11 compiles fine now (unless
> > CONFIG_DEBUG_KEEP_INIT is set), boots and runs too.. but axle grease
> > runs a lot faster ;-)  I'll try a stripped down config sometime.
>
> My roughly three orders of magnitude (amusing to watch:) boot slowdown
> turned out to be stack unwinding.  With CONFIG_UNWIND_INFO disabled,
> 2.6.19-rc2 + patch-2.6.19-rc1-kmemleak-0.11 runs just fine.

Kmemleak introduces some overhead but shouldn't be that bad.
DEBUG_SLAB also introduces an overhead by erasing the data in the
allocated blocks.

Note that if the allocated blocks are added to a list and never
removed, kmemleak won't be able to detect the leak as the objects are
stilled referred. In this case, you can only use DEBUG_SLAB_LEAK.

-- 
Catalin
