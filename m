Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264572AbUD1BDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264572AbUD1BDr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 21:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264571AbUD1BDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 21:03:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:62639 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264573AbUD1BDY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 21:03:24 -0400
Date: Tue, 27 Apr 2004 18:02:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shantanu Goel <sgoel01@yahoo.com>
Cc: trond.myklebust@fys.uio.no, sgoel01@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc{1,2} bad VM/NFS interaction in case of dirty page
 writeback
Message-Id: <20040427180253.5a043319.akpm@osdl.org>
In-Reply-To: <20040428004707.89142.qmail@web12824.mail.yahoo.com>
References: <1083080207.2616.31.camel@lade.trondhjem.org>
	<20040428004707.89142.qmail@web12824.mail.yahoo.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shantanu Goel <sgoel01@yahoo.com> wrote:
>
> Andrew/Trond,
> 
> Any consensus as to what the right approach is here?

For now I suggest you do

-	err = WRITEPAGE_ACTIVATE;
+	err = 0;

in nfs_writepage().

> One cheap though perhaps hack'ish solution would be to
> introduce yet another special error code like
> WRITEPAGE_ACTIVATE which instead of moving the page to
> the head of the active list instead moves it to the
> head of the inactive list.

It would be better to set a flag in the backing_dev so that page reclaim
knows to not enter writepage at all.
