Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268327AbUIWIn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268327AbUIWIn6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 04:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268328AbUIWIn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 04:43:58 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:53723 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S268327AbUIWIn4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 04:43:56 -0400
Date: Thu, 23 Sep 2004 14:15:02 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, suparna@in.ibm.com,
       Tom Rini <trini@kernel.crashing.org>,
       kgdb-bugreport@lists.sourceforge.net
Subject: Re: [Patch] kprobes exception notifier fix 2.6.9-rc2
Message-ID: <20040923084502.GC1291@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20040923053029.GB1291@in.ibm.com> <20040923080627.GA89752@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040923080627.GA89752@muc.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

On Thu, Sep 23, 2004 at 10:06:28AM +0200, Andi Kleen wrote:
> On Thu, Sep 23, 2004 at 11:00:29AM +0530, Prasanna S Panchamukhi wrote:
> > In order to make other debuggers use exception notifiers, kprobes 
> > notifier return values are required to be modified. This patch modifies the
> > return values of kprobes notifier return values in a clean way.
> 
> It's incompatible to x86-64. If you change anything in exception
> notifiers change both.
> 

Yes, I will make the changes to x86_64 exception notifiers as well and
send a patch to you.

> And I don't really see the sense of inverting the test: NOTIFY_OK
> for handling the exception should be as good as NOTIFY_STOP.
> 

NOTIFY_OK does not stop notifying others registered for the same event.
This was causing problems when Kprobes and KGDB co-exist and KGDB handler
would get involked, when kprobes handler would have already handled its own
breakpoint. NOTIFY_BAD will also work, but returning NOTIFY_BAD would mean 
Bad/Veto action. This patch solves the problem by returning NOTIFY_OK | NOTIFY_STOP_MASK in a clean way.

Please let me know your comments.

Thanks
Prasanna

> -Andi

-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
