Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbUBREIR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 23:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbUBREHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 23:07:41 -0500
Received: from mail.timesys.com ([65.117.135.102]:57814 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S262687AbUBREGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 23:06:08 -0500
Subject: Re: [PATCH] sprintf modifiers in usr/gen_init_cpio.c
From: Pragnesh Sampat <pragnesh.sampat@timesys.com>
To: Andrew Morton <akpm@osdl.org>
Cc: bos@serpentine.com, linux-kernel@vger.kernel.org
In-Reply-To: <20040217164427.027b5643.akpm@osdl.org>
References: <1077063980.9721.22.camel@dagoban.timesys>
	 <20040217164427.027b5643.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1077077144.18192.11.camel@mail.sampatonline.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 17 Feb 2004 23:05:45 -0500
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Feb 2004 03:59:12.0984 (UTC) FILETIME=[91D18D80:01C3F5D3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-02-17 at 19:44, Andrew Morton wrote:
> Pragnesh Sampat <pragnesh.sampat@timesys.com> wrote:
> >
> > The file initramfs_data.cpio is slightly different when generated on
> > cygwin, compared to linux, which causes the kernel to panic with the
> > message "no cpio magic" (See Documentation/early-userspace/README).
> > 
> > The problem in cpio generation is due to the difference in sprintf
> > modifiers on cygwin.  The code uses "%08ZX" for strlen of a device
> > node.  printf man pages discourages "Z" and has 'z' instead.
> > Both of these are not available on cygwin sprintf (at least some
> > versions of cygwin).  The net result of all of this is that the
> > generated file literally contains "ZX" and then the strlen after that
> > and messes up that 110 offset etc.  The file is 516 bytes long on the
> > system that I tested and on linux it is 512 bytes.
> > 
> > The fix below just uses "%08X" for that field.  Any basic portable
> > modifier should be ok, I think.
> 
> ugh, OK.
> 
> We'll also need to cast the return value of strlen to the correct type.  On
> ppc64 (at least) size_t is 8 bytes and the printf will otherwise grab the wrong
> things off the stack.

[ Removed the patch ]

Yes, agree with your change, I think all 64 bit archs using
longs/pointer = 8 probably benefit from the cast.  Thanks,

-Pragnesh

