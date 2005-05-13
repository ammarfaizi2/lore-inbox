Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262353AbVEMPqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbVEMPqS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 11:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbVEMPqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 11:46:18 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:24404 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S262353AbVEMPqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 11:46:01 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.93,107,1114984800"; 
   d="scan'208"; a="9296105:sNHT27321732"
Message-ID: <4284CBB5.6060609@fujitsu-siemens.com>
Date: Fri, 13 May 2005 17:45:57 +0200
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
CC: linux-kernel@vger.kernel.org, Ulrich Weigand <uweigand@de.ibm.com>
Subject: Re: Again: UML on s390 (31Bit)
References: <OFDFABA6D8.CD5E92EF-ONC1257000.0055D4CD-C1257000.00561400@de.ibm.com>
In-Reply-To: <OFDFABA6D8.CD5E92EF-ONC1257000.0055D4CD-C1257000.00561400@de.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky wrote:
>>BTW: I still can't see any loop in the kernel, that could call
>>do_signal() multiple times without returning to user in between.
>>For my understanding: do I miss something? If so, where is the loop?
> 
> 
> do_signal sets up a signal frame for the user. It returns from it
> by an svc and then another signal could be pending. It's not really
> a loop. For every signal frame you end up at least once in user space
> because we avoid creating multiple signal frames on the user stack.
Yeah. That's what I saw.

Each time when the kernel is entered again and a signal is pending,
do_signal() will be called on return to user with regs->trap setup
freshly. So, I still believe the patch doesn't have *any* effect.

Regards
	Bodo


> 
> blue skies,
>    Martin
> 
> Martin Schwidefsky
> Linux for zSeries Development & Services
> IBM Deutschland Entwicklung GmbH
> 
