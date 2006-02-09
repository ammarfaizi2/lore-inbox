Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422832AbWBIGyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422832AbWBIGyb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 01:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422834AbWBIGya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 01:54:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50561 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422832AbWBIGya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 01:54:30 -0500
Date: Wed, 8 Feb 2006 22:53:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org, Mingming Cao <cmm@us.ibm.com>
Subject: Re: fsck: i_blocks is xxx should be yyy on ext3
Message-Id: <20060208225359.426573cf.akpm@osdl.org>
In-Reply-To: <43EA079A.4010108@aitel.hist.no>
References: <43EA079A.4010108@aitel.hist.no>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helge.hafting@aitel.hist.no> wrote:
>
>  Today I rebooted into 2.6.16-rc2-mm1.  Fsck checked a "clean" ext3 fs,
>  because it was many mounts since the last time.
> 
>  I have seen that many times, but this time I got a lot of
>  "i_blocks is xxx, should be yyy fix?"
> 
>  In all cases, the blocks were fixed to a lower number.

Yes, thanks.  It's due to the ext3_getblocks() patches in -mm.  I can't
think of any actual harm which it'll cause.

To reproduce:

mkfs
mount
dbench 32
<wait 20 seconds>
killall dbench
umount
fsck
