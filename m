Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275352AbTHGOhA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 10:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275350AbTHGOg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 10:36:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:949 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S275352AbTHGOg6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 10:36:58 -0400
Message-ID: <3F3263FC.5030100@pobox.com>
Date: Thu, 07 Aug 2003 10:36:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: axboe@suse.de
Subject: Re: [PATCH] Proper block queue reference counting
References: <200308070909.h7799QHg022029@hera.kernel.org>
In-Reply-To: <200308070909.h7799QHg022029@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I like the patch, but see two problems:

1) You convert drivers to dynamically allocated queues... who is freeing 
the queues?  unregister_blkdev?  It's a bit non-obvious to say the 
least, since you patches (for example, the first one, to stram.c) 
obviously switch blk_init_queue to dynamically allocate a queue...  but 
you do not add code to remove the final reference in modprobe.  The 
standard driver-facing API dictates that the driver calls foo_put 
itself, in the driver, rather than have it done implicitly.

2) the blk_init_queue really should change names, IMO.  The other 
subsystems in the kernel tend to use a "foo_alloc" or "alloc_foo" 
pattern when creating new objects.  blk_alloc_queue, or simply blk_alloc?

	Jeff



