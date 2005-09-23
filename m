Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbVIWI6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbVIWI6J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 04:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbVIWI6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 04:58:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64932 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750819AbVIWI6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 04:58:07 -0400
Date: Fri, 23 Sep 2005 01:57:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Sykes <chris@sigsegv.plus.com>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: Hang during rm on ext2 mounted sync (2.6.14-rc2+)
Message-Id: <20050923015719.5eb765a4.akpm@osdl.org>
In-Reply-To: <20050922163708.GF5898@sigsegv.plus.com>
References: <20050922163708.GF5898@sigsegv.plus.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Sykes <chris@sigsegv.plus.com> wrote:
>
> Kernels: 2.6.14-rc1 -> 2.6.14-rc2 + up to hg changeset 5c9ff0e17a61
> 
>  I'm experiencing processes getting stuck in the 'D' state whilst
>  rm'ing files on an ext2 fs mounted with the 'sync' option.  What I've
>  tested so far:
> 
>   * Ext2 mounted with sync:     rm hangs
>   * Ext2 mounted without sync:  OK
>   * Ext3 mounted with sync:     OK
>   * Ext3 mounted without sync:  OK
> 
>  I first noticed this on my /boot partition, and wanted to know whether
>  it was repeatable so I've created a few test ext2 filesystem images
>  and mounted them via loopback.

Odd.  Seems OK here.  How hard is it to make it occur?

I'd be suspecting a lost I/O completion from the device driver.  Are you
really sure that ext3 cannot be made to do the same thing?

Suggest you generate the `dmesg -s 1000000' output for both good and bad
kernels, do a `diff -u' on them and look for IDE complaints (or SCSI, if
you're on SCSI).

