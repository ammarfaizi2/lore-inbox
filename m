Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263200AbTEMGYw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 02:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbTEMGYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 02:24:51 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:65285 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263200AbTEMGYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 02:24:51 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Use correct x86 reboot vector
Date: 12 May 2003 23:35:26 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b9q3ne$nag$1@cesium.transmeta.com>
References: <Pine.LNX.4.44.0305102043320.28287-100000@home.transmeta.com> <m1fznl74f9.fsf@frodo.biederman.org> <Pine.LNX.4.50.0305111119590.7563-100000@blue1.dev.mcafeelabs.com> <m1smrl5mbw.fsf@frodo.biederman.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <m1smrl5mbw.fsf@frodo.biederman.org>
By author:    ebiederm@xmission.com (Eric W. Biederman)
In newsgroup: linux.dev.kernel
> 
> There is some software at least that knows the difference.  I have seen short
> jumps in a couple of BIOS's.  But a reset is very different from a
> reboot.  As memory must be reinitialized etc.  So I think going to
> 0xffff0000:0xfff0 would be a very bad idea if the intent is to get a
> reliable reboot.
> 

I agree.

Jumping to 0xf000:0xfff0 is widely accepted to be a standard warm
reboot (as *should* an INIT, e.g. triplefault, be, as well -- make
sure A20 is enabled before tripping, though.)  For quite a few (most?)
BIOSes, the vector that is stored at 0xf000:0xfff0 in the running
(BIOS decompressed and shadowed) configuration is *not* the same as
the one at the RESET vector.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
