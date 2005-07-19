Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbVGSQqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVGSQqG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 12:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbVGSQqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 12:46:06 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:50469 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S261219AbVGSQqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 12:46:04 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.93,300,1114984800"; 
   d="scan'208"; a="12813607:sNHT50905092376"
Message-ID: <42DD2E37.3080204@fujitsu-siemens.com>
Date: Tue, 19 Jul 2005 18:45:43 +0200
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Organization: Fujitsu Siemens Computers
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: files_lock deadlock?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I apologize in advance if this is a dummy question. My web search turned 
up nothing, so I'm trying it here.

We came across the following error message:

Kernelpanic - not syncing: fs/proc/
Generic.c:521: spin_lock(fs/file_table.c:ffffffff80420280)
Already locked by fs/file_table.c/204

This shows a locking problem with the files_lock on a UP kernel with 
spinlock debugging enabled.

I noticed that files_lock is only protected with spin_lock() 
(file_list_lock(), include/linux/fs.h). Is it possible that this should 
be changed to spin_lock_irq()) or spin_lock_irqsave()? Or am I misssing 
something obvious?

Thanks
Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1        mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy
