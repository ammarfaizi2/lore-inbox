Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265127AbUD3QvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUD3QvZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 12:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265140AbUD3QvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 12:51:25 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:21708 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP id S265127AbUD3QvJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 12:51:09 -0400
Message-ID: <409283E4.5020700@watson.ibm.com>
Date: Fri, 30 Apr 2004 12:50:44 -0400
From: Shailabh <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Christoph Hellwig <hch@infradead.org>, Rik van Riel <riel@redhat.com>,
       Erik Jacobson <erikj@subway.americas.sgi.com>,
       Paul Jackson <pj@sgi.com>, chrisw@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Process Aggregates (PAGG) support for the 2.6 kernel
References: <20040430071750.A8515@infradead.org>	 <Pine.LNX.4.44.0404300853230.6976-100000@chimarrao.boston.redhat.com>	 <20040430140611.A11636@infradead.org> <1083331725.30344.371.camel@watt.suse.com>
In-Reply-To: <1083331725.30344.371.camel@watt.suse.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:
> On Fri, 2004-04-30 at 09:06, Christoph Hellwig wrote:
> 
>>On Fri, Apr 30, 2004 at 08:54:08AM -0400, Rik van Riel wrote:
>>
>>>What was the last time you looked at the CKRM source?
>>
>>the day before yesterday (the patch in SuSE's tree because there
>>doesn't seem to be any official patch on their website)

That was rectified concommitant with the lkml posting of the patches
for ckrm-E12. Please see the Implementation section of 
http://ckrm.sf.net for all the current patches.
	

>>
> 
> Somewhat unrelated, but the day before yesterday suse was at ckrm-e5,
> we're now at ckrm-e12.

Good point. One of the major changes between ckrm-e5 and ckrm-e12 is a
serious attempt at modularizing and cleaning up the internal 
interfaces which should help allay concerns about it being a big piece 
of code which has to be taken in whole.



 From the view of kernel developers considering merging CKRM into the
kernel, only two components are essential:

core
rcfs

Of course, to do anything useful, you need to have either one of

task_class: groups tasks together
socket_class: groups sockets together

the two are completely independent.

Once a particular grouping is chosen, one can further selectively 
include one or more resource controllers associated with the grouping.
i.e. for task_classes, choose one or more of cpu, mem, io, 
numtasks....; for socket_class, choose one or more of listenaq,<future 
socket based controllers, potentially including outbound network 
control)....


The same kind of flexibility that is available to kernel developers 
for integrating parts of ckrm selectively, will also remain available 
to users, even if all of CKRM is included. So a user could enable just 
task_classes and the cpu controller if s/he doesn't care about memory, 
io or any other kind of control.



-- Shailabh




