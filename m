Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbTKXGzI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 01:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263592AbTKXGzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 01:55:07 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22788 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263590AbTKXGzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 01:55:04 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: transmeta cpu code question
Date: 23 Nov 2003 22:54:54 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bps9vu$osu$1@cesium.transmeta.com>
References: <20031120020218.GJ3748@schottelius.org> <20031120232532.GA8229@mail.shareable.org> <200311210834.hAL8YOKw000394@81-2-122-30.bradfords.org.uk> <20031121084857.GA10343@mail.shareable.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20031121084857.GA10343@mail.shareable.org>
By author:    Jamie Lokier <jamie@shareable.org>
In newsgroup: linux.dev.kernel
> 
> What would be the point in that?  Surely the CMS overhead for decoding
> the rarely used x86 instructions is negligable, precisely because of
> their rarity?
> 

Pretty much.

The bulk of the time spent in CMS is in the backend scheduler, at
which time the original x86 instructions are pretty much
unrecognizable.

If there is something that one could imagine doing at the CMS level to
help on Linux, it would probably be something like making it optional
to actually perform stores beneath the stack pointer, in which case a
lot of stack frame operations could be done purely in registers.  CMS
will do them in registers already, but will be forced to perform a
store at the end of the translation anyway in order to keep exact x86
semantics.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
