Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263328AbTDGIXx (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 04:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263330AbTDGIXx (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 04:23:53 -0400
Received: from dp.samba.org ([66.70.73.150]:51851 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263328AbTDGIXv (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 04:23:51 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Christoph Hellwig <hch@infradead.org>
Cc: Paul Mackerras <paulus@au1.ibm.com>,
       Fabrice Bellard <fabrice.bellard@free.fr>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Qemu support for PPC 
In-reply-to: Your message of "Mon, 07 Apr 2003 07:56:22 +0100."
             <20030407075622.A28354@infradead.org> 
Date: Mon, 07 Apr 2003 18:34:17 +1000
Message-Id: <20030407083526.599562C04C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030407075622.A28354@infradead.org> you write:
> On Mon, Apr 07, 2003 at 04:45:33PM +1000, Rusty Russell wrote:
> > Which simply shows that an entry in the MAINTAINERS file does not a
> > maintainer make, since your first post showed such misundestanding of
> > what personalities do,
> 
> oha,  just because I read the patch wrongly (I somehow though it added
> a binary format)

You didn't read the patch, but you said it was a bad idea.  Do you
wonder why people don't send patches through you? 8(

> I now don't understand the personalities at all?
> Remember that I wrote most of the code that's now in kernel/exec_domain.c..

Oh good: a serious question.  Why don't we drop the personality field
in struct task_struct and just use exec_domain?  Then the flags could
be unfolded from the personality number, and placed in a "flags"
element in struct exec_domain, the personality() macro would vanish,
the set_personality() macro would vanish, and things would be
generally clearer?

Perhaps there's some future aim you have in mind which conflicts with
this, or is it just a "not done yet".

> > I happens, though, whatever you may think.  It was done as a 2.4 patch
> > because there's a tighter time constraint on entry into 2.4.
> 
> Umm, quemu exists for about two weeks now.  I think you're pressing
> a bit too much.
> 
> Why is there a time constraint?  It worked for you up to now without
> this patch in mainline and you can keep patching your trees for 2.4.21,
> too.

That applies to any kernel mod, of course.  qemu is much more usable
(ie. it's sanely packagable) with this functionality, ie. it's pretty
much a requirement for increasing adoption.

> > This is not qemu specific, of course.  If you say it's not going in,
> > then I'll accept that and do the work inside qemu.  It'll be damn
> > slow, of course.
> 
> Please try it in userspace first, if it's really not doable we can abuse
> the kernel for it, but I'd prefer not doing it.  And if we need to do
> it in the kernel we should think about a sys_altroot mechanism that doesn't
> rely on the personality handling which isn't needed by qemu at all but
> rather just exposes set_fs_altroot to userspace directly.  In fact that
> sounds like a very good idea to start with.  What about hacking it up
> for 2.5? :)

I discussed this with Paul M, too.  You can do it *iff* you drop it on
exec, otherwise you get chroot-like security issues.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
