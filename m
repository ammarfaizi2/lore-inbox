Return-Path: <linux-kernel-owner+w=401wt.eu-S1752708AbXACBXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708AbXACBXh (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 20:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752731AbXACBXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 20:23:37 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:34720 "EHLO tetsuo.zabbo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752708AbXACBXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 20:23:36 -0500
In-Reply-To: <000d01c72ed4$dbc78920$ff0da8c0@amr.corp.intel.com>
References: <000d01c72ed4$dbc78920$ff0da8c0@amr.corp.intel.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <122AE2A2-3807-42F0-AADF-7305D66CBCE5@oracle.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <linux-aio@kvack.org>,
       <linux-kernel@vger.kernel.org>, "'Benjamin LaHaise'" <bcrl@kvack.org>,
       <suparna@in.ibm.com>
Content-Transfer-Encoding: 7bit
From: Zach Brown <zach.brown@oracle.com>
Subject: Re: [patch] aio: add per task aio wait event condition
Date: Tue, 2 Jan 2007 17:23:35 -0800
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
X-Mailer: Apple Mail (2.752.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> That is not possible because when multiple tasks waiting for  
> events, they
> enter the wait queue in FIFO order, prepare_to_wait_exclusive() does
> __add_wait_queue_tail().  So first io_getevents() with min_nr of 2  
> will
> be woken up when 2 ops completes.

So switch the order of the two sleepers in the example?

The point is that there's no way to guarantee that the head of the  
wait queue will be the lowest min_nr.

I got list_add() from the add_wait_queue() still being used in  
wait_for_all_aios(), fwiw.  My mistake.

- z
