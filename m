Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWHOWMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWHOWMD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 18:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWHOWMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 18:12:03 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:46319 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750749AbWHOWMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 18:12:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=eIcB5K2PTQjf2s0YXfqLPJWqa+F2u0K4mkLkQVvjI4XgMObmDJ/Yl805ChBMiM9S+WirgrYpa5lVW1++HWnYVWmNCs7qzHi4AVLA9F67dlnaBfZTbWZ144PEv6CLl8bAVYFqxCWK+1KbHN/Y4X+i4exAASrnDr+uggfxwOvvqNM=
Date: Wed, 16 Aug 2006 02:11:57 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] add some unlikely() to fs/select.c
Message-ID: <20060815221156.GA5206@martell.zuzino.mipt.ru>
References: <20060815175447.GA8068@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060815175447.GA8068@rhlx01.fht-esslingen.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 07:54:47PM +0200, Andreas Mohr wrote:
> Add unlikely() to various core select() and poll() functions.

> Since these functions show up as X server related during profiling
> (which is quite obvious), I thought that adding some unlikely()
> shouldn't hurt...

Have you done any benchmarking? micro-benchmarking?

> I also moved some error code setting into error path (please yell if
> I shouldn't do that).

FWIW, unlikely part makes no difference whatsoever with my usual config
and gcc-3.4.6. Messing with error codes makes .o slightly bigger:

text    data     bss     dec     hex filename
4483       0       0    4483    1183 fs/select.o
4490       0       0    4490    118a fs/select.o
------------------------------------
			  +7

And don't mix several things in one patch.

