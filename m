Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965069AbWEYH3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965069AbWEYH3E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 03:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965073AbWEYH3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 03:29:04 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:14940 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965069AbWEYH3B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 03:29:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=My92tdP9uJMoE7dtYi8sEi1Ss+ltlZEC5h6O+1zW2jrlod2ascKjgSTRe6S8dypi8q8KKIsNC8qIdJexTfiB6SGhzqAC1t1JAUfVlJl5FJLeuV9bxRRHU2LpmUawLe25oDRGJXAv/N/nuB5ryON6jUjeFTqPRteG6uEODytIdo0=
Message-ID: <aec7e5c30605250029jfab09e4y26556abf8f16628d@mail.gmail.com>
Date: Thu, 25 May 2006 16:29:00 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [Fastboot] [PATCH 00/03] kexec: Avoid overwriting the current pgd (V2)
Cc: "Magnus Damm" <magnus@valinux.co.jp>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <m17j4aso43.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060524044232.14219.68240.sendpatchset@cherry.local>
	 <20060524225631.GA23291@in.ibm.com>
	 <1148522948.5793.98.camel@localhost>
	 <m1k68astge.fsf@ebiederm.dsl.xmission.com>
	 <1148527837.5793.121.camel@localhost>
	 <m17j4aso43.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Magnus Damm <magnus@valinux.co.jp> writes:
>
> > Hi Eric,
> >
> > On Wed, 2006-05-24 at 20:56 -0600, Eric W. Biederman wrote:
> >>
> >> C code is much more accessible to other programmers than arch specific
> >> assembly.  The code on the control page was almost written in C, and
> >> I'm still not quite convinced that it would be wrong to do that.
> >
> > I agree with you that it is of course better to implement something in C
> > if possible compared to writing it in architecture-specific assembly.
> >
> > But I do not agree that wrapping architecture-specific assembly code in
> > C functions makes the code more understandable. I'd really like to meet
> > the kernel hacker that is aware of how x86 segmentation works but is
> > unable to read x86 assembly.
>
> For some young programmers it may be a matter of reading ability.
> For older programmers it is more likely to be a matter of reading
> speed.
>
> Regardless that is how the code is now, and how it came out of the series
> of code reviews I had to go through when I wrote it.  I had requests
> to do more in C and I never had a request to do more in assembly.
> Proving there was no sane way to write the control code page in
> C was actually difficult.

Consider this a "more assembly" request then. What about these reasons:

- C code requires a stack
You must access one page only and therefore you need to setup the
stackpointer somewhere. Requires assembly.

- We switch to a new page table, twice on x86_64
Requires assembly.

- Need to setup segment registeres and cr*
Requires assembly.

- You need to setup/clear registers before passing control
Requires assembly.

> If there is a legitimate reason to change the code that is fine.  But
> as it looked as simply a change without a good reason that is not
> fine.

We would have to duplicate the segment handling code in our xen port
otherwise. It's no biggie, it's just a matter of a few lines of code.

Also, I feel that my approach with a valid idt and gdt is more robust.

> The big problem was you did several things with a single patch,
> and that made the review much more difficult than it had to be.
>
> Having to check if you correctly modified the page tables, while also
> having to check for segmentation, and the interrupt descriptor
> transformations was distracting.

Let me know which parts you think are good and we will implement and
review them bit by bit instead then.

Thanks,

/ magnus
