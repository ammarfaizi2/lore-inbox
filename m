Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbTJFWGt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 18:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbTJFWGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 18:06:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45722 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261755AbTJFWGq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 18:06:46 -0400
Message-ID: <3F81E76A.10805@pobox.com>
Date: Mon, 06 Oct 2003 18:06:34 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <willy@debian.org>
CC: Mark Haverkamp <markh@osdl.org>, linux-scsi <linux-scsi@vger.kernel.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] 2.6.0 aacraid driver update
References: <1065475285.17021.79.camel@markh1.pdx.osdl.net> <3F81E34A.1040201@pobox.com> <20031006215936.GF24824@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20031006215936.GF24824@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> On Mon, Oct 06, 2003 at 05:48:58PM -0400, Jeff Garzik wrote:
> 
>>>+		/*
>>>+		 *	Yield the processor in case we are slow 
>>>+		 */
>>>+		set_current_state(TASK_UNINTERRUPTIBLE);
>>>+		schedule_timeout(1);
>>
>>hmmm... why not simply call yield() here instead?  I think yield() is 
>>closer to the intent you wish to achieve...
> 
> 
> Gods, no.  I believe it is always a bug for drivers to call yield()
> in 2.6.  What is probably meant here is cond_resched().  I'd support
> deleting the EXPORT_SYMBOL(yield) line and fixing the breakage afterwards
> as it causes lots of very subtle breakage ("Under certain circumstances,
> Linux just stops doing anything for 5 seconds").


Yes, you're right, and thank you for the correction.  I was thinking

	if (need_resched)
		schedule();

which I incorrectly translated to yield() when searching my brain for 
the 2.6 equivalent.

	Jeff



