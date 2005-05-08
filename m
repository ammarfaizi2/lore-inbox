Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVEHHJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVEHHJn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 03:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262819AbVEHHJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 03:09:24 -0400
Received: from [192.171.113.101] ([192.171.113.101]:30609 "EHLO
	fir.nerdvana.com") by vger.kernel.org with ESMTP id S261404AbVEHHJU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 03:09:20 -0400
Subject: Re: PROBLEM: Reiserfs stall 2.6.10-bk7 up through 2.6.12-rc3
From: George Ronkin <gronkin@nerdvana.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1115428405.2233.65.camel@fir.nerdvana.com>
References: <1115428405.2233.65.camel@fir.nerdvana.com>
Content-Type: text/plain
Date: Sun, 08 May 2005 00:09:08 -0700
Message-Id: <1115536148.9660.17.camel@fir.nerdvana.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-06 at 18:13 -0700, George Ronkin wrote:
> ... one of my machines now stalls
> attempting to access the reiserfs file system used as that server's
> spool...  This problem did not occur before 2.6.10-bk7.  That and all subsequent
> kernels I've tried (Debian 2.6.11, stock 2.6.12-rc3, and 2.6.12-rc3-mm3)
> cause the problem, consistently and repeatably.
	As does 2.6.12-rc4.  The unusual 1K block size I used for this reiserfs
seems to have exposed the problem; all my other reiserfs use 4K and have
no problem.  I copied its contents to a new reiserfs I created with 4K
blocks and the later kernels work fine with the copy.  I also tried
turning off CONFIG_QUOTA on 2.6.12-rc4 - that worked with the 1K block
reiserfs as well.  I'm keeping the 4K block copy, since that works with
QUOTA, and turning QUOTA off affects non-reiserfs fs as well.
	Note also:

- The 1K block fs caused the problem even though no quota mount options
were set.

- All my reiserfs are devmapped, so I don't know if the problem occurs
without it on a physical partition, or whether the symptoms would
differ.
	HTH,
-- 
George Ronkin <gronkin@nerdvana.com>

