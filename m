Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265153AbTLHBUP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 20:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265170AbTLHBUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 20:20:15 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38407 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S265153AbTLHBUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 20:20:11 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: const versus __attribute__((const))
Date: 7 Dec 2003 17:19:46 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <br0jji$8b5$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been chasing down a bunch of warnings that have been annoying
me, and I have observed that a bunch of the byteorder functions are
defined in ways similar to:

static __inline__ __const__ __u16 ___arch__swab16(__u16 value)

With -W -Wall at least gcc 3.2.2 will issue a warning:

warning: type qualifiers ignored on function return type

... which seems to imply the __const__ is ignored.  Reading the gcc
documentation it appears the correct syntax is
__attribute__((__const__)) rather than __const__.

I have made a patch against the current tree defining
__attribute_const__ in <linux/compiler.h> and using it in the above
cases; does anyone know any reason why I should *NOT* submit this to
Linus?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
