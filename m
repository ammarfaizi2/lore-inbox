Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbUKVLfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbUKVLfi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 06:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbUKVLfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 06:35:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12744 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261286AbUKVLdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 06:33:41 -0500
Date: Mon, 22 Nov 2004 06:33:28 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: var args in kernel?
Message-ID: <20041122113328.GQ10340@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20041109211107.GB5892@stusta.de> <1100037358.1519.6.camel@lb.loomes.de> <20041110082407.GA23090@bytesex> <1100085569.1591.6.camel@lb.loomes.de> <20041118165853.GA22216@bytesex> <419E689A.5000704@backtobasicsmgmt.com> <20041122094312.GC29305@bytesex> <20041122101646.GP10340@devserv.devel.redhat.com> <20041122102933.GG29305@bytesex> <Pine.LNX.4.53.0411221155330.31785@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0411221155330.31785@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 12:03:56PM +0100, Jan Engelhardt wrote:
> >>  What you can't do is e.g.
> >>   va_list ap;
> >>   va_start (ap, x);
> >>   bar (x, ap);
> >>   bar (x, ap);
> >>   va_end (ap);
> 
> In theory, you can't. But the way how GCC (and probably other compilers)
> implement it, you can. Because "ap" is just a pointer (which fits into a
> register, if I may add). As such, you can copy it, pass it multiple times, use
> it multiple times, and whatever you like.

That's exactly the wrong assumption.
On some Linux architectures you can, on others you can't.
Architectures where va_list is a char or void pointer include e.g.:
i386, sparc*, ppc64, ia64
Architectures where va_list is something different, usually struct { ... } va_list[1];
or something similar:
x86_64, ppc32, alpha, s390, s390x

In the latter case, you obviously can't do va_list dest = src and
if you do bar (x, ap); the content of the struct pointed by ap is changed
after the call, therefore you can't use it for other routines
(as it depends on where exactly the called function stopped with va_arg).

	Jakub
