Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbVH3RR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbVH3RR5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 13:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbVH3RR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 13:17:57 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:40385 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932232AbVH3RR4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 13:17:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Qn3X2Ah8kZzcxAJurMG5J0uxwInhF6s0w/gQdDBbsc35b94OfuIrm2WV/Qtz24Q8OfdmguqaBehWis8Bd1GBm4v9lOWUrWtz/J6b8A88St2wuQLAHmwNB2C3bvQeFIjDHECfZmnFoON1bKcWijN7C8BmfkKWCkjOp/rg9EqHjAc=
Message-ID: <9a874849050830101743c421db@mail.gmail.com>
Date: Tue, 30 Aug 2005 19:17:53 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Stephane Wirtel <stephane.wirtel@belgacom.net>
Subject: Re: [PATCH] 2.6.13 - 1/3 - Remove the deprecated function __check_region
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050830170502.GA10694@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050830170502.GA10694@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/05, Stephane Wirtel <stephane.wirtel@belgacom.net> wrote:
> Hi all,
> 
> Here is the first patch for kernel 2.6.13 from Linus tree.
> 

Take it easy. Don't kill __check_region() unless you first convert all
users of it.
And by removing __check_region() you've just broken check_region() -
There are still some drivers left that use check_region() and there's
no reason to break them.

The right approach is to identify all users of
check_region()/__check_region(), then submit patches to convert them
to use request_region instead. *Then*, when there are no more
in-kernel users left, submit patches to remove the deprecated
functions.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
