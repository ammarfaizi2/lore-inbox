Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263273AbTDGGov (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 02:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263285AbTDGGov (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 02:44:51 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:45065 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263273AbTDGGou (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 02:44:50 -0400
Date: Mon, 7 Apr 2003 07:56:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Paul Mackerras <paulus@au1.ibm.com>,
       Fabrice Bellard <fabrice.bellard@free.fr>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Qemu support for PPC
Message-ID: <20030407075622.A28354@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Paul Mackerras <paulus@au1.ibm.com>,
	Fabrice Bellard <fabrice.bellard@free.fr>,
	linux-kernel@vger.kernel.org,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <20030407064541.4E1312C04E@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030407064541.4E1312C04E@lists.samba.org>; from rusty@rustcorp.com.au on Mon, Apr 07, 2003 at 04:45:33PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 07, 2003 at 04:45:33PM +1000, Rusty Russell wrote:
> Which simply shows that an entry in the MAINTAINERS file does not a
> maintainer make, since your first post showed such misundestanding of
> what personalities do,

oha,  just because I read the patch wrongly (I somehow though it added
a binary format)  I now don't understand the personalities at all?
Remember that I wrote most of the code that's now in kernel/exec_domain.c..

> and you've let the 2.4 and 2.5 personality
> lists get out of sync.

That's what's happening if people hack last minute changes into 2.4
instead of properly going through 2.5 and the maintainer.

> Qemu could hack it into all the stat, stat64, open, chmod, chown,
> link, rename etc. calls in the emulator, yes, but the in-kernel
> solution already exists and is far simpler.

The inkernel solution exists, and it's a bad (though valueable) hack.

> > Because stuff should go into 2.5 first.
> 
> I happens, though, whatever you may think.  It was done as a 2.4 patch
> because there's a tighter time constraint on entry into 2.4.

Umm, quemu exists for about two weeks now.  I think you're pressing
a bit too much.

Why is there a time constraint?  It worked for you up to now without
this patch in mainline and you can keep patching your trees for 2.4.21,
too.

> This is not qemu specific, of course.  If you say it's not going in,
> then I'll accept that and do the work inside qemu.  It'll be damn
> slow, of course.

Please try it in userspace first, if it's really not doable we can abuse
the kernel for it, but I'd prefer not doing it.  And if we need to do
it in the kernel we should think about a sys_altroot mechanism that doesn't
rely on the personality handling which isn't needed by qemu at all but
rather just exposes set_fs_altroot to userspace directly.  In fact that
sounds like a very good idea to start with.  What about hacking it up
for 2.5? :)

