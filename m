Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263857AbTKXUXO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 15:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263870AbTKXUXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 15:23:14 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13840 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263857AbTKXUXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 15:23:12 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: hard links create local DoS vulnerability and security proble
Date: 24 Nov 2003 12:22:52 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bptpas$sj0$1@cesium.transmeta.com>
References: <200311241829.hAOITdKL014364@turing-police.cc.vt.edu> <xltptfhd0wk.fsf@shookay.newview.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <xltptfhd0wk.fsf@shookay.newview.com>
By author:    Mathieu Chouquet-Stringer <mathieu@newview.com>
In newsgroup: linux.dev.kernel
> 
> It's always been my understanding that you cannot have suid shell script
> because you could easily change the IFS. Am i wrong? (
> 

Well, sort of.

You can't have a setuid shell script using #!/bin/bash because
/bin/bash doesn't support it.

You *can* have a setuid Perl script using #!/usr/bin/perl because Perl
knows how to run setuid safely.

It's up to the script interpreter (if it is setuid or has an setuid
wrapper available -- Perl does it the latter way) to decide to honour
the setuid bit on a script.

If you really want to use a setuid script, you can create
a setuid /usr/bin/setuidbash which would do whatever sanitization you
felt was appropriate, and then exec bash with the appropriate
permissions.  Then put #!/usr/bin/setuidbash in your scripts.

	-hpa


-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
