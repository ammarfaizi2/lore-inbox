Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVFCQFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVFCQFW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 12:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVFCQFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 12:05:21 -0400
Received: from fmr18.intel.com ([134.134.136.17]:28370 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261243AbVFCQFN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 12:05:13 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch] x86_64 specific function return probes
Date: Fri, 3 Jun 2005 09:05:08 -0700
Message-ID: <032EB457B9DBC540BFB1B7B519C78B0E07499D24@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] x86_64 specific function return probes
Thread-Index: AcVn+juTkFARLSBBTmOpt/cVJ6/9HgAWwfqw
From: "Lynch, Rusty" <rusty.lynch@intel.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <ak@suse.de>, <linux-kernel@vger.kernel.org>, <prasadav@us.ibm.com>,
       <hien@us.ibm.com>, <prasanna@in.ibm.com>, <jkenisto@us.ibm.com>
X-OriginalArrivalTime: 03 Jun 2005 16:04:48.0127 (UTC) FILETIME=[F75970F0:01C56855]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton [mailto:akpm@osdl.org]
>"Lynch, Rusty" <rusty.lynch@intel.com> wrote:
>>
>>
>> From: Andi Kleen [mailto:ak@suse.de]
>> >On Thu, Jun 02, 2005 at 09:09:09AM -0700, Rusty Lynch wrote:
>> >> The following patch adds the x86_64 architecture specific
>> implementation
>> >> for function return probes to the 2.6.12-rc5-mm2 kernel.
>> >
>> >This is not a sufficient description for a patch. Can you describe
>> >how it actually works and what it does?
>> >
>>
>> Ok, let me write up a description and I'll repost.
>
>You did, but:
>
>> >> + * Called when we hit the probe point at kretprobe_trampoline
>> >> + */
>> >> +int trampoline_probe_handler(struct kprobe *p, struct pt_regs
*regs)
>> >> +{
>> >> +	struct task_struct *tsk;
>> >> +	struct kretprobe_instance *ri;
>> >> +	struct hlist_head *head;
>> >> +	struct hlist_node *node;
>> >> +	unsigned long *sara = (unsigned long *)regs->rsp - 1;
>> >> +
>> >> +	tsk = arch_get_kprobe_task(sara);
>> >
>> >I dont think you handle the case of the exception happening on
>> >a exception or interrupt stack. This is broken.
>
>What about this problem?

I miss understood what Andi was pointing out, and thought the additional
description would clear things up.  Now I get what he is pointing out
and will reply to Andi's second email.

    --rusty
