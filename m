Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751914AbWFWTNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbWFWTNs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 15:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751946AbWFWTNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 15:13:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43202 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751914AbWFWTNs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 15:13:48 -0400
Date: Fri, 23 Jun 2006 20:13:40 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dm: support ioctls on mapped devices: fix with fake file
Message-ID: <20060623191340.GA19222@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060623183829.GZ19222@agk.surrey.redhat.com> <20060623184520.GB22172@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623184520.GB22172@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 07:45:20PM +0100, Christoph Hellwig wrote:
> NACK.  You should use ioctl_by_bdev and fix it to fake up the file pointer
> instead.  That keeps faking the file pointer in a single place and solves
> the problem of NULL file pointers for other cases like the s390 partitioning
> code, or various odd filesystems figuring out partition tables by themselves.
> For bonus points use a common helper for both blkdev_get and ioctl_by_bdev
> that creates the fake struct file.

Fixing the existing callers that pass a NULL file struct is a separate matter
that can be handled by a later patch, as can consolidating all the fake users.

I don't follow the reasoning behind backing out and using ioctl_by_bdev() here.
Isn't the primary reason for its existence to add a set_fs(KERNEL_DS) to the
mix?  I don't understand why device-mapper should interfere (surely
incorrectly?) at that level.

Alasdair
-- 
agk@redhat.com
