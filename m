Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267517AbTHSJPE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 05:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267561AbTHSJPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 05:15:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:56480 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267517AbTHSJPB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 05:15:01 -0400
Date: Tue, 19 Aug 2003 02:16:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, russo.lutions@verizon.net,
       linux-kernel@vger.kernel.org
Subject: Re: cache limit
Message-Id: <20030819021617.392f24f4.akpm@osdl.org>
In-Reply-To: <20030819090541.GA9038@werewolf.able.es>
References: <3F41AA15.1020802@verizon.net>
	<200308190533.h7J5XoL06419@Port.imtp.ilyichevsk.odessa.ua>
	<20030818232024.20c16d1f.akpm@osdl.org>
	<20030819090541.GA9038@werewolf.able.es>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" <jamagallon@able.es> wrote:
>
>  > It was not.  Instead we have fadvise.  So it would be appropriate to change
> 
>  Does this work in 2.4 ?
>  If not, any patch flying around ?

No.  It would be fairly messy to implement in 2.4 because 2.4 does not have
the per-inode radix trees for pagecache.  The implementation would need to
walk every page attached to the inode just to shoot down a single page. 
And all of it underneath the global pagecache lock.

But it is certainly possible.

