Return-Path: <linux-kernel-owner+w=401wt.eu-S1752628AbXACBFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbXACBFf (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 20:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751839AbXACBFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 20:05:35 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:34150 "EHLO tetsuo.zabbo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752708AbXACBFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 20:05:34 -0500
In-Reply-To: <000301c72bbd$26a37b90$d634030a@amr.corp.intel.com>
References: <000301c72bbd$26a37b90$d634030a@amr.corp.intel.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0B3B0231-4AFD-4870-B96F-00AC78F80E52@oracle.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <linux-aio@kvack.org>,
       <linux-kernel@vger.kernel.org>, "'Benjamin LaHaise'" <bcrl@kvack.org>,
       <suparna@in.ibm.com>
Content-Transfer-Encoding: 7bit
From: Zach Brown <zach.brown@oracle.com>
Subject: Re: [patch] aio: streamline read events after woken up
Date: Tue, 2 Jan 2007 17:05:33 -0800
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
X-Mailer: Apple Mail (2.752.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Given the previous patch "aio: add per task aio wait event condition"
> that we properly wake up event waiting process knowing that we have
> enough events to reap, it's just plain waste of time to insert itself
> into a wait queue, and then immediately remove itself from the wait
> queue for *every* event reap iteration.

Hmm, I dunno.  It seems like we're still left with a pretty silly loop.

Would it be reasonable to have a loop that copied multiple events at  
a time?  We could use some __copy_to_user_inatomic(), it didn't exist  
when this stuff was first written.

- z
