Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264867AbSLMPeF>; Fri, 13 Dec 2002 10:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264875AbSLMPeF>; Fri, 13 Dec 2002 10:34:05 -0500
Received: from tolkor.SGI.COM ([198.149.18.6]:56734 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S264867AbSLMPeF>;
	Fri, 13 Dec 2002 10:34:05 -0500
Date: Fri, 13 Dec 2002 17:55:26 -0500
From: Christoph Hellwig <hch@sgi.com>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: 2.5.50-mm2
Message-ID: <20021213175526.C2581@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>,
	Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org
References: <3DF453C8.18B24E66@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DF453C8.18B24E66@digeo.com>; from akpm@digeo.com on Mon, Dec 09, 2002 at 12:26:48AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2002 at 12:26:48AM -0800, Andrew Morton wrote:
> +remove-PF_SYNC.patch
> 
>  remove the current->flags:PF_SYNC abomination.  Adds a `sync' arg to
>  all writepage implementations to tell them whether they are being
>  called for memory cleansing or for data integrity.

Any chance you could pass down a struct writeback_control instead of
just the sync flag?  XFS always used ->writepage similar to the
->vm_writeback in older kernel releases because writing out more
than one page of delalloc space is really needed to be efficient and
this would allow us to get a few more hints about the VM's intentions.

