Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVEIMA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVEIMA4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 08:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVEIMA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 08:00:56 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:60527 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261300AbVEIMAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 08:00:31 -0400
Message-ID: <427F50DB.2020705@yahoo.com.au>
Date: Mon, 09 May 2005 22:00:27 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
CC: Alexander Nyberg <alexn@dsv.su.se>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Jay Lan <jlan@engr.sgi.com>,
       aq <aquynh@gmail.com>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       elsa-devel <elsa-devel@lists.sourceforge.net>
Subject: Re: [PATCH 2.6.12-rc3-mm3] connector: add a fork connector
References: <1115626029.8548.24.camel@frecb000711.frec.bull.fr>	 <1115631107.936.25.camel@localhost.localdomain> <1115638724.8540.59.camel@frecb000711.frec.bull.fr>
In-Reply-To: <1115638724.8540.59.camel@frecb000711.frec.bull.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume Thouvenin wrote:
> On Mon, 2005-05-09 at 11:31 +0200, Alexander Nyberg wrote:

>>>Index: linux-2.6.12-rc3-mm3/kernel/fork.c
>>>===================================================================
>>>--- linux-2.6.12-rc3-mm3.orig/kernel/fork.c	2005-05-09 07:45:56.000000000 +0200
>>>+++ linux-2.6.12-rc3-mm3/kernel/fork.c	2005-05-09 08:03:15.000000000 +0200
>>>@@ -41,6 +41,7 @@
>>> #include <linux/profile.h>
>>> #include <linux/rmap.h>
>>> #include <linux/acct.h>
>>>+#include <linux/cn_fork.h>
>>> 
>>> #include <asm/pgtable.h>
>>> #include <asm/pgalloc.h>
>>>@@ -63,6 +64,14 @@ DEFINE_PER_CPU(unsigned long, process_co
>>> 
>>> EXPORT_SYMBOL(tasklist_lock);
>>> 
>>>+#ifdef CONFIG_FORK_CONNECTOR
>>>+/* 
>>>+ * fork_counts is used by the fork_connector() inline routine as 
>>>+ * the sequence number of the netlink message.
>>>+ */
>>>+static DEFINE_PER_CPU(unsigned long, fork_counts); 
>>>+#endif /* CONFIG_FORK_CONNECTOR */
>>>+
>>
>>The above should go into cn_fork.c
> 
> 
> I don't see why.
> 

Because you get these ugly ifdefs and things just spilling into
conceptually the wrong place. Why should anyone apart from the
fork connecter care how `fork_counts` is stored? And why would
any generic code care that it is defined when CONFIG_FORK_CONNECTOR
is set? Alexander is right, unless I missed something that requires
reading the code :)

-- 
SUSE Labs, Novell Inc.

