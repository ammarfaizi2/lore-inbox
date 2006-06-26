Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWFZROZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWFZROZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 13:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWFZROZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 13:14:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60306 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751104AbWFZROX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 13:14:23 -0400
Message-ID: <44A0151D.5090400@redhat.com>
Date: Mon, 26 Jun 2006 13:10:53 -0400
From: William Cohen <wcohen@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: eranian@hpl.hp.com
CC: linux-ia64@vger.kernel.org, perfctr-devel@lists.sourceforge.net,
       perfmon@napali.hpl.hp.com, linux-kernel@vger.kernel.org,
       oprofile-list@lists.sourceforge.net
Subject: Re: [Perfctr-devel] [perfmon] 2.6.17.1 new perfmon code base, libpfm,
 pfmon available
References: <20060621142447.GA29389@frankl.hpl.hp.com> <449C598B.7070803@redhat.com> <20060623212354.GA1102@frankl.hpl.hp.com>
In-Reply-To: <20060623212354.GA1102@frankl.hpl.hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane Eranian wrote:
> Will,
> 
> On Fri, Jun 23, 2006 at 05:13:47PM -0400, William Cohen wrote:
> 
>>Hi Stephane,
>>
>>Some quick questions about the current perfmon code.
>>
>>
>>The athlon has very similar hw to the amd64 and there is now 32-bit
>>x86-64 support. Wouldn't it make sense to move perfmon_amd.c to i386
>>and have it work in the same way as perfmon_p4.c does currently for p4
>>and em64t?
>>
> 
> Does Athlon have 4 counters as well. I don't have the HW so I cannot really
> test. I suspect they are similar. If you have HW and you can test, I don't
> have a problem.

I have an Athlon machine in the office that I can test this change out 
on and send you a diff.

>>Could the 32-bit and 64-bit code be combined in a manner similar to
>>oprofile and avoid duplication between perfmon_em64t_pebs.c and
>>perfmon_p4_pebs.c?  pfm_{p4|em64}_ds_area and
>>pfm_{p4|em64t}_pebs_sample_entry have differences due to the upgrade
>>from 32 to 64 bit values.
>>
> 
> You have several issues here:
> 	- the 64-bit version has 8 more reigsters int the PEBS entry
> 	- the PEBS entry uses 32 or 64 bitfields depending on data model
> 	- the ds_area uses 32 or 64 bits depending on the data model except for the threshold value
> 
> Now remember that on on EM64T we also support 32-bit (i386) binaries. 
> With an EM64T kernel you would have the 64-bit PEBS format. With the same UUID if would satisfy
> a i386 binary and this is wrong because they would not match the definition of the PEBS entry.
> We need to keep the PEBS 32 and 64-bit format UUIDs different. At the source code level, you would
> need to ifdef __x86_64__ and __i386__ to switch struct definition and UUID. That's doable but is
> this clean?

Certainly given the differences in the pebs elements there will need to 
unique names for each. It was just a thought to factor out the similar code.

There is support to handle amd64 hardware running on 32-bit kernel. Has 
someone verified that the em64t processor generate 32-bit compatible 
entries when running in 32-bit mode? Or does it always write out 64-bit 
style PEBS entries?

>>Why isn't Intel family 0xf model 3 not supported?
>>	Model 1,2, 4, and 5 are supported.
>>	Model 3 Pentium4 isn't that different is it?
> 
> 
> I have not looked at this. I don't have a lot of P4 HW. I think that
> all family 15 uses the same PMU. Could someone confirm this?

A NC State University professor mentioned that the ommission of model 3 
was a problem because his machine were model 3. I suggested the addition 
of case for model 3 processors to get him going on that.

-Will
