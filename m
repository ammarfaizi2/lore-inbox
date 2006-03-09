Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751947AbWCIWm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbWCIWm0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 17:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751958AbWCIWm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 17:42:26 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:2205 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751947AbWCIWmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 17:42:25 -0500
Date: Thu, 9 Mar 2006 22:42:19 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Nathan Scott <nathans@sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, Suzuki <suzuki@in.ibm.com>,
       linux-fsdevel@vger.kernel.org,
       "linux-aio kvack.org" <linux-aio@kvack.org>,
       lkml <linux-kernel@vger.kernel.org>, suparna <suparna@in.ibm.com>,
       akpm@osdl.org, linux-xfs@oss.sgi.com
Subject: Re: [RFC] Badness in __mutex_unlock_slowpath with XFS stress tests
Message-ID: <20060309224219.GA6709@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nathan Scott <nathans@sgi.com>, Suzuki <suzuki@in.ibm.com>,
	linux-fsdevel@vger.kernel.org,
	"linux-aio kvack.org" <linux-aio@kvack.org>,
	lkml <linux-kernel@vger.kernel.org>, suparna <suparna@in.ibm.com>,
	akpm@osdl.org, linux-xfs@oss.sgi.com
References: <440FDF3E.8060400@in.ibm.com> <20060309120306.GA26682@infradead.org> <20060309223042.GC1135@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060309223042.GC1135@frodo>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2006 at 09:30:42AM +1100, Nathan Scott wrote:
> Not for reads AFAICT - __generic_file_aio_read + own-locking
> should always have released i_mutex at the end of the direct
> read - are you thinking of writes or have I missed something?

if an error occurs before a_ops->direct_IO is called __generic_file_aio_read
will return with i_mutex still locked.  Note that checking for negative
return values is not enough as __blockdev_direct_IO can return errors
aswell.

