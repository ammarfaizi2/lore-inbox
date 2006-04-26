Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbWDZC0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWDZC0k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 22:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWDZC0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 22:26:40 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:26343 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932348AbWDZC0k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 22:26:40 -0400
Date: Wed, 26 Apr 2006 03:26:35 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, Jens Axboe <axboe@suse.de>,
       Greg KH <greg@kroah.com>
Subject: Re: [patch 3/3] use kref for bio
Message-ID: <20060426022635.GF27946@ftp.linux.org.uk>
References: <20060426021059.235216000@localhost.localdomain> <20060426021122.069267000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060426021122.069267000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 10:11:02AM +0800, Akinobu Mita wrote:
> Use kref for reference counter of bio.
> This patch also removes BUG_ON() for freeing unreferenced bio.
> But kref can detect it if CONFIG_DEBUG_SLAB is enabled.
 
*Ugh*

Let's _not_.  It's extra overhead for no good reason.

Just in case: any kref conversion for
	* super_block
	* inode
	* dentry
	* file
is NAKed while we are at it.
