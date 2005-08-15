Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbVHOQhw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbVHOQhw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 12:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbVHOQhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 12:37:52 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:14696 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964835AbVHOQhv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 12:37:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LViOnZ9+QAvLL1C3V/YJnFJn/jq45GLYMpyS5DpXjGVimY+76C8jwidW6p/Y21dhEn/KOptpqV8u5x5Mz0801gWyNaigaLzx59YJc9PckT+XULeYcmS3rXU3MUldgjTW/BkE0540GwAYxPAsH/bsQWyCUMuiDClcJ12lUXJbzcU=
Message-ID: <5ebee0d10508150937da6c1ed@mail.gmail.com>
Date: Mon, 15 Aug 2005 12:37:50 -0400
From: Bill Jordan <woodennickel@gmail.com>
To: Gleb Natapov <glebn@voltaire.com>
Subject: Re: [openib-general] Re: [PATCH repost] PROT_DONTCOPY: ifiniband uverbs fork support
Cc: Hugh Dickins <hugh@veritas.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <20050811080205.GR16361@minantech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050719165542.GB16028@mellanox.co.il>
	 <20050725171928.GC12206@mellanox.co.il>
	 <Pine.LNX.4.61.0507261312460.16985@goblin.wat.veritas.com>
	 <20050726133553.GA22276@mellanox.co.il>
	 <Pine.LNX.4.61.0508091759050.14886@goblin.wat.veritas.com>
	 <20050810083943.GM16361@minantech.com>
	 <Pine.LNX.4.61.0508101412530.3153@goblin.wat.veritas.com>
	 <20050810132611.GP16361@minantech.com>
	 <Pine.LNX.4.61.0508101623480.4525@goblin.wat.veritas.com>
	 <20050811080205.GR16361@minantech.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/05, Gleb Natapov <glebn@voltaire.com> wrote:
> What about the idea that was floating around about new VM flag that will
> instruct kernel to copy pages belonging to the vma on fork instead of mark
> them as cow?
> 

I think the big problem with this idea is the huge memory regions that
InfiniBand applications are dealing with. If the application forks (or
uses system()), you are going to copy a huge chunk of data (most
likely swapping since the application memory footprint is probably
already tuned to consume the available physical memory). And the copy
is really for nothing since in most (or at least many) cases the child
is just going to exec anyway.

-- 
Bill Jordan
