Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263439AbTKFI5k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 03:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbTKFI5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 03:57:39 -0500
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:55566 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263439AbTKFI5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 03:57:39 -0500
Date: Thu, 6 Nov 2003 08:57:35 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jack Steiner <steiner@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, davidm@hpl.hp.com,
       jbarnes@sgi.com
Subject: Re: [PATCH] - Allow architectures to increase size of MAX_NR_MEMBLKS
Message-ID: <20031106085735.A14360@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jack Steiner <steiner@sgi.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, davidm@hpl.hp.com, jbarnes@sgi.com
References: <20031105181911.GA22082@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031105181911.GA22082@sgi.com>; from steiner@sgi.com on Wed, Nov 05, 2003 at 12:19:11PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 05, 2003 at 12:19:11PM -0600, Jack Steiner wrote:
> This fixes a problem that occurs on system with >64 nodes. 
> 
> Previously, MAX_NR_MEMBLKS was defined as BITS_PER_LONG. This
> patch allows an architecture to override this definition by
> defining a value in the arch-specific asm-xxx/mmzone.h file.

IMHO this is too much clutter.  Just make it mandatory for the
architectures to define their own MAX_NR_MEMBLKS in the numa case.

Or actually even better just have a 

#ifndef MAX_NR_MEMBLKS
#define MAX_NR_MEMBLKS	1
#endif

in the generic code and let every architecture that wants to override
it do so.

