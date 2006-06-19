Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbWFSTh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbWFSTh6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 15:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbWFSTh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 15:37:58 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:28110 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964861AbWFSTh5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 15:37:57 -0400
Date: Mon, 19 Jun 2006 20:37:56 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Theodore Tso <tytso@thunk.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH 6/8] inode-diet: Move i_cindex from struct inode to struct file
Message-ID: <20060619193756.GM27946@ftp.linux.org.uk>
References: <20060619152003.830437000@candygram.thunk.org> <20060619153110.075342000@candygram.thunk.org> <20060619193335.GL27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619193335.GL27946@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 08:33:35PM +0100, Al Viro wrote:
> On Mon, Jun 19, 2006 at 11:20:09AM -0400, Theodore Tso wrote:
> > inode.i_cindex isn't initialized until the character device is opened
> > anyway, and there are far more struct inodes in memory than there are
> > struct file.  So move the cindex field to file.f_cindex, and change
> > the one(!) user of cindex to use file pointer, which is in fact simpler.
> 
> NAK.  Please, take it to the union into cdev part.

Explanation: the whole point of that sucker is to avoid i_rdev use
in drivers, switching to i_cdev + i_cindex.  _Especially_ in open().
There is a bunch of other drivers that would get cleaner from that,
including a lot of tty code.
