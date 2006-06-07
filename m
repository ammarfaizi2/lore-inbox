Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbWFGVRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbWFGVRq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 17:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWFGVRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 17:17:46 -0400
Received: from hera.kernel.org ([140.211.167.34]:12993 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932422AbWFGVRp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 17:17:45 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: klibc - another libc?
Date: Wed, 7 Jun 2006 14:17:08 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e67fok$h25$1@terminus.zytor.com>
References: <44869397.4000907@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1149715028 17478 127.0.0.1 (7 Jun 2006 21:17:08 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 7 Jun 2006 21:17:08 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <44869397.4000907@tls.msk.ru>
By author:    Michael Tokarev <mjt@tls.msk.ru>
In newsgroup: linux.dev.kernel
>
> After several mentions of klibc recently, I want to ask a question.
> 
> I understand all the kernel-mode cleanups -- moving initialization
> from kernel to user space is a very good thing.
> 
> But the question really is: why yet another libc?  We already have
> dietlibc, uclibc, glibc, now klibc...  With modern kernel, initramfs
> will very probably contain quite some programs linked with glibc
> (modprobe/insmod, mdadm/lvm, etc; I highly suggest putting some
> minimal text editor like nvi there too, for rescue purposes) --
> so why not have an option to use whatever libc is available on
> the host platform?
> 

You have that option just fine; if you build your own initramfs you
can do whatever you want.

> In the other words, kinit/ipconfig/nfsmount/etc stuff is ok,
> no questions.  But the libc itself -- what for?

To be able to *require* it, which means it can't significantly bloat
the total size of the kernel image.  klibc binaries are *extremely*
small.  Static kinit is only a few tens of kilobytes, a lot of which
is zlib.

> And another related question: why not dietlibc which is already
> here, for quite long time?

- Bigger by an order of magnitude
- License issues
- Platform support
- Speed of portability (klibc is fully portable to a new platform in an afternoon)
- Additional issues which you can find if look through the archives of this list

	-hpa

