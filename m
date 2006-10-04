Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWJDOJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWJDOJg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 10:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWJDOJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 10:09:36 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27310 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964791AbWJDOJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 10:09:35 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: vgoyal@in.ibm.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, horms@verge.net.au, lace@jankratochvil.net,
       hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com, maneesh@in.ibm.com
Subject: Re: [PATCH 3/12] i386: Force section size to be non-zero to prevent a symbol becoming absolute
References: <20061003170032.GA30036@in.ibm.com>
	<20061003170908.GC3164@in.ibm.com> <200610041302.46672.ak@suse.de>
Date: Wed, 04 Oct 2006 08:07:36 -0600
In-Reply-To: <200610041302.46672.ak@suse.de> (Andi Kleen's message of "Wed, 4
	Oct 2006 13:02:46 +0200")
Message-ID: <m1fye4cgyf.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

>>    /* writeable */
>> @@ -64,6 +66,7 @@ SECTIONS
>>  	*(.data.nosave)
>>    	. = ALIGN(4096);
>>    	__nosave_end = .;
>> +	LONG(0)
>>    }
>>  
>>    . = ALIGN(4096);
>
> You're wasting one full page once for each of these LONG(0)s because
> of the following 4096 alignment.
>
> Isn't there some way to do this less wastefull?

So the problem is that we have sections that don't get relocated which
confuses things.  If the first that happened was that the size was
check to see if it was non-zero before we did anything I think we
wouldn't care if the linker messed up in this way.

But I may be wrong on that point.

Eric

