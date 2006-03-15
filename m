Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751510AbWCOVjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbWCOVjH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 16:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbWCOVjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 16:39:07 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51415 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751510AbWCOVjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 16:39:05 -0500
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: "Kumar Gala" <galak@kernel.crashing.org>,
       "Benjamin LaHaise" <bcrl@kvack.org>, "Vivek Goyal" <vgoyal@in.ibm.com>,
       "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       "Fastboot mailing list" <fastboot@lists.osdl.org>,
       "Morton Andrew Morton" <akpm@osdl.org>, <gregkh@suse.de>
Subject: Re: [RFC][PATCH] Expanding the size of "start" and "end" field in
 "struct resource"
References: <20060315193114.GA7465@in.ibm.com>
	<20060315205306.GC25361@kvack.org>
	<46E23BE4-4353-472B-90E6-C9E7A3CFFC15@kernel.crashing.org>
	<Pine.LNX.4.61.0603151617010.4346@chaos.analogic.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 15 Mar 2006 14:37:38 -0700
In-Reply-To: <Pine.LNX.4.61.0603151617010.4346@chaos.analogic.com> (linux-os@analogic.com's
 message of "Wed, 15 Mar 2006 16:26:16 -0500")
Message-ID: <m1oe07e6e5.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"linux-os \(Dick Johnson\)" <linux-os@analogic.com> writes:
> ix86 machines need to make many operations just to increment
> or decrement a 64-bit variable, plus the operations are not
> atomic so they need to be protected. The bloat of using 64-bit
> objects in 32-bit machines is very real and a tremendous problem.
> That's why all the stuff in the kernel wasn't 'long long' to
> begin with. It's execution bloat, a.k.a., time expansion that
> is the problem.
>
> Bump a 32-bit variable, addressed from an index register:
>
>  	incl	(%ebx)
>
> Bump a 64-bit variable, addressed the same way.
>
>  	addl	$1,(%ebx)	; Need to add because inc doesn't carry
>  	adcl	$0,4(%ebx)	; Add 0 plus the carry-flag
>
> If an interrupt or context-switch comes between the two operations,
> the result is undefined, NotGood(tm).

No it is well defined it just isn't atomic.  But difference.
The thing is struct resource is accessed less often the file
offsets which are already 64bit.  Basically they are only
used during driver initialization.

So while I agree in general that 64bit values should be avoided
this is one of those places where we can productively use a
64bit value, on a 32bit machine.

To keep using 32bit kernels on the newer x86 machines at some
point this will even become a requirement as 64bit BAR will
actually have 64bit values placed in them.

Eric
