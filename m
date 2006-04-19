Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbWDSAaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbWDSAaj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 20:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWDSAaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 20:30:39 -0400
Received: from mail.suse.de ([195.135.220.2]:38074 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750828AbWDSAaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 20:30:39 -0400
To: Robin Holt <holt@sgi.com>
Cc: tony.luck@intel.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: ia64_do_page_fault shows 19.4% slowdown from notify_die.
References: <20060417112552.GB4929@lnx-holt.americas.sgi.com>
	<9758.1145319832@ocs3.ocs.com.au>
	<20060418221623.GB22514@lnx-holt.americas.sgi.com>
From: Andi Kleen <ak@suse.de>
Date: 19 Apr 2006 02:30:35 +0200
In-Reply-To: <20060418221623.GB22514@lnx-holt.americas.sgi.com>
Message-ID: <p73r73u2yqc.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Holt <holt@sgi.com> writes:
 
> 499 nSec/fault ia64_do_page_fault notify_die commented out.
> 501 nSec/fault ia64_do_page_fault with nobody registered.
> 533 nSec/fault notify_die in and just kprobes.
> 596 nSec/fault notify_die in and kdb, kprobes, mca, and xpc loaded.
> 
> The 596 nSec/fault is a 19.4% slowdown.  This is an upcoming OSD beta
> kernel.  It will be representative of what our typical customer will
> have loaded.

With kdb some slowdown is expected.

But just going through kprobes shouldn't be that slow. I guess
there would be optimization potential there.

Do you have finer grained profiling what is actually slow?

 
> Having the notify_page_fault() without anybody registered was only a
> 0.4% slowdown.  I am not sure that justifies the optimize away, but I
> would certainly not object.

Still sounds far too much for what is essentially a call + load + test + return
Where is that overhead comming from?  I know IA64 doesn't like indirect
calls, but there shouldn't any be there for this case.

-Andi
 
