Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262612AbUC2Egy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 23:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbUC2Egy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 23:36:54 -0500
Received: from ns.suse.de ([195.135.220.2]:57235 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262612AbUC2Egw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 23:36:52 -0500
Date: Mon, 29 Mar 2004 01:14:16 +0200
From: Andi Kleen <ak@suse.de>
To: "Ivan Godard" <igodard@pacbell.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel support for peer-to-peer protection models...
Message-Id: <20040329011416.591ad315.ak@suse.de>
In-Reply-To: <07b501c41502$48bd4d20$fc82c23f@pc21>
References: <048e01c413b3$3c3cae60$fc82c23f@pc21.suse.lists.linux.kernel>
	<p73y8pm951k.fsf@nielsen.suse.de>
	<07b501c41502$48bd4d20$fc82c23f@pc21>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Mar 2004 12:21:36 -0800
"Ivan Godard" <igodard@pacbell.net> wrote:

> 
> > Maybe you can give each process an different address range, but AFAIK
> > the only people who have done this before are users of non MMU
> architectures.
> > It will probably require som changes in the portable part of the code.
> > Also porting glibc's ld.so to this will be likely no-fun.
> 
> Each process gets a different range because each process gets a different
> native space. Within that space processes can use the same offsets, and
> typically will so as to avoid pointless relocation.

fork() will be hard and/or inefficient this way.

> > Overall it sounds like your architecture is not very well suited to
> > run Linux.
> 
> We believe we can adopt the Linux protection model (i.e. the 386 protection
> model) with no more work than any other port to a new architectire (ahem).

Just FYI - Linux has been ported to several architectures with similar SASOS
capabilities in hardware (IA64 or ppc64 on iseries) and they have all opted to use 
an conventional protection model.

> So long as 1) a driver has a driver-load-time defined region of working data
> space; 2) has a defined code region; 3) gets its buffer addresses etc. as

Just (1) alone is a illusion - linux drivers generally work on the shared
page pool, just like all other subsystems. 

-Andi

