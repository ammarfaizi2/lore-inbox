Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262703AbVGNWH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbVGNWH5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 18:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbVGNWHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 18:07:32 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:59341 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262551AbVGNWFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 18:05:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=oNHfzr33Qq8qUV0a7nc7GPNJhJBrdu9MMdfO1hG7Iqv4CwmsOL781BQol0uPusgsi9135RW4CF1//nfn3fbJx77mEc+zIQ2v7qFJjdyAq1MydIa4kpS+oapLrLX9EAN32JPab8Gze/1HiJSe0yCvbj0LeGPj233nlpZW8OJVqUU=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Eric Van Hensbergen <ericvh@gmail.com>
Subject: Re: (v9fs) -mm -> 2.6.13 merge status
Date: Fri, 15 Jul 2005 02:12:00 +0400
User-Agent: KMail/1.8.1
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       rminnich@lanl.gov, linux-kernel@vger.kernel.org,
       v9fs-developer@lists.sourceforge.net
References: <20050620235458.5b437274.akpm@osdl.org> <a4e6962a050713112363010124@mail.gmail.com> <20050714200408.GA23092@infradead.org>
In-Reply-To: <20050714200408.GA23092@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507150212.00515.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 July 2005 00:04, Christoph Hellwig wrote:
> normally we prefer a patch per actual change, not per file so the
> description fits.  Given that all these are pretty trivial fixes one
> patch would have done it aswell, though.
> 
> With these changes the code is fine for mainline in my opinion.

Can I make one more nitpicking comment?

All these functions can use cpu_to_le*() and le*_to_cpu().

> --- /dev/null
> +++ 25-akpm/fs/9p/conv.c

> +static inline void buf_put_int16(struct cbuf *buf, u16 val)
> +{
> +	buf_check_sizev(buf, 2);
> +
> +	buf->p[0] = val;
> +	buf->p[1] = val >> 8;
> +	buf->p += 2;
> +}
> +
> +static inline void buf_put_int32(struct cbuf *buf, u32 val)
> +{
> +	buf_check_sizev(buf, 4);
> +
> +	buf->p[0] = val;
> +	buf->p[1] = val >> 8;
> +	buf->p[2] = val >> 16;
> +	buf->p[3] = val >> 24;
> +	buf->p += 4;
> +}
> +
> +static inline void buf_put_int64(struct cbuf *buf, u64 val)
> +{
> +	buf_check_sizev(buf, 8);
> +
> +	buf->p[0] = val;
> +	buf->p[1] = val >> 8;
> +	buf->p[2] = val >> 16;
> +	buf->p[3] = val >> 24;
> +	buf->p[4] = val >> 32;
> +	buf->p[5] = val >> 40;
> +	buf->p[6] = val >> 48;
> +	buf->p[7] = val >> 56;
> +	buf->p += 8;
> +}

> +static inline u16 buf_get_int16(struct cbuf *buf)
> +{
> +	u16 ret = 0;
> +
> +	buf_check_size(buf, 2);
> +	ret = buf->p[0] | (buf->p[1] << 8);
> +
> +	buf->p += 2;
> +
> +	return ret;
> +}
> +
> +static inline u32 buf_get_int32(struct cbuf *buf)
> +{
> +	u32 ret = 0;
> +
> +	buf_check_size(buf, 4);
> +	ret =
> +	    buf->p[0] | (buf->p[1] << 8) | (buf->p[2] << 16) | (buf->
> +								p[3] << 24);
> +
> +	buf->p += 4;
> +
> +	return ret;
> +}
> +
> +static inline u64 buf_get_int64(struct cbuf *buf)
> +{
> +	u64 ret = 0;
> +
> +	buf_check_size(buf, 8);
> +	ret = (u64) buf->p[0] | ((u64) buf->p[1] << 8) |
> +	    ((u64) buf->p[2] << 16) | ((u64) buf->p[3] << 24) |
> +	    ((u64) buf->p[4] << 32) | ((u64) buf->p[5] << 40) |
> +	    ((u64) buf->p[6] << 48) | ((u64) buf->p[7] << 56);
> +
> +	buf->p += 8;
> +
> +	return ret;
> +}
