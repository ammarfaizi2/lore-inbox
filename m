Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267974AbUJGWP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267974AbUJGWP6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 18:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268166AbUJGWN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 18:13:29 -0400
Received: from hera.kernel.org ([63.209.29.2]:53377 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S269851AbUJGWJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:09:21 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Probable module bug in linux-2.6.5-1.358
Date: Thu, 07 Oct 2004 15:09:28 -0700
Organization: Open Source Development Lab
Message-ID: <1097186968.29576.26.camel@localhost.localdomain>
References: <Pine.LNX.4.61.0410061807030.4586@chaos.analogic.com>
	  <1097175903.29576.12.camel@localhost.localdomain>
	 <1097175596.31547.111.camel@localhost.localdomain>
	  <Pine.LNX.4.61.0410071640250.3287@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1097186957 1101 172.20.1.60 (7 Oct 2004 22:09:17 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Thu, 7 Oct 2004 22:09:17 +0000 (UTC)
X-Evolution: 000000b4-0010
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't reproduce your problem with a simple dummy character device.

-------------
/*
 * Minimum driver to test character device stuff.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public
 * License version 2 as published by the Free Software Foundation.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public
 * License along with this program; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 021110-1307, USA.
 */

#include <linux/module.h>
#include <linux/init.h>
#include <linux/config.h>
#include <linux/kernel.h>
#include <linux/major.h>
#include <linux/fs.h>
#include <linux/device.h>

#define MYMAJOR	204

static int dummy_open(struct inode *inode, struct file *file)
{
	pr_info("dummy_open (%d)\n", iminor(inode));
	return 0;
}

static int dummy_release(struct inode *inode, struct file *file)
{
	pr_info("dummy_release (%d)\n", iminor(inode));
	return 0;
}

static struct file_operations dummy_ops = {
	.owner		= THIS_MODULE,
	.open		= dummy_open,
	.release	= dummy_release,
};

static int __init dummy_init(void)
{
	pr_info("dummy module init\n");
	return register_chrdev(MYMAJOR, "dummy", &dummy_ops);
}

static void __exit dummy_exit(void)
{
	pr_info("dummy module unloaded\n");
	unregister_chrdev(MYMAJOR, "dummy");
}

module_init(dummy_init);
module_exit(dummy_exit);

MODULE_LICENSE("GPL");


