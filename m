Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936134AbWLAKaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936134AbWLAKaP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 05:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936172AbWLAKaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 05:30:14 -0500
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:14940 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S936134AbWLAKaM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 05:30:12 -0500
From: Jens Wilke <jens.wilke@de.ibm.com>
Organization: IBM Deutschland GmbH
To: dm-devel@redhat.com
Subject: Re: [dm-devel] [RFC][PATCH] dm-cache: block level disk cache target for device mapper
Date: Fri, 1 Dec 2006 11:30:04 +0100
User-Agent: KMail/1.9.4
Cc: "Ming Zhao" <mingzhao99th@gmail.com>, linux-kernel@vger.kernel.org
References: <200611271826.kARIQYRi032717@hera.kernel.org> <200611302107.40418.jens.wilke@de.ibm.com> <b1e142760611302316w5917bc67q5a9f26e1d069f716@mail.gmail.com>
In-Reply-To: <b1e142760611302316w5917bc67q5a9f26e1d069f716@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612011130.04466.jens.wilke@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 December 2006 08:16, Ming Zhao wrote:
> On 11/30/06, Jens Wilke <jens.wilke@de.ibm.com> wrote:
> > - You don't keep track of I/O on the fly to the cache that is mapped
> > directly in cache_hit(). How do you make sure that this I/O is completed
> > before you replace a cache block?
> 
> The previous I/O from cache hit and the later I/O for cache
> replacement should be queued in order on the cache block device - is
> this a safe assumption?

I don't think you can assume that the request processing in the host
is ordered without sychronization. Everything you queue in your worker
thread is serialized by that. Everything else is out of your control and each
thread may be scheduled or not.

Maybe we have certain guarantees through DM or the block I/O layer, that
I don't know. Can somebody else step in here?

Best,

Jens
