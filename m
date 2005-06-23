Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262105AbVFWFsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbVFWFsx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 01:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbVFWFsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 01:48:53 -0400
Received: from mail.enyo.de ([212.9.189.167]:48397 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S262105AbVFWFsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 01:48:51 -0400
From: Florian Weimer <fw@deneb.enyo.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andreas Gruenbacher <agruen@suse.de>, Olaf Kirch <okir@suse.de>,
       Trond Myklebust <Trond.Myklebust@netapp.com>
Subject: Potential xdr_xcode_array2 security issue (was: Re: [PATCH] RPC: Encode and decode arbitrary XDR arrays)
References: <200506230502.j5N52PWP007955@hera.kernel.org>
Date: Thu, 23 Jun 2005 07:48:41 +0200
In-Reply-To: <200506230502.j5N52PWP007955@hera.kernel.org> (Linux Kernel
	Mailing List's message of "Wed, 22 Jun 2005 22:02:25 -0700")
Message-ID: <87y8911v46.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linux Kernel Mailing List:

> +xdr_xcode_array2(struct xdr_buf *buf, unsigned int base,
> +		 struct xdr_array2_desc *desc, int encode)
> +{
> +	char *elem = NULL, *c;
> +	unsigned int copied = 0, todo, avail_here;
> +	struct page **ppages = NULL;
> +	int err;
> +
> +	if (encode) {
> +		if (xdr_encode_word(buf, base, desc->array_len) != 0)
> +			return -EINVAL;
> +	} else {
> +		if (xdr_decode_word(buf, base, &desc->array_len) != 0 ||
> +		    (unsigned long) base + 4 + desc->array_len *
> +				    desc->elem_size > buf->len)
> +			return -EINVAL;
> +	}

This looks suspiciously like CVE-2002-0391.
