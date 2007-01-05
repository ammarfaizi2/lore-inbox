Return-Path: <linux-kernel-owner+w=401wt.eu-S1161049AbXAEKnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161049AbXAEKnZ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 05:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161051AbXAEKnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 05:43:25 -0500
Received: from sophia.inria.fr ([138.96.64.20]:49399 "EHLO sophia.inria.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161050AbXAEKnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 05:43:24 -0500
Message-ID: <459E2B46.1090504@yahoo.fr>
Date: Fri, 05 Jan 2007 11:41:10 +0100
From: Guillaume Chazarain <guichaz@yahoo.fr>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] Handle error in sync_sb_inodes()
References: <45958E4F.5080105@yahoo.fr>	<20070102132645.264d2b89.akpm@osdl.org>	<459C2E6D.2040406@yahoo.fr> <20070103145655.c6e0963d.akpm@osdl.org> <459D095E.4050306@yahoo.fr>
In-Reply-To: <459D095E.4050306@yahoo.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (sophia.inria.fr [138.96.64.20]); Fri, 05 Jan 2007 11:41:11 +0100 (MET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume Chazarain a écrit :
> Still no luck :-(

First, sorry for the double posting.

The mapping flag is cleared by this call trace:

do_sync(1)
sync_inodes(1)
__sync_inodes(1)
sync_inodes_sb(sb, 1)
sync_sb_inodes(sb, WB_SYNC_ALL)
__writeback_single_inode(inode, WB_SYNC_ALL)
__sync_single_inode(inode, WB_SYNC_ALL)
filemap_fdatawait(mapping)
wait_on_page_writeback_range(mapping)
test_and_clear(...)

So, I can't see any solution other than:
 - asking wait_on_page_writeback_range(mapping) to
leave the flag as is
               or
 - adding a mapping_set_error() after one of the call
in the trace.

Regards.

-- 
Guillaume

