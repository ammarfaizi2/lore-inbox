Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750996AbWJFM6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbWJFM6E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 08:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWJFM6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 08:58:04 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:9361 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750996AbWJFM6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 08:58:01 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: vgoyal@in.ibm.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ak@suse.de,
       horms@verge.net.au, lace@jankratochvil.net, hpa@zytor.com,
       magnus.damm@gmail.com, lwang@redhat.com, dzickus@redhat.com,
       maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
References: <20061003170032.GA30036@in.ibm.com>
	<20061003172511.GL3164@in.ibm.com>
	<20061003201340.afa7bfce.akpm@osdl.org>
	<m1vemzbe4c.fsf@ebiederm.dsl.xmission.com>
	<20061004214403.e7d9f23b.akpm@osdl.org>
	<m1ejtnb893.fsf@ebiederm.dsl.xmission.com>
	<20061004233137.97451b73.akpm@osdl.org>
	<m14pui4w7t.fsf@ebiederm.dsl.xmission.com>
	<20061005235909.75178c09.akpm@osdl.org>
Date: Fri, 06 Oct 2006 06:56:03 -0600
In-Reply-To: <20061005235909.75178c09.akpm@osdl.org> (Andrew Morton's message
	of "Thu, 5 Oct 2006 23:59:09 -0700")
Message-ID: <m1bqop38nw.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Thu, 05 Oct 2006 09:29:42 -0600
> ebiederm@xmission.com (Eric W. Biederman) wrote:
>
>> 
>> In the lazy programmer school of fixes.
>> 
>> I haven't really tested this in any configuration.
>> But reading video.S it does use variable in the bootsector.
>> It does seem to initialize the variables before use.
>> But obviously something is missed.
>> 
>> By zeroing the uninteresting parts of the bootsector just after we
>> have determined we are loaded ok.  We should ensure we are
>> always in a known state the entire time. 
>> 
>> Andrew if I am right about the cause of your video not working
>> when you set an enhanced video mode this should fix your boot
>> problem.
>> 
>> Singed-off-by: Eric Biederman <ebiederm@xmission.com>
>> 
>> diff --git a/arch/i386/boot/setup.S b/arch/i386/boot/setup.S
>> index 53903a4..246ac88 100644
>> --- a/arch/i386/boot/setup.S
>> +++ b/arch/i386/boot/setup.S
>> @@ -287,6 +287,13 @@ # Check if an old loader tries to load a
>>  loader_panic_mess: .string "Wrong loader, giving up..."
>>  
>>  loader_ok:
>> +# Zero initialize the variables we keep in the bootsector
>> +	xorw	%di, %di
>> +	xorb	%al, %al
>> +	movw	$497, %cx
>> +	rep
>> +	stosb
>> +
>>  # Get memory size (extended mem, kB)
>>  
>>  	xorl	%eax, %eax
>
> That fixed the vga=0x263 crash.

Good.  We still have to be paranoid and address HPA's missing cld issues,
But otherwise it looks like we are in good shape.

Eric


