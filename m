Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVFCQk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVFCQk3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 12:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVFCQk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 12:40:29 -0400
Received: from fmr18.intel.com ([134.134.136.17]:58849 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261385AbVFCQkU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 12:40:20 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch] x86_64 specific function return probes
Date: Fri, 3 Jun 2005 09:40:26 -0700
Message-ID: <032EB457B9DBC540BFB1B7B519C78B0E07499DE4@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] x86_64 specific function return probes
Thread-Index: AcVoUz6j77AUIJVvQIiP3MRLFCXtFAAAttNw
From: "Lynch, Rusty" <rusty.lynch@intel.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       "Vara Prasad" <prasadav@us.ibm.com>, "Hien Nguyen" <hien@us.ibm.com>,
       "Prasanna S Panchamukhi" <prasanna@in.ibm.com>,
       "Jim Keniston" <jkenisto@us.ibm.com>
X-OriginalArrivalTime: 03 Jun 2005 16:40:06.0254 (UTC) FILETIME=[E5D9F8E0:01C5685A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen [mailto:ak@suse.de]
>On Thu, Jun 02, 2005 at 01:58:50PM -0700, Rusty Lynch wrote:
>> The following patch adds the x86_64 architecture specific
implementation
>
>[....]
>
>Thanks for the long description.
>
>but...
>
>> +struct task_struct  *arch_get_kprobe_task(void *ptr)
>> +{
>> +	return ((struct thread_info *) (((unsigned long) ptr) &
>> +					(~(THREAD_SIZE -1))))->task;
>> +}
>
>and
>
>
>> +	tsk = arch_get_kprobe_task(sara);
>
>
>This is still wrong when the code is not executing on the process
>stack, but on a interrupt/Exception stack. Any reason you cannot
>just use current here?
>
>-Andi

Ah... you are talking about if someone registers a return probe on
something like an interrupt handler, right? 

I was under the impression that I could not always count on the current
I get from interrupt context to map to the current seen by the target
function (that triggers the breakpoint.)  It sounds like an invalid
assumption lead to some extra complexity that isn't correct for all
cases.

    --rusty



