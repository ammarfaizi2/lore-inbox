Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262952AbUKXXgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262952AbUKXXgi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 18:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262987AbUKXXfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 18:35:08 -0500
Received: from zeus.kernel.org ([204.152.189.113]:3010 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262890AbUKXXTO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 18:19:14 -0500
Date: Wed, 24 Nov 2004 22:18:00 +0100
From: Jens Axboe <axboe@suse.de>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: "Christopher S. Aker" <caker@theshore.net>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.10-rc2-bk7 - kernel BUG at fs/sysfs/file.c:87!
Message-ID: <20041124211800.GQ13847@suse.de>
References: <002c01c4d25b$3e8b9b10$0201a8c0@hawk> <20041124204138.GA2543@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041124204138.GA2543@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24 2004, Maneesh Soni wrote:
> On Wed, Nov 24, 2004 at 07:26:43PM +0000, Christopher S. Aker wrote:
> > Doing "cat /sys/block/sda/queue/iosched/show_status" produces the following BUG:
> > 
> > ------------[ cut here ]------------
> > kernel BUG at fs/sysfs/file.c:87!
> 
> I think you are using cfq io scheduler. show_status is from cfq_ioched. Looks 
> like return value freom cfq_status_show() is going beyond one page. 
> read/write buffer for sysfs text attribute files is limited to one page. 

Yeah, with many processes that is easy to hit. I dunno how to fix it
yet, is it possible to combine sysfs with the seq stuff? The file should
just be deleted, though.

-- 
Jens Axboe

