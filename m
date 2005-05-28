Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262522AbVE1JGC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbVE1JGC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 05:06:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262512AbVE1JGC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 05:06:02 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:33415 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262510AbVE1JFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 05:05:55 -0400
Date: Sat, 28 May 2005 10:05:41 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Carsten Otte <cotte@freenet.de>, suparna@in.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>, schwidefsky@de.ibm.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC/PATCH 2/4] fs/mm: execute in place (3rd version)
Message-ID: <20050528090541.GA19153@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	Carsten Otte <cotte@freenet.de>, suparna@in.ibm.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	schwidefsky@de.ibm.com, Andrew Morton <akpm@osdl.org>
References: <1116866094.12153.12.camel@cotte.boeblingen.de.ibm.com> <1116869420.12153.32.camel@cotte.boeblingen.de.ibm.com> <20050524093029.GA4390@in.ibm.com> <42930B64.2060105@freenet.de> <20050524133211.GA4896@in.ibm.com> <42933B7A.3060206@freenet.de> <1117043475.26913.1540.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117043475.26913.1540.camel@dyn318077bld.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2005 at 10:51:17AM -0700, Badari Pulavarty wrote:
> This is my crude version of the cleanup patch to reduce the 
> duplication of code.
> 
> Basically, I added __generic_file_aio_read_internal() and 
> __generic_file_aio_write_nolock_internal() to take a read/write
> handlers instead of defaulting to do_generic_file_read() or
> generic_file_buffered_write().
> 
> This way I was able to reduce 129 lines of your code. 
> This patch is on top of your current set and I haven't even
> tried compiling it. Needs cleanup.
>
> 
> BTW, function & variable names are too long and/or ugly & doesn't 
> make sense - need fixing.
> 
> Christoph/Suparna/Andrew, Comments ?

I don't like this patch a lot.  It adds another indirection to the code,
and still leaves the O_DIRECT branches in the XIP path that don't make
any sense.  If you're looking for a way to consolidate duplicated code
some abtraction for the iovec verification makes most sense, as there's
very little other code duplicated.

