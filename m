Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751536AbWFWSpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbWFWSpp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751918AbWFWSp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:45:27 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:26263 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751944AbWFWSpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:45:23 -0400
Date: Fri, 23 Jun 2006 19:45:20 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alasdair G Kergon <agk@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dm: support ioctls on mapped devices: fix with fake file
Message-ID: <20060623184520.GB22172@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alasdair G Kergon <agk@redhat.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060623183829.GZ19222@agk.surrey.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623183829.GZ19222@agk.surrey.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 07:38:29PM +0100, Alasdair G Kergon wrote:
> [This applies after all the current dm patches.]

NACK.  You should use ioctl_by_bdev and fix it to fake up the file pointer
instead.  That keeps faking the file pointer in a single place and solves
the problem of NULL file pointers for other cases like the s390 partitioning
code, or various odd filesystems figuring out partition tables by themselves.

For bonus points use a common helper for both blkdev_get and ioctl_by_bdev
that creates the fake struct file.
