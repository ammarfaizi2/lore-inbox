Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263387AbTL2Nab (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 08:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263441AbTL2Nab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 08:30:31 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:36071 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263387AbTL2Na3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 08:30:29 -0500
Date: Mon, 29 Dec 2003 19:05:18 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: lhcs-devel@lists.sourceforge.net
Subject: Re: in_atomic doesn't count local_irq_disable?
Message-ID: <20031229190518.B6746@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20031229190336.A6746@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031229190336.A6746@in.ibm.com>; from vatsa@in.ibm.com on Mon, Dec 29, 2003 at 07:03:36PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, I am running with preemption disabled ..

On Mon, Dec 29, 2003 at 07:03:36PM +0530, Srivatsa Vaddagiri wrote:
> Hi,
> 	I am getting messages like:
> 
>  "Debug: sleeping function called from invalid context at include/linux/rwsem.h:45"
>  "in_atomic: 0, irqs_disabled(): 1"
> 
> while running some (CPU Hotplug) tests against (2.6.0-test11-bk6 + the CPU hotplug patch).
> 
> This is basically because down_read was called with interrupts disabled ..
> __might_sleep was "unable" to dump the stack of callers which 
> lead to this problem ..
> 
> I put some debug code in down_read (an inline function) and found
> that down_read was actually called from do_page_fault.
> 
> do_page_fault avoids calling this down_read if we are "in_atomic()"
> Isn't in_atomic supposed to count IRQs disabled case? If not
> then shouldn't do_page_fault also check for irqs_disabled() 
> before calling down_read()?
> 
> Please let me know what I am missing here!
> 
> 
> -- 
> 
> 
> Thanks and Regards,
> Srivatsa Vaddagiri,
> Linux Technology Center,
> IBM Software Labs,
> Bangalore, INDIA - 560033

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560033
