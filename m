Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWCIMF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWCIMF0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 07:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWCIMEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 07:04:50 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50378 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751895AbWCIMDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 07:03:10 -0500
Date: Thu, 9 Mar 2006 12:03:06 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Suzuki <suzuki@in.ibm.com>
Cc: linux-fsdevel@vger.kernel.org, "linux-aio kvack.org" <linux-aio@kvack.org>,
       lkml <linux-kernel@vger.kernel.org>, suparna <suparna@in.ibm.com>,
       akpm@osdl.org, linux-xfs@oss.sgi.com
Subject: Re: [RFC] Badness in __mutex_unlock_slowpath with XFS stress tests
Message-ID: <20060309120306.GA26682@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Suzuki <suzuki@in.ibm.com>, linux-fsdevel@vger.kernel.org,
	"linux-aio kvack.org" <linux-aio@kvack.org>,
	lkml <linux-kernel@vger.kernel.org>, suparna <suparna@in.ibm.com>,
	akpm@osdl.org, linux-xfs@oss.sgi.com
References: <440FDF3E.8060400@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440FDF3E.8060400@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 01:24:38PM +0530, Suzuki wrote:
> 
> Missed out linux-aio & linux-fs-devel lists. Forwarding.
> 
> Comments ?

I've seen this too.  The problem is that __generic_file_aio_read can return
with or without the i_mutex locked in the direct I/O case for filesystems
that set DIO_OWN_LOCKING.  It's a nasty one and I haven't found a better solution
than copying lots of code from filemap.c into xfs.

