Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262945AbTESVI7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 17:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262946AbTESVI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 17:08:59 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60425 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262945AbTESVIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 17:08:54 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Recent changes to sysctl.h breaks glibc
Date: 19 May 2003 14:21:32 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <babhss$sci$1@cesium.transmeta.com>
References: <1053289316.10127.41.camel@nosferatu.lan> <3EC9212C.4070303@blue-labs.org> <20030519183424.E7061@devserv.devel.redhat.com> <1053373410.7862.60.camel@nosferatu.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1053373410.7862.60.camel@nosferatu.lan>
By author:    Martin Schlemmer <azarah@gentoo.org>
In newsgroup: linux.dev.kernel
> 
> I think on the one hand the question is also ... how far will a
> developer of one distro go to help another.  I cannot say that I
> have had much success in the past to get a response from one of the
> 'big guys' to help me/us (the 'small guys') =3D)
> 
> Might it be a good thing to start an official project for this ?
> 

Yes.  It's sometimes referenced as the "ABI header" project, and is
the only way out of this mess.

"Copy and cleanup" is not maintainable, so then you end up having to
make changes in multiple places every time.  Not a good idea.  Thus,
what we need is ABI headers, which can be included from both kernel
and userspace.  This is different from the current situation, in which
userspace includes random kernel headers and hopes someone has put
#ifdef __KERNEL__ in all the right places.  Not sustainable.

Constructing those ABI headers is going to take a lot of effort.  For
example <linux/abi/types.h> shouldn't export dev_t, it should export
something like __kernel_dev64_t, and the structures that uses these
things should be adjusted accordingly.  The user-space library might
include this from <sys/types.h> and have typedef __kernel_dev64_t
dev_t, but that's user-space policy.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
