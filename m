Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbTEFN7D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 09:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263729AbTEFN6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 09:58:08 -0400
Received: from [217.157.19.70] ([217.157.19.70]:4356 "EHLO jehova.dsm.dk")
	by vger.kernel.org with ESMTP id S263735AbTEFN5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 09:57:24 -0400
From: Thomas Horsten <thomas@horsten.com>
To: "David S. Miller" <davem@redhat.com>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__ defined (trivial)
Date: Tue, 6 May 2003 15:10:04 +0100
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <20030506103823.B27816@infradead.org> <20030506104956.A29357@infradead.org> <1052215397.983.25.camel@rth.ninka.net>
In-Reply-To: <1052215397.983.25.camel@rth.ninka.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305061510.04619.thomas@horsten.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 May 2003 11:03 am, David S. Miller wrote:
> On Tue, 2003-05-06 at 02:49, Christoph Hellwig wrote:
> > > In any case, if the __STRICT_ANSI__ conditional is there in types.h, it
> > > should be there in byteorder.h as well.
> >
> > I don't agree with you in principle, but as this is 2.4 it's probably
> > better to just add it.  Would you mind sending Marcelo a patch?
>
> What if one of these "used from userland anyways" headers needs
> the 64-bit swabs?
>
> This is why I'm so against this patch.

I see where you're coming from, but not being able to compile existing applications 
where they are never used but need to include e.g. cdrom.h, is IMHO even worse.

This is doubly true since this breaks between 2.4.20 and 2.4.21 and the fix only 
touches the stuff that was actually changed (i.e. corrects the added inlines).

Another way would be to always define __u64 etc. in types.h, even if
__STRICT_ANSI__ is defined, given your argument that is maybe a better 
solution (why should the conditional be in types.h header if it's not meant
for userland in the first place).

That would also solve the problem (might break something else though, but
I don't think it's very likely esp. since a duplicate typedef would normally just 
be a warning).

So, would you prefer this:

--- linux-2.4.21-rc1-orig/include/asm-i386/types.h      2002-08-03 01:39:45.000000000 +0100
+++ linux-2.4.21-rc1-ac4-th/include/asm-i386/types.h       2003-05-06 15:07:06.000000000 +0100
@@ -17,10 +17,8 @@
 typedef __signed__ int __s32;
 typedef unsigned int __u32;

-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
 typedef __signed__ long long __s64;
 typedef unsigned long long __u64;
-#endif

 /*
  * These aren't exported outside the kernel to avoid name space clashes

