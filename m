Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263001AbUD2C6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbUD2C6Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 22:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbUD2C6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 22:58:25 -0400
Received: from ozlabs.org ([203.10.76.45]:42434 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263001AbUD2C6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 22:58:23 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16528.28485.996662.598051@cargo.ozlabs.ibm.com>
Date: Thu, 29 Apr 2004 12:58:13 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: brettspamacct@fastclick.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
In-Reply-To: <20040428194039.4b1f5d40.akpm@osdl.org>
References: <409021D3.4060305@fastclick.com>
	<20040428170106.122fd94e.akpm@osdl.org>
	<409047E6.5000505@pobox.com>
	<40905127.3000001@fastclick.com>
	<20040428180038.73a38683.akpm@osdl.org>
	<16528.23219.17557.608276@cargo.ozlabs.ibm.com>
	<20040428185342.0f61ed48.akpm@osdl.org>
	<20040428194039.4b1f5d40.akpm@osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> OK, a bit of fiddling does indicate that if a file is present on both
> client and server, and is modified on the client, the rsync client will
> indeed touch the pagecache pages twice.  Does this describe the files which
> you're copying at all?

The client/server thing is a bit misleading, what matters is the
direction of the transfer.  In the case I saw this morning, the G5 was
the sender.  In any case I was using the -W switch, which tells it not
to use the rsync algorithm but just transfer the whole file.  So I
believe that rsync on the G5 side was just reading the file through
once.

I have also noticed similar behaviour after doing a bk pull on a
kernel tree.

The really strange thing is that the behaviour seems to get worse the
more RAM you have.  I haven't noticed any problem at all on my laptop
with 768MB, only on the G5, which has 2.5GB.  (The laptop is still on
2.6.2-rc3 though, so I will try a newer kernel on it.)

Regards,
Paul.
