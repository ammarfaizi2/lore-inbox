Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317270AbSGCXWn>; Wed, 3 Jul 2002 19:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317271AbSGCXWm>; Wed, 3 Jul 2002 19:22:42 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:29957 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S317270AbSGCXWm>;
	Wed, 3 Jul 2002 19:22:42 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Oliver Neukum <oliver@neukum.name>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Rusty's module talk at the Kernel Summit 
In-reply-to: Your message of "Wed, 03 Jul 2002 20:46:24 +0200."
             <200207032046.24730.oliver@neukum.name> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 04 Jul 2002 09:25:02 +1000
Message-ID: <9003.1025738702@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jul 2002 20:46:24 +0200, 
Oliver Neukum <oliver@neukum.name> wrote:
>Am Mittwoch, 3. Juli 2002 19:07 schrieb Hugh Dickins:
>> On Wed, 3 Jul 2002, Adam J. Richter wrote:
>> > On Wed, 03 Jul 2002 22:27:33 +1000, Keith Owens wrote:
>> > >It does not.  There is no code to adjust any tables after discarding
>> > >kernel __init sections.  We rely on the fact that the discarded
>> > > kernel area is not reused for executable text.
>> >
>> > =09Come to think of it, if the core kernel's .text.init pages could
>> > later be vmalloc'ed for module .text section, then I think you may
>> > have found a potential kernel bug.
>>
>> No: the virtual address (which is what matters) would be different:
>> core kernel's .text.init is not in vmalloc virtual address range.
>
>Does that mean that kmalloc cannot be used to load modules?
>At least for small modules it would save TLB entries.

That is correct.  It is not safe to use kmalloc() storage for
executable code.  At least not until every architecture has been
changed to adjust their tables after freeing part of the kernel.

