Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbULAVIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbULAVIE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 16:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbULAVID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 16:08:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:18670 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261448AbULAVIB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 16:08:01 -0500
Date: Wed, 1 Dec 2004 13:07:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: maneesh@in.ibm.com, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Delete sysfs_dirent.s_count, saving ~100kB on my system
Message-Id: <20041201130703.79a3f3b5.akpm@osdl.org>
In-Reply-To: <200412011856.iB1IuAc21682@adam.yggdrasil.com>
References: <200412011856.iB1IuAc21682@adam.yggdrasil.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" <adam@yggdrasil.com> wrote:
>
> 	Here is a rewrite of my patch to remove sysfs_dirent.s_count,
>  reducing the memory chunk that kmalloc uses for sysfs_dirent from
>  64 to 32 bytes, thereby saving about 120kB for the 3700+ nodes in
>  /sys on the ordinary PC on which I am typing this message.

That's all well and good, but sysfs_new_dirent() should be using a
standalone slab cache for allocating sysfs_dirent instances.  That way, we
use 36 bytes for each one rather than 64.
