Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293269AbSBWXlb>; Sat, 23 Feb 2002 18:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293270AbSBWXlN>; Sat, 23 Feb 2002 18:41:13 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:11276 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S293269AbSBWXlJ>;
	Sat, 23 Feb 2002 18:41:09 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] C exceptions in kernel 
In-Reply-To: Your message of "24 Feb 2002 00:07:13 BST."
             <d3n0xzre5a.fsf@lxplus049.cern.ch> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 24 Feb 2002 10:40:55 +1100
Message-ID: <927.1014507655@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Feb 2002 00:07:13 +0100, 
Jes Sorensen <jes@sunsite.dk> wrote:
>Pete Zaitcev <zaitcev@redhat.com> writes:
>
>> Personally, I have no problem handling current practices.
>> But I may see the point of the guy with the try/catch patch.
>> Do not make me to defend him though. I am trying to learn
>> is those exceptions are actually helpful. BTW, we all know
>> where they come from (all of Cutler's NT is written that way),
>> but let it not cloud our judgement.
>
>The problem here is that when using exceptions, you stop thinking
>about what is going on underneath at the low level which is really not
>what one wants in the kernel.
>
>After all, C is just and advanced assembly interface, which is exactly
>why it's such a great language ;-)

What is worse is that the exceptions patch has to use assembler to walk
the stack frames.  Exceptions are being touted as a replacement for
goto in new driver code but the sample patch only works for i386.  No
arch independent code can use exceptions until you have arch specific
code that does the equivalent of longjmp for _all_ architectures.

Doing longjmp in the kernel is _hard_, I know because I had to do it
for kdb on i386 and ia64.  The kernel does things differently from user
space and sometimes the arch maintainers decide to change the internal
register usage.  They are allowed to do this because it only affects
the kernel, but any change to kernel register usage will probably
require a corresponding change to setjmp/longjmp.

So you have arch dependent code which has to be done for all
architectures before any driver can use it and the code has to be kept
up to date by each arch maintainer.  Tell me again why the existing
mechanisms are not working and why we need exceptions?  IOW, what
existing problem justifies all the extra arch work and maintenance?

