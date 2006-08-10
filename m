Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161056AbWHJGKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161056AbWHJGKs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 02:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161057AbWHJGKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 02:10:48 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:13737 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161056AbWHJGKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 02:10:47 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Don Zickus <dzickus@redhat.com>
Cc: fastboot@osdl.org, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       linux-kernel@vger.kernel.org, vgoyal@in.ibm.com
Subject: Re: [Fastboot] [CFT] ELF Relocatable x86 and x86_64 bzImages
References: <m1d5c92yv4.fsf@ebiederm.dsl.xmission.com>
	<m1u04x4uiv.fsf_-_@ebiederm.dsl.xmission.com>
	<20060804210826.GE16231@redhat.com>
	<m164h8p50c.fsf@ebiederm.dsl.xmission.com>
	<20060804234327.GF16231@redhat.com>
	<m1hd0rmaje.fsf@ebiederm.dsl.xmission.com>
	<20060807174439.GJ16231@redhat.com>
	<m17j1kctb8.fsf@ebiederm.dsl.xmission.com>
	<20060807235727.GM16231@redhat.com>
	<m1ejvrakhq.fsf@ebiederm.dsl.xmission.com>
	<20060809200642.GD7861@redhat.com>
Date: Thu, 10 Aug 2006 00:09:56 -0600
In-Reply-To: <20060809200642.GD7861@redhat.com> (Don Zickus's message of "Wed,
	9 Aug 2006 16:06:42 -0400")
Message-ID: <m1u04l2kaz.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don Zickus <dzickus@redhat.com> writes:

>> Looking at my build it appears bytes_out is being placed in the .bss.
>> A little odd since it is zero initialized but no big deal.
>> Could you confirm that bytes_out is being placed in the .bss section 
>> by inspecting arch/x86_64/boot/compresssed/misc.o and
>> arch/x86_64/boot_compressed/vmlinux.   "readelf -a $file" and then
>> looking up the section number and looking at the section table to see
>> which section it is was my technique.
>> 
>> If bytes_out is in the .bss for you then I suspect something is not
>> correctly zeroing the .bss.  Or else the .bss is being stomped.
>> 
>> I'm not certain how rep stosb can be done wrong but some bad pointer
>> math could have done it.
>> 
>> Eric
>
> It seems Vivek came up with a solution that works.  He sent it to me this
> morning.  We tested a bunch of machines and things seem to work now.  It
> looks like it mimics the i386 behaviour now.

Yes, this looks right.  It looks like I forgot to make this change when
the logic from i386 was adopted to x86_64, ages ago.

This is exactly the place in the code I would have expected a bug
from the symptoms you were seeing.

Thanks all I will include this in my version of the patches.

Eric
