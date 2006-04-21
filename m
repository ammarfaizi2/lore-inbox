Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWDUAxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWDUAxd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 20:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWDUAxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 20:53:33 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:33221 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S932173AbWDUAxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 20:53:33 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@sgi.com>
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
cc: Anderw Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Dean Nelson <dcn@sgi.com>, Tony Luck <tony.luck@intel.com>,
       Anath Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>, Andi Kleen <ak@suse.de>
Subject: Re: [(take 2)patch 6/7] Kprobes registers for notify page fault 
In-reply-to: Your message of "Thu, 20 Apr 2006 17:38:47 MST."
             <20060420173846.B12536@unix-os.sc.intel.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 21 Apr 2006 10:53:29 +1000
Message-ID: <19743.1145580809@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keshavamurthy Anil S (on Thu, 20 Apr 2006 17:38:47 -0700) wrote:
>On Fri, Apr 21, 2006 at 10:14:04AM +1000, Keith Owens wrote:
>> Anil S Keshavamurthy (on Thu, 20 Apr 2006 16:25:02 -0700) wrote:
>> >---
>> >@@ -654,6 +659,9 @@ static int __init init_kprobes(void)
>> > 	if (!err)
>> > 		err = register_die_notifier(&kprobe_exceptions_nb);
>> > 
>> >+	if (!err)
>> >+		err = register_page_fault_notifier(&kprobe_page_fault_nb);
>> >+
>> > 	return err;
>> > }
>> > 
>> 
>> The rest of the patches look OK, but this one does not.  init_kprobes()
>> registers the main kprobe exception handler, not the page fault
>> handler.
>I am registering for register_page_fault_notifier() and as you can see
>I am not deleting the old register_die_notifier() which is also required
>for getting notified on int3/break and single-step traps. 
>So no issues here.

Patch 7 conditionally registers a page fault handler, plus an
unregister when there are no user space probes.  Why does patch 6
unconditionally register a page fault handler?

