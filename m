Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262592AbUDEOgq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 10:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbUDEOgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 10:36:46 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:18565 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S262650AbUDEOgp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 10:36:45 -0400
Date: Mon, 5 Apr 2004 16:36:32 +0200
From: Marco Roeland <marco.roeland@xs4all.nl>
To: Marco Fais <marco.fais@abbeynet.it>
Cc: Marco Roeland <marco.roeland@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at page_alloc.c:98 -- compiling with distcc
Message-ID: <20040405143631.GA1110@localhost>
References: <406D3E8F.20902@abbeynet.it> <20040402131551.GA10920@localhost> <6.0.0.22.2.20040402163334.02abe7d8@pop.localnet> <20040402150535.GA13340@localhost> <407137FD.3040407@abbeynet.it> <20040405114650.GA16079@localhost> <4071685B.20906@abbeynet.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <4071685B.20906@abbeynet.it>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday April 5th 2004 Marco Fais wrote:

> Ok, let see if we get a patch from this discussion, otherwise I'll file 
> a new bugzilla entry.

Perhaps the fact that you have *two* cards in each machine that crashes
with the 8139too driver could be important? I have two Athlon XP 2000+
with Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ that distcc
quite a lot, and never any crash. But network topology and timings might
just trigger the panic in your situation and not with others...

> [building distcc without sendfile()]
> Great! I'm going to test that right now, surely better than deploying 
> customized kernels in all servers until an "official" patch comes out.

Yeah, although that viewpoint might not be very popular on this mailing
list. ;-) By the way the patch looks quite alright and applies (with
an offset) to 2.6.5 as well. If you build 8139too modular, you might
even make two modules, a modified one with the reduced advertised
capabilities (so that the kernel assumes the card isn't zero-copy
capable) under another name perhaps like 8139too-nosendfile, and the
standard one. You can than at least distribute one kernel package, and
only on the affected machines modprobe the bugfix module.

Anyway, first installing a distcc without sendfile() usages, can make
you (distcc)build patched kernels much faster in the future. ;-)
-- 
Marco Roeland
