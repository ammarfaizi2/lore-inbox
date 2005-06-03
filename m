Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbVFCQzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVFCQzF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 12:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVFCQzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 12:55:04 -0400
Received: from fmr19.intel.com ([134.134.136.18]:17388 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261396AbVFCQyh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 12:54:37 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch] x86_64 specific function return probes
Date: Fri, 3 Jun 2005 09:54:18 -0700
Message-ID: <032EB457B9DBC540BFB1B7B519C78B0E07499E39@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] x86_64 specific function return probes
Thread-Index: AcVoW8Z8vEPdTCwmS9eEJ0LgmqwmCgAAFaxw
From: "Lynch, Rusty" <rusty.lynch@intel.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       "Vara Prasad" <prasadav@us.ibm.com>, "Hien Nguyen" <hien@us.ibm.com>,
       "Prasanna S Panchamukhi" <prasanna@in.ibm.com>,
       "Jim Keniston" <jkenisto@us.ibm.com>
X-OriginalArrivalTime: 03 Jun 2005 16:53:57.0947 (UTC) FILETIME=[D59440B0:01C5685C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen [mailto:ak@suse.de]
>Sent: Friday, June 03, 2005 9:46 AM
>To: Lynch, Rusty
>Cc: Andi Kleen; akpm@osdl.org; linux-kernel@vger.kernel.org; Vara
Prasad;
>Hien Nguyen; Prasanna S Panchamukhi; Jim Keniston
>Subject: Re: [patch] x86_64 specific function return probes
>
>On Fri, Jun 03, 2005 at 09:40:26AM -0700, Lynch, Rusty wrote:
>> From: Andi Kleen [mailto:ak@suse.de]
>> >On Thu, Jun 02, 2005 at 01:58:50PM -0700, Rusty Lynch wrote:
>> >> The following patch adds the x86_64 architecture specific
>> implementation
>> >
>> >[....]
>> >
>> >Thanks for the long description.
>> >
>> >but...
>> >
>> >> +struct task_struct  *arch_get_kprobe_task(void *ptr)
>> >> +{
>> >> +	return ((struct thread_info *) (((unsigned long) ptr) &
>> >> +					(~(THREAD_SIZE -1))))->task;
>> >> +}
>> >
>> >and
>> >
>> >
>> >> +	tsk = arch_get_kprobe_task(sara);
>> >
>> >
>> >This is still wrong when the code is not executing on the process
>> >stack, but on a interrupt/Exception stack. Any reason you cannot
>> >just use current here?
>> >
>> >-Andi
>>
>> Ah... you are talking about if someone registers a return probe on
>> something like an interrupt handler, right?
>
>Yes.
>
>>
>> I was under the impression that I could not always count on the
current
>> I get from interrupt context to map to the current seen by the target
>> function (that triggers the breakpoint.)  It sounds like an invalid
>> assumption lead to some extra complexity that isn't correct for all
>> cases.
>
>
>It is an invalid assumption, current works in all contexts. Except
>if your GS is broken, but that should only happen when the kernel
>is already very crashed.
>
>-Andi

Ok, let be redo this patch and take another look at the return probe
design coming down from kernel/kprobes.c

    --rusty
