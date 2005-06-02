Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbVFBRgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVFBRgO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 13:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVFBRgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 13:36:13 -0400
Received: from fmr18.intel.com ([134.134.136.17]:7135 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261210AbVFBRgB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 13:36:01 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch] x86_64 specific function return probes
Date: Thu, 2 Jun 2005 10:35:59 -0700
Message-ID: <032EB457B9DBC540BFB1B7B519C78B0E07499229@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] x86_64 specific function return probes
Thread-Index: AcVnmRHaQ0Yz6AuLRIe1tWLONm4TyAAADetw
From: "Lynch, Rusty" <rusty.lynch@intel.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       "Vara Prasad" <prasadav@us.ibm.com>, "Hien Nguyen" <hien@us.ibm.com>,
       "Prasanna S Panchamukhi" <prasanna@in.ibm.com>,
       "Jim Keniston" <jkenisto@us.ibm.com>
X-OriginalArrivalTime: 02 Jun 2005 17:35:38.0211 (UTC) FILETIME=[7D708330:01C56799]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Andi Kleen [mailto:ak@suse.de]
>On Thu, Jun 02, 2005 at 09:09:09AM -0700, Rusty Lynch wrote:
>> The following patch adds the x86_64 architecture specific
implementation
>> for function return probes to the 2.6.12-rc5-mm2 kernel.
>
>This is not a sufficient description for a patch. Can you describe
>how it actually works and what it does?
>

Ok, let me write up a description and I'll repost.

>> + * Called when we hit the probe point at kretprobe_trampoline
>> + */
>> +int trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
>> +{
>> +	struct task_struct *tsk;
>> +	struct kretprobe_instance *ri;
>> +	struct hlist_head *head;
>> +	struct hlist_node *node;
>> +	unsigned long *sara = (unsigned long *)regs->rsp - 1;
>> +
>> +	tsk = arch_get_kprobe_task(sara);
>
>I dont think you handle the case of the exception happening on
>a exception or interrupt stack. This is broken.
>
>-Andi
