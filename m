Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312374AbSC3DGR>; Fri, 29 Mar 2002 22:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312375AbSC3DGH>; Fri, 29 Mar 2002 22:06:07 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:47121 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S312374AbSC3DGA>;
	Fri, 29 Mar 2002 22:06:00 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: Christoph Hellwig <hch@infradead.org>, davidm@hpl.hp.com,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic show_stack facility 
In-Reply-To: Your message of "Fri, 29 Mar 2002 10:41:11 -0800."
             3CA4B547.AB359F0E@zip.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 30 Mar 2002 14:05:46 +1100
Message-ID: <1886.1017457546@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2002 10:41:11 -0800, 
Andrew Morton <akpm@zip.com.au> wrote:
>Christoph Hellwig wrote:
>> 
>> On Fri, Mar 29, 2002 at 09:36:26AM -0800, Andrew Morton wrote:
>> > Here's the diff.  Comments?
>> 
>> I don't see who having to independand declaration in the same kernel
>> image are supposed to work..
>
>It goes in lib/lib.a.  The linker will only pick up
>the default version if the architecture doesn't
>have its own dump_stack().
>
>bust_spinlocks() has worked that way for quite some time.

I have a problem with putting routines in lib.a and relying on the
linker to pull them out by default.  It does not work for routines
called from modules, modules do not include lib.a.  Remember the recent
problems with crc32.o?

bust_spinlocks() is not an issue because it is only called from built
in code.  show_stack() has been used as a debugging facility and it
could be called from a module.

