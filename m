Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbTKWGV2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 01:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263299AbTKWGV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 01:21:28 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56077 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263298AbTKWGV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 01:21:26 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: x86: SIGTRAP handling differences from 2.4 to 2.6
Date: 22 Nov 2003 22:21:17 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bppjkt$ik0$1@cesium.transmeta.com>
References: <16319.57610.204577.206796@cargo.ozlabs.ibm.com> <Pine.LNX.4.44.0311221435090.2379-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0311221435090.2379-100000@home.osdl.org>
By author:    Linus Torvalds <torvalds@osdl.org>
In newsgroup: linux.dev.kernel
> 
> Hmm.. Looking at the signal sending code, we actually do special-case 
> "init" there already - but only for the "kill -1" case. If the test for 
> "pid > 1" was moved into "group_send_sig_info()" instead, that would 
> pretty much do it, I think.
> 

Okay... I'm going to ask the obvious dumb question:

Why do we bother special-casing init at all?

It seems the only things init can't ask the kernel to do already for
it is to block SIGSTOP and SIGKILL, and it seems that if you killed
(or stopped?) init you should just get the kernel panic.

If there is anything that should be special-cased, then perhaps it
should be that init should be allowed to block/catch/ignore
SIGSTOP/SIGKILL.  Perhaps that should be a capability?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
