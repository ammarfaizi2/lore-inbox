Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265902AbTFVVaO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 17:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265927AbTFVVaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 17:30:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52969 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265902AbTFVVaI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 17:30:08 -0400
Date: Sun, 22 Jun 2003 22:44:12 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Lou Langholtz <ldl@aros.net>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@digeo.com>, torvalds@osdl.org
Subject: Re: [PATCH] nbd driver for 2.5+: fix for 2.5 block layer (improved)
Message-ID: <20030622214412.GM6754@parcelfarce.linux.theplanet.co.uk>
References: <3EF6034C.1070204@aros.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EF6034C.1070204@aros.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 22, 2003 at 01:28:12PM -0600, Lou Langholtz wrote:

> 4. that the allocation of request_queue is dynamic and seperate from 
> other allocated objects [Al]

*Ugh*.  Not on ->open(), please...  _If_ you really want that sort of
on-demand allocation - make it happen via blk_register_region() and
allocate both gendisk and queue at once.

However, I would suggest to make that a separate patch and for now allocate
queues at the same place where you allocate gendisks, without any on-demand
stuff.
