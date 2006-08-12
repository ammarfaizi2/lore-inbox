Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbWHLHVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWHLHVd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 03:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWHLHVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 03:21:33 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30338 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751225AbWHLHVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 03:21:33 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Don Zickus <dzickus@redhat.com>
Cc: vgoyal@in.ibm.com, fastboot@osdl.org, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [CFT] ELF Relocatable x86 and x86_64 bzImages
References: <20060807174439.GJ16231@redhat.com>
	<m17j1kctb8.fsf@ebiederm.dsl.xmission.com>
	<20060807235727.GM16231@redhat.com>
	<m1ejvrakhq.fsf@ebiederm.dsl.xmission.com>
	<20060809200642.GD7861@redhat.com>
	<m1u04l2kaz.fsf@ebiederm.dsl.xmission.com>
	<20060810131323.GB9888@in.ibm.com>
	<m18xlw34j1.fsf@ebiederm.dsl.xmission.com>
	<20060810181825.GD14732@in.ibm.com>
	<m1irl01hex.fsf@ebiederm.dsl.xmission.com>
	<20060811212522.GF18865@redhat.com>
Date: Sat, 12 Aug 2006 01:20:29 -0600
In-Reply-To: <20060811212522.GF18865@redhat.com> (Don Zickus's message of
	"Fri, 11 Aug 2006 17:25:22 -0400")
Message-ID: <m1d5b6zagy.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don Zickus <dzickus@redhat.com> writes:

>> >> 
>> >> I'm a little disappointed but at this point it isn't a great surprise,
>> >> the code is early yet and hasn't had much testing or attention.
>> >> I wonder if I have missed something else silly.
>> >> 
>> >> As for testing, can you use plain kexec to load the kernel at a
>> >> different address?  I'm curious to know if it is something related
>> >> to the kexec on panic path or if it is just running at a different
>> >> location that is the problem.
>> >
>
> I think I have found the 'something silly'.  Here is a patch that allows
> our Dell em64t boxes to boot.  This change matches the original code.  The
> main difference that caused the problems was the setting of _PAGE_NX bit.
> This caused issues in early_io_remap().  
>
> Thanks to Larry Woodman for debugging this.  

This looks like a different one but looks fairly sane.  

Do you know what code had problems having _PAGE_NX set.
What are we doing with early_ioremap the requires execute
permissions.  It doesn't sound right that we would need
this.

Eric
