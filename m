Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbTKXNTi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 08:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbTKXNTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 08:19:38 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:24761 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263462AbTKXNTh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 08:19:37 -0500
Date: Mon, 24 Nov 2003 13:19:35 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: transmeta cpu code question
Message-ID: <20031124131934.GA30489@mail.shareable.org>
References: <20031120020218.GJ3748@schottelius.org> <20031120232532.GA8229@mail.shareable.org> <200311210834.hAL8YOKw000394@81-2-122-30.bradfords.org.uk> <20031121084857.GA10343@mail.shareable.org> <bps9vu$osu$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bps9vu$osu$1@cesium.transmeta.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> If there is something that one could imagine doing at the CMS level to
> help on Linux, it would probably be something like making it optional
> to actually perform stores beneath the stack pointer, in which case a
> lot of stack frame operations could be done purely in registers.  CMS
> will do them in registers already, but will be forced to perform a
> store at the end of the translation anyway in order to keep exact x86
> semantics.

You couldn't enable that globally, because it'd break userspace
programs which write below the stack safely using sigaltstack(), or
which even use the stack pointer as a general purpose register (I've
coded games which do that in tight rendering loops), or during funky
thunking code.

It sounds like a good thing to add as a per-task feature though.

-- Jamie
