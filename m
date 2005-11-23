Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbVKWQnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbVKWQnh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 11:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbVKWQnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 11:43:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:22252 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932077AbVKWQnf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 11:43:35 -0500
Message-ID: <43849C23.3040001@suse.de>
Date: Wed, 23 Nov 2005 17:43:15 +0100
From: Gerd Knorr <kraxel@suse.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com>	 <20051111103605.GC27805@elf.ucw.cz> <4374F2D5.7010106@vmware.com>	 <Pine.LNX.4.64.0511111147390.4627@g5.osdl.org>	 <4374FB89.6000304@vmware.com>	 <Pine.LNX.4.64.0511111218110.4627@g5.osdl.org>	 <20051113074241.GA29796@redhat.com>	 <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org>	 <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org> <4378A7F3.9070704@suse.de>	 <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org> <4379ECC1.20005@suse.de>	 <437A0649.7010702@suse.de> <437B5A83.8090808@suse.de>	 <438359D7.7090308@suse.de>  <p7364qjjhqx.fsf@verdi.suse.de> <1132764133.7268.51.camel@localhost.localdomain>
In-Reply-To: <1132764133.7268.51.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mer, 2005-11-23 at 12:17 -0700, Andi Kleen wrote:
>>> +	/* Paranoia */
>>> +	asm volatile ("jmp 1f\n1:");
>>> +	mb();
>> That would be totally obsolete 386 era paranoia. If anything then use 
>> a CLFLUSH (but not available on all x86s) 
> 
> If you are patching code another x86 CPU is running you must halt the
> other processors and ensure it executes a serialzing instruction before
> it enters any patched code. 

Patching in/out SMP-locking with more than one active CPU would be a 
pretty silly idea in the first place ;)

> How many kilobytes of tables do you add to the kernel to do this
> pointless stunt btw ?

  16 .smp_altinstructions 0000ae0b  c03b4000  003b4000  002b4000  2**2
                   CONTENTS, ALLOC, LOAD, READONLY, DATA
  17 .smp_altinstr_replacement 00000f6e  c03bee0b  003bee0b  002bee0b  2**0
                   CONTENTS, ALLOC, LOAD, CODE

cheers,

   Gerd

