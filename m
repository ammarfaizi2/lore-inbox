Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030180AbWBDWKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030180AbWBDWKO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 17:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030186AbWBDWKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 17:10:14 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:9957 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030180AbWBDWKM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 17:10:12 -0500
Message-ID: <43E52642.9040104@us.ibm.com>
Date: Sat, 04 Feb 2006 14:10:10 -0800
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Benjamin LaHaise <bcrl@kvack.org>, Zach Brown <zach.brown@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/3] Vectorize aio_read/aio_write methods
References: <1138896758.28382.112.camel@dyn9047017102.beaverton.ibm.com> <1138896879.28382.114.camel@dyn9047017102.beaverton.ibm.com> <20060204132838.GA29549@infradead.org>
In-Reply-To: <20060204132838.GA29549@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
>  	do {
> -		ret = file->f_op->aio_read(iocb, iocb->ki_buf,
> -			iocb->ki_left, iocb->ki_pos);
> +		struct iovec iov = {
> +			.iov_base = iocb->ki_buf,
> +			.iov_len = iocb->ki_left
> +		};
> +
> +		ret = file->f_op->aio_read(iocb, &iov, 1, iocb->ki_pos);
> 
> this still has the lifetime problems Ben pointed out.  aio might still
> be outstanding when this thread returned to userspace, so we need to
> dynamically allocated the iovec and free it later.  (or make it part
> of the iocb?)

I left that intentionally alone. I was planning to make it a
special case of Zach's vector IO handling code.


Thanks,
Badari



