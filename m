Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbTFJRcT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 13:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263749AbTFJRcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 13:32:19 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:22434 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263743AbTFJRcM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 13:32:12 -0400
Date: Tue, 10 Jun 2003 10:34:31 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70 (virgin) hangs running SDET
Message-ID: <12190000.1055266471@flay>
In-Reply-To: <5930000.1055254447@[10.10.2.4]>
References: <60380000.1055188542@flay> <20030609140834.11ad0d63.akpm@digeo.com> <5930000.1055254447@[10.10.2.4]>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The ps instance which is spinning on kernel_flag in proc_root_lookup is
>> what's holding things up.
>> 
>> Or is it spinning in proc_lookup() or proc_pid_lookup()?  I have a vague
>> feeling that I've seen these traces miss out the innermost stack slot...
>> 
>> Suggest:
>> 
>> a) Use CONFIG_SPINLINE, get a new sysrq-T trace
>> 
>> b) Enable spinlock debugging
>> 
>> c) Try disabling the sched_balance_exec() code.
> 
> 
> Moving that locking around as discussed last night didn't fix it. 
> It did last 2.5 cycles of repeated SDET this time instead of 0.5,
> but that might just be coincidence, as the hang looks the same. Got
> a better backtrace out of her this time though ....
> 
> Want me to back out the patch I was pointing fingers at? Or I can
> carry on with the path you suggested above if you think it'll help ...

OK, well backing out dcache_lock-vs-tasklist_lock-take-3.patch does
indeed seem to fix the problem. It's done 5.5 whole cycles now, and
still going strong. 

M.

