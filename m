Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752115AbWCOQCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115AbWCOQCG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 11:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752116AbWCOQCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 11:02:06 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:25872 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1752115AbWCOQCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 11:02:05 -0500
Message-ID: <44183A58.10506@vmware.com>
Date: Wed, 15 Mar 2006 08:01:28 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 5/24] i386 Vmi code patching
References: <200603131802.k2DI2nv8005665@zach-dev.vmware.com> <20060315100210.GU12807@sorel.sous-sol.org>
In-Reply-To: <20060315100210.GU12807@sorel.sous-sol.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Zachary Amsden (zach@vmware.com) wrote:
>   
>> +static void fixup_translation(struct vmi_annotation *a)
>> +{
>> +	unsigned char *c, *start, *end;
>> +	int left;
>> +
>> +	memcpy(a->nativeEIP, a->translationEIP, a->translation_size);
>> +	start = a->nativeEIP;
>> +	end = a->nativeEIP + a->translation_size;
>> +
>> +	for (c = start; c < end;) {
>> +		switch(*c) {
>> +			case MNEM_CALL_NEAR:
>>
>>     
> Why these restrictions?  How do you do int $0x82, for example?
>   

We don't.  This is the minimal set of instructions that are emitted 
during the annotation.  The instruction sequence is only sufficient to 
call out to the hypervisor ROM.

What we want to do next is to allow the hypervisor itself to do this 
code fixup - in effect, relinking in the local translations, which in 
many cases would then convert to int $0x82 for inline Xen calls.

Zach
