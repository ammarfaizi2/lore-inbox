Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261542AbVG1OnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbVG1OnP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 10:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbVG1OkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 10:40:04 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:39803 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261520AbVG1OjA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 10:39:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fQKy3zMg/oB1prG8WWkcz6TojRZQ67AkmAMq1+kMj4/fqh2/MsAAi6gq7jiLjNVuRXg8yFe53dBTx9h7zGzafuFtze0AF3hI/72rc7LtLSkvmwf1c6ToSu0+47O59FSUoIFCpVaPHNdIXm5Q879xtXxM3MYMEG53DUp1Pqj+BKs=
Message-ID: <ee9e417a05072807381733876@mail.gmail.com>
Date: Thu, 28 Jul 2005 10:38:53 -0400
From: Russ Cox <russcox@gmail.com>
Reply-To: Russ Cox <russcox@gmail.com>
To: "ericvh@gmail.com" <ericvh@gmail.com>
Subject: Re: [V9fs-developer] [PATCH 2.6.13-rc3-mm2] v9fs: add fd based transport
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <200507281358.j6SDwBRZ026263@ms-smtp-03-eri0.texas.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200507281358.j6SDwBRZ026263@ms-smtp-03-eri0.texas.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int v9fs_fd_recv(struct v9fs_transport *trans, void *v, int len)
> +{
> +       struct v9fs_trans_fd *ts = trans ? trans->priv : NULL;
> +
> +       return kernel_read(ts->in_file, ts->in_file->f_pos, v, len);
> +}


> +static int v9fs_fd_send(struct v9fs_transport *trans, void *v, int len)
> +{
> +       struct v9fs_trans_fd *ts = trans ? trans->priv : NULL;
> +       mm_segment_t oldfs = get_fs();
> +       int ret = 0;
> +
> +       set_fs(get_ds());
> +       /* The cast to a user pointer is valid due to the set_fs() */
> +       ret = vfs_write(ts->out_file, (void __user *)v, len, &ts->out_file->f_pos);
> +       set_fs(oldfs);
> +
> +       return ret;
> +}

Perhaps there should be a kernel_write provided by the kernel?

Russ
