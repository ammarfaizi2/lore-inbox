Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWFGCBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWFGCBk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 22:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWFGCBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 22:01:40 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:19124 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750712AbWFGCBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 22:01:39 -0400
Message-ID: <44863376.5020701@sgi.com>
Date: Tue, 06 Jun 2006 19:01:26 -0700
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Balbir Singh <balbir@in.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       csturtiv@sgi.com, jamal <hadi@cyberus.ca>
Subject: taskstats interface for accounting
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balbir and Shailabh,

I finally have time to think about implementation details of CSA over
taskstats interface. I took another look at the taskstats interface
proposal and was a little bit nervous.

Do you remember i suggested to use #ifdef to cut down traffic and i
was told a generic netlink header would serve the purpose?
What i see now at Documentation/accounting/taskstats.txt saying
NETLINK_GENERIC family is used for unicast query/reply mode. The
NETLINK_GENERIC family provides great flexsibility on what to receive. 
However, CSA only uses the multicast mode to receive from kernel
whenever tasks are existing. I guess i would need to read the netlink
documentation more carefully to see whether my understanding is
correct.

Another thing i overlooked when i did the review was that taskstats
interface is designed to provide _BOTH_ per task _AND_ per thread
accounting data EVERY TIME a task exists. A thread is an aggregate
of (per-pid) tasks. Since this type of aggregation is not used in
CSA, half of data traffic would be useless. Can we add a way to
configure to not send per-thread data to the socket?

Regards,
jay
