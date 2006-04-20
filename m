Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbWDTXAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWDTXAy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 19:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWDTXAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 19:00:54 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:17085 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751222AbWDTXAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 19:00:54 -0400
Date: Fri, 21 Apr 2006 00:00:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: splice status
Message-ID: <20060420230053.GA3860@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
References: <20060420142902.GC4717@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060420142902.GC4717@suse.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 04:29:03PM +0200, Jens Axboe wrote:
>   converting them to ->splice_read(). There's also a patch there that
>   fixes up loop.

It actuaklly breaks loop in various setup.  You now directly call
do_generic_file_read which is just a library function for filesystems.
For example xfs or ocfs actually do need additional locking and/or other
bits before calling it.  So this absolutely has to go through a file
operation.

