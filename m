Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbTLWVIJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 16:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbTLWVIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 16:08:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42644 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261890AbTLWVIH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 16:08:07 -0500
Date: Tue, 23 Dec 2003 21:08:06 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-mm1
Message-ID: <20031223210806.GE4176@parcelfarce.linux.theplanet.co.uk>
References: <20031222211131.70a963fb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031222211131.70a963fb.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 09:11:31PM -0800, Andrew Morton wrote:
> +inode-i_sb-checks.patch
> 
>  Add checks for null inode->i_sb in core VFS (we're still arguing about this)

They should be replaced with BUG_ON() or removed.
 
> +name_to_dev_t-fix.patch
> 
>  Don't replace slashes in names to `.'.  Replace them with `!' instead.  No
>  clue why, nobody tells me anything.

Take a look at /sys/block/ and you'll see - when we register disks, we mangle
the disk names that contain slashes (e.g. cciss/c0d0) replacing them with '!'
in corresponding sysfs names.  So name_to_dev_t() should mangle the name in
the same way before looking for it in /sys/block.
