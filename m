Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265942AbTFWFHf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 01:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265946AbTFWFHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 01:07:35 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:62989 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265942AbTFWFHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 01:07:33 -0400
Date: Mon, 23 Jun 2003 06:21:37 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andries.Brouwer@cwi.nl
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] loop.c - part 1 of many
Message-ID: <20030623062137.A24311@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andries.Brouwer@cwi.nl, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <UTC200306230127.h5N1RpE13973.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <UTC200306230127.h5N1RpE13973.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Mon, Jun 23, 2003 at 03:27:51AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 23, 2003 at 03:27:51AM +0200, Andries.Brouwer@cwi.nl wrote:
> -static int figure_loop_size(struct loop_device *lo)
> +static int
> +figure_loop_size(struct loop_device *lo)

This moves away from Documentation/CondingStyle..

>  int loop_register_transfer(struct loop_func_table *funcs)
>  {
> -	if ((unsigned)funcs->number > MAX_LO_CRYPT || xfer_funcs[funcs->number])
> +	unsigned int n = funcs->number;
> +
> +	if (n >= MAX_LO_CRYPT || xfer_funcs[n])
>  		return -EINVAL;
> -	xfer_funcs[funcs->number] = funcs;
> -	return 0; 
> +	xfer_funcs[n] = funcs;
> +	return 0;
>  }

Once you start touching loop_{,un}register_transfer please also get
rid of the array in favour of a linked list..

