Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbTJNUoO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 16:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbTJNUoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 16:44:14 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60171 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261869AbTJNUoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 16:44:08 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [x86] Access off the bottom of stack causes a segfault?
Date: 14 Oct 2003 13:43:37 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bmhn5p$oba$1@cesium.transmeta.com>
References: <Pine.LNX.4.44.0310141320020.3869-100000@nondot.org> <Pine.LNX.4.53.0310141510590.2211@chaos>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.53.0310141510590.2211@chaos>
By author:    "Richard B. Johnson" <root@chaos.analogic.com>
In newsgroup: linux.dev.kernel
> 
> > main:
> >         mov DWORD PTR [%ESP - 16004], %EBP    # Save EBP to stack
> 
> BAM **INTERRUPT** writes return address below stack-pointer.
> 

Since we're in user mode, interrupts don't matter, but signals have
the same effect.

Note that this is a matter of the ABI definition.  For example, in the
x86-64 ABI there is a designated region of well-defined size below
%rsp called the redzone, which signals aren't allowed to clobber.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
