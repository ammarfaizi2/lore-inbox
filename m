Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318726AbSHWKGx>; Fri, 23 Aug 2002 06:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318730AbSHWKGx>; Fri, 23 Aug 2002 06:06:53 -0400
Received: from pc-80-195-35-4-ed.blueyonder.co.uk ([80.195.35.4]:9089 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S318726AbSHWKGw>; Fri, 23 Aug 2002 06:06:52 -0400
Date: Fri, 23 Aug 2002 11:10:58 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Christoph Hellwig <hch@infradead.org>, Stephen Tweedie <sct@redhat.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch 1/2] 2.4.20-pre4/ext3: Handle dirty buffers encountered unexpectedly.
Message-ID: <20020823111058.E2801@redhat.com>
References: <200208222319.g7MNJaG09082@sisko.scot.redhat.com> <20020823105933.A12435@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020823105933.A12435@infradead.org>; from hch@infradead.org on Fri, Aug 23, 2002 at 10:59:33AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 23, 2002 at 10:59:33AM +0100, Christoph Hellwig wrote:

> Btw, is the following patch still aimed for inclusion?
 
> --- linux/fs/buffer.c.~1~	Fri Apr 12 17:59:09 2002
> +++ linux/fs/buffer.c	Sat Apr 13 21:09:36 2002
>  	/* Stage 3: start the IO */
> -	for (i = 0; i < nr; i++)
> -		submit_bh(READ, arr[i]);
> -
> +	for (i = 0; i < nr; i++) {
> +		struct buffer_head * bh = arr[i];
> +		if (buffer_uptodate(bh))
> +			end_buffer_io_async(bh, 1);
> +		else
> +			submit_bh(READ, bh);
> +	}
> +	

Yes, it's in my next batch.

--Stephen
