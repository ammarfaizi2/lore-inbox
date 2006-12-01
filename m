Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933577AbWLAHQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933577AbWLAHQR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 02:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933603AbWLAHQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 02:16:17 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:8573 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S933577AbWLAHQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 02:16:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uqutQC8nESI7gnqceXcMII69kBgpHsyaHUVcbGed/kgYgexD2dp7kvMARsZyvEkAWRIS9YT8SzO+GhmKJBHBopIWLFg5dwvOD5l8zmPh7dyv6FeaBikE2i+1fl4F0DUMWXO+66bkTP2DON5T/58DZds8NVnnv9KuCsOqgj9CxNM=
Message-ID: <b1e142760611302316w5917bc67q5a9f26e1d069f716@mail.gmail.com>
Date: Fri, 1 Dec 2006 02:16:15 -0500
From: "Ming Zhao" <mingzhao99th@gmail.com>
To: "device-mapper development" <dm-devel@redhat.com>
Subject: Re: [dm-devel] [RFC][PATCH] dm-cache: block level disk cache target for device mapper
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200611302107.40418.jens.wilke@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200611271826.kARIQYRi032717@hera.kernel.org>
	 <200611301232.57966.jens.wilke@de.ibm.com>
	 <a4e6962a0611300824qdfa43cbja783da86fe6eb5cf@mail.gmail.com>
	 <200611302107.40418.jens.wilke@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/06, Jens Wilke <jens.wilke@de.ibm.com> wrote:
> - You don't keep track of I/O on the fly to the cache that is mapped
> directly in cache_hit(). How do you make sure that this I/O is completed
> before you replace a cache block?

The previous I/O from cache hit and the later I/O for cache
replacement should be queued in order on the cache block device - is
this a safe assumption?

> - The cache block index is hashed, this means the cache data blocks are not
> clustered. I don't think you can solve this problem with a proper hash function.
> Perhaps you should consider a (B-)Tree structure for that.

The current hash algorithm does clustering to some extent by mapping
consecutive blocks from the source device to consecutive blocks on the
cache device. But I agree that more sophisticated algorithms can be
studied.

Thanks a lot for the suggestions. I will try to incorporate them in
the next patch.

- Ming
