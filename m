Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267671AbSLGAWh>; Fri, 6 Dec 2002 19:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267672AbSLGAWh>; Fri, 6 Dec 2002 19:22:37 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:12812 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267671AbSLGAWg>; Fri, 6 Dec 2002 19:22:36 -0500
Date: Sat, 7 Dec 2002 00:30:11 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Mark Haverkamp <markh@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] aacraid 2.5
Message-ID: <20021207003011.A21628@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mark Haverkamp <markh@osdl.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1039189541.6401.8.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1039189541.6401.8.camel@markh1.pdx.osdl.net>; from markh@osdl.org on Fri, Dec 06, 2002 at 07:45:42AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2002 at 07:45:42AM -0800, Mark Haverkamp wrote:
> +/**
> + * 	Convert capacity to cylinders
> + *  	accounting for the fact capacity could be a 64 bit value
> + *
> + */
> +static inline u32 cap_to_cyls(sector_t capacity, u32 divisor)
> +{
> +#ifdef CONFIG_LBD
> +	do_div(capacity, divisor);
> +#else
> +	capacity /= divisor;
> +#endif
> +	return (u32) capacity;
> +}

Please use sector_div() instead.  It exists for a reason.

