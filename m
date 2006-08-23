Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbWHWR15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbWHWR15 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 13:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWHWR15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 13:27:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17616 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932262AbWHWR14 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 13:27:56 -0400
Date: Wed, 23 Aug 2006 10:27:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: Akinobu Mita <mita@miraclelinux.com>, linux-kernel@vger.kernel.org,
       okuji@enbug.org
Subject: Re: [patch 4/5] fail-injection capability for disk IO
Message-Id: <20060823102741.b927e092.akpm@osdl.org>
In-Reply-To: <20060823120355.GD5893@suse.de>
References: <20060823113243.210352005@localhost.localdomain>
	<20060823113317.722640313@localhost.localdomain>
	<20060823120355.GD5893@suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2006 14:03:55 +0200
Jens Axboe <axboe@suse.de> wrote:

> On Wed, Aug 23 2006, Akinobu Mita wrote:
> > This patch provides fail-injection capability for disk IO.
> > 
> > Boot option:
> > 
> > 	fail_make_request=<probability>,<interval>,<times>,<space>
> > 
> > 	<probability>
> > 
> > 		specifies how often it should fail in percent.
> > 
> > 	<interval>
> > 
> > 		specifies the interval of failures.
> > 
> > 	<times>
> > 
> > 		specifies how many times failures may happen at most.
> > 
> > 	<space>
> > 
> > 		specifies the size of free space where disk IO can be issued
> > 		safely in bytes.
> > 
> > Example:
> > 
> > 	fail_make_request=100,10,-1,0
> > 
> > generic_make_request() fails once per 10 times.
> 
> Hmm dunno, seems a pretty useless feature to me.

We need it.  What is the FS/VFS/VM behaviour in the presence of IO
errors?  Nobody knows, because we rarely test it.  Those few times where
people _do_ test it (the hard way), bad things tend to happen.  reiserfs
(for example) likes to go wobble, wobble, wobble, BUG.

> Wouldn't it make a lot
> more sense to do this per-queue instead of a global entity?

Yes, I think so.  /sys/block/sda/sda2/make-it-fail.

