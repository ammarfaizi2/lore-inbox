Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264431AbTKMVcp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 16:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264432AbTKMVcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 16:32:45 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59910 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264431AbTKMVcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 16:32:43 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 2.6 early userspace init
Date: 13 Nov 2003 13:32:34 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bp0t9i$ta3$1@cesium.transmeta.com>
References: <20031112115021.GA24875@suse.de> <1068655518.14435.37.camel@camp4.serpentine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1068655518.14435.37.camel@camp4.serpentine.com>
By author:    "Bryan O'Sullivan" <bos@serpentine.com>
In newsgroup: linux.dev.kernel
>
> On Wed, 2003-11-12 at 03:50, Michael Schroeder wrote:
> 
> > how about adding something like this to init/do_mounts.c?
> 
> It's not a bad idea, but surely you should be using the init= boot
> parameter instead of hard-coding a path.
> 
> In any case, I don't think you should expect a patch to be accepted. 
> There's not much point in further crufting up do_mounts.c in generic
> kernels during 2.6, until do_mounts moves completely out of the kernel. 
> Some people are happy enough with root=0:0, so there's not obviously a
> consensus about which stopgap measure will do for now.
> 

I think it's useful to maintain bass-ackwards compatibility with
root=, especially since if any hack is put it now, it creates new
legacy.

Looking for init, or linuxrc, inside the initramfs makes sense.  It
should *NOT* be tied to the init= option, though... consider when all
of this is pulled out of kernel space; you don't want "init=" to break
finding your RAID volumes when you're trying to find a different
"real" init binary.

Having a kinit= option (or earlyinit= or whatever, kinit seems to be
the term we have been using) would be another matter, of course.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
