Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264169AbRGBMlV>; Mon, 2 Jul 2001 08:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264279AbRGBMlL>; Mon, 2 Jul 2001 08:41:11 -0400
Received: from imladris.infradead.org ([194.205.184.45]:41476 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S264169AbRGBMk7>;
	Mon, 2 Jul 2001 08:40:59 -0400
Date: Mon, 2 Jul 2001 13:40:25 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: Keith Owens <kaos@ocs.com.au>, Adam J Richter <adam@yggdrasil.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: 2.4.6p6: dep_{bool,tristate} $CONFIG_ARCH_xxx bugs
In-Reply-To: <20010702104134.A28123@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0107021326340.13114-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell.

 >> Q> dep_arch_tristate '  AM79C961A support' CONFIG_ARM_AM79C961A \
 >> Q>		ACORN $CONFIG_NET_ETHERNET

 > Before we go and create a patch for Linus to apply...

Who's sent a patch to Linus? I haven't, and don't intend to do so.

 > ...please note that the above is totally bogus and is in fact
 > 100% wrong.

Please explain? I don't see the problem with the proposed syntax, and
presume you have noticed that it's a new statement type, not a
modification to an existing one?

 > Don't create a patch yourself. Let me know how you propose to do
 > it, and I will create the patch using the correct symbols.

OK, here's the proposal:

 1. Define new config statements that take as their parameters the
    following:

	1. The prompt text.

	2. The name of the config variable to set.

	3. The NAME of the config variable that defines the
	   required architecture.

	4. The VALUES of all other config variables this variable
	   depends on.

 2. Define the new `dep_arch_bool` statement to be the same as
    `dep_bool` if passed items 1, 2 and 4 when the config var
    named in item 3 has the value "y". When the config var named
    has any other value, it becomes `define_bool "$2" "n" instead.

 3. Define the new `dep_arch_tristate` similarly.

 > Also note that the majority of the machine-dependent symbols for
 > StrongARM platforms (of which there are around 43) start
 > CONFIG_SA1100_*, not CONFIG_ARCH_*.  Unfortunately, its far too
 > late to get around this special case (I'm not too happy that we
 > have this special case either, so don't whinge at me please).

First, why is it "far too late" as you put it? It won't be the first
time config vars have been renamed, and it's unlikely to be the last
either...

Secondly, that isn't a problem to this proposal. The reason for taking
the CONFIG_ARCH_ out of the syntax is to emphasise that it's the name
and not the value that goes in there, thus reducing the likelihood of
problems creeping in in the first place.

Best wishes from Riley.

