Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264288AbTKTFt7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 00:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264291AbTKTFt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 00:49:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31669 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264288AbTKTFt6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 00:49:58 -0500
Date: Thu, 20 Nov 2003 05:49:57 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Patrick Mochel <mochel@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [PATCH] sysfs_remove_dir Vs dcache_readdir race fix
Message-ID: <20031120054957.GD24159@parcelfarce.linux.theplanet.co.uk>
References: <20031120054707.GA1724@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031120054707.GA1724@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 20, 2003 at 11:17:07AM +0530, Maneesh Soni wrote:
> Hi,
> 
> sysfs_remove_dir modifies d_subdirs list which results in inconsistency
> when there is concurrent dcache_readdir is going on. I think there
> is no need for sysfs_remove_dir to modify d_subdirs list and removal
> of dentries from d_child list is taken care in the final dput().

WTF?

All instances of ->readdir() are protected by ->i_sem on parent.  So
are all operations in sysfs_remove_dir().

Have you actually observed any race there?
