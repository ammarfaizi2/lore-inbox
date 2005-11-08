Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965180AbVKHUBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965180AbVKHUBr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 15:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbVKHUBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 15:01:47 -0500
Received: from pat.uio.no ([129.240.130.16]:53892 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S965180AbVKHUBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 15:01:46 -0500
Subject: re: mmap over nfs leads to excessive system load
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Kenny Simpson <theonetruekenny@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051108192515.17247.qmail@web34105.mail.mud.yahoo.com>
References: <20051108192515.17247.qmail@web34105.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Tue, 08 Nov 2005 12:01:47 -0800
Message-Id: <1131480107.32482.48.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.333, required 12,
	autolearn=disabled, AWL 1.67, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-08 at 11:25 -0800, Kenny Simpson wrote:
> Just another data point....
> If I open the file with O_DIRECT.. not much changes:

Hmm... Are you mounting using the -osync or -onoac options? Doing
synchronous writes will tend to slow down flushing considerably, and the
VM appears to be very fragile w.r.t. slow filesystems.

Cheers,
  Trond


> samples  %        image name               app name                 symbol name
> 12585321 18.9373  vmlinux-2.6.14           vmlinux-2.6.14           find_get_pages_tag
> 8608887  12.9539  vmlinux-2.6.14           vmlinux-2.6.14           mpage_writepages
> 6870600  10.3383  vmlinux-2.6.14           vmlinux-2.6.14           unlock_page
> 6605417   9.9393  vmlinux-2.6.14           vmlinux-2.6.14           clear_page_dirty_for_io
> 6259207   9.4183  vmlinux-2.6.14           vmlinux-2.6.14           release_pages
> 3249493   4.8896  vmlinux-2.6.14           vmlinux-2.6.14           __lookup_tag
> 3248871   4.8886  vmlinux-2.6.14           vmlinux-2.6.14           pci_conf1_write
> 2677914   4.0295  vmlinux-2.6.14           vmlinux-2.6.14           page_waitqueue
> 982811    1.4789  vmlinux-2.6.14           vmlinux-2.6.14           _read_lock_irqsave
> 917165    1.3801  vmlinux-2.6.14           vmlinux-2.6.14           _read_unlock_irq
> 758960    1.1420  vmlinux-2.6.14           vmlinux-2.6.14           __wake_up_bit
> 706607    1.0632  vmlinux-2.6.14           vmlinux-2.6.14           _spin_lock_irqsave
> 
> 
> -Kenny
> 
> 
> 
> 	
> 		
> __________________________________ 
> Yahoo! Mail - PC Magazine Editors' Choice 2005 
> http://mail.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

