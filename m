Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbTEAS3T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 14:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbTEAS3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 14:29:19 -0400
Received: from [12.47.58.20] ([12.47.58.20]:54750 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S261241AbTEAS3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 14:29:17 -0400
Date: Thu, 1 May 2003 11:42:29 -0700
From: Andrew Morton <akpm@digeo.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: must-fix list for 2.6.0
Message-Id: <20030501114229.64fbbfa2.akpm@digeo.com>
In-Reply-To: <20030501153325.A15458@infradead.org>
References: <20030429155731.07811707.akpm@digeo.com>
	<20030501153325.A15458@infradead.org>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 May 2003 18:41:32.0897 (UTC) FILETIME=[496E7510:01C31011]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> drivers/scsi/
> 
>  - large parts of the locking are hosed or not existant
>       o shost->my_devices isn't locked down at all
>       o the host list ist locked but not refcounted, mess can
>          happen when the spinlock is dropped
>       o there are lots of members of struct Scsi_Host/scsi_device/scsi_cmnd
>         with very unclear locking, many of them probably want to become
> 	atomic_t's or bitmaps (for the 1bit bitfields).
>       o there's lots of volatile abuse in the scsi code that needs to
>         be thought about.
>       o there's some global variables incremented without any locks

Thanks.

> fs/devfs/
> 
>  - there's a fundamental lookup vs devfsd race that's only fixable
>    by introducing a lookup vs devfs deadlock.  I can't see how this
>    is fixable without getting rid of the current devfsd design.
>    Mandrake seems to have a workaround for this so this is at least
>    not triggered so easily, but that's not what I'd considere a fix..

Look.  Please.  If you have the time, let's just put it out of its misery.

I had two concerns with smalldevfs:

- It's dropping a semaphore (i_sem?) during its synchronous userspace
  callout.  That was for deadlock avoidance and may have introduced a race.

- The new userspace doesn't support the compatibility names.  Just some
  config file, or a tarball or a dang shell script full of `ln -s'
  calls would fix that up, I think.



