Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262796AbSKRQRk>; Mon, 18 Nov 2002 11:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262924AbSKRQRj>; Mon, 18 Nov 2002 11:17:39 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44818 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262796AbSKRQRj>; Mon, 18 Nov 2002 11:17:39 -0500
Date: Mon, 18 Nov 2002 08:24:37 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ingo Molnar <mingo@elte.hu>, Luca Barbieri <ldb@ldb.ods.org>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading fix, tid-2.5.47-A3
In-Reply-To: <1037625619.7547.6.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0211180821250.2454-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 18 Nov 2002, Alan Cox wrote:
> 
> What is the behaviour of someone setting VM_DONTCOPY on memory that was
> copy on write between a large number of processes (say an executable
> image) ?  Don't copy - but don't copy from what, from the original
> mapping or from the COW mapping of the original mapping ?

It literally means to not copy that VMA _at_all_. Basically, the mapping
simply won't show up in the child. It's kind of the mapping equivalent of
close-on-exec..

NOTE! Ingo - you might want to check with the shared-page-table people
about this, I remember us talking about discontinuing the feature because
it makes shared page tables harder to implement. Other than that it's a
trivial feature.

		Linus

