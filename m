Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262790AbSKRSKT>; Mon, 18 Nov 2002 13:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262905AbSKRSKT>; Mon, 18 Nov 2002 13:10:19 -0500
Received: from packet.digeo.com ([12.110.80.53]:34758 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262790AbSKRSKR>;
	Mon, 18 Nov 2002 13:10:17 -0500
Message-ID: <3DD92E92.EEB9ECD6@digeo.com>
Date: Mon, 18 Nov 2002 10:16:50 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, rml@tech9.net, riel@surriel.com, akpm@zip.com.au
Subject: Re: unusual scheduling performance
References: <20021118081854.GJ23425@holomorphy.com> <705474709.1037608454@[10.10.2.3]> <20021118165316.GK23425@holomorphy.com> <3DD92914.1060301@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Nov 2002 18:16:50.0830 (UTC) FILETIME=[AA4DFAE0:01C28F2E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> 
> ...
>      rwsem_down_write_failed:           133    133

Possible culprit.

Please stick a dump_stack() in rwsem_down_write_failed(), and add the below.
Suggest you stick with 2.5.47 to diagnose this.  The loss of kksymoops
is a pain.


 fs/eventpoll.c |    2 ++
 1 files changed, 2 insertions(+)

--- 25/fs/eventpoll.c~hey	Mon Nov 18 10:13:40 2002
+++ 25-akpm/fs/eventpoll.c	Mon Nov 18 10:14:01 2002
@@ -328,6 +328,8 @@ void eventpoll_release(struct file *file
 	if (list_empty(lsthead))
 		return;
 
+	printk("hey!\n");
+
 	/*
 	 * We don't want to get "file->f_ep_lock" because it is not
 	 * necessary. It is not necessary because we're in the "struct file"

_
