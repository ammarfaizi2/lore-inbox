Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262332AbVAELYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262332AbVAELYy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 06:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262333AbVAELYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 06:24:54 -0500
Received: from mx2.elte.hu ([157.181.151.9]:4042 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262332AbVAELYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 06:24:49 -0500
Date: Wed, 5 Jan 2005 12:24:35 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Sailer <sailer@scs.ch>
Cc: Mike Hearn <mh@codeweavers.com>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, wine-devel@winehq.com,
       julliard@winehq.com
Subject: Re: ptrace single-stepping change breaks Wine
Message-ID: <20050105112435.GA15873@elte.hu>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com> <200412311413.16313.sailer@scs.ch> <1104499860.3594.5.camel@littlegreen> <200412311651.12516.sailer@scs.ch> <1104873315.3557.87.camel@littlegreen> <1104921806.7043.27.camel@kronenbourg.scs.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104921806.7043.27.camel@kronenbourg.scs.ch>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Sailer <sailer@scs.ch> wrote:

> > I'm afraid Alexandre has decided not to apply this patch (the ABI
> > personality syscall). His reasoning is as follows:
> 
> Quite understandably.

another workaround to switch off flex-mmap is to set the stack ulimit to
'unlimited':

 saturn:~> cat /proc/self/maps | tail -7
 b7db3000-b7db4000 r--p 00cfd000 03:41 3735973    /usr/lib/locale/locale-archive
 b7db4000-b7de1000 r--p 00ccc000 03:41 3735973    /usr/lib/locale/locale-archive
 b7de1000-b7de7000 r--p 00cc3000 03:41 3735973    /usr/lib/locale/locale-archive
 b7de7000-b7fe7000 r--p 00000000 03:41 3735973    /usr/lib/locale/locale-archive
 b7fe7000-b7fe8000 rw-p b7fe7000 00:00 0
 bff2c000-c0000000 rw-p bff2c000 00:00 0
 ffffe000-fffff000 ---p 00000000 00:00 0

 saturn:~> ulimit -s unlimited

 saturn:~> cat /proc/self/maps | tail -7
 42188000-4218a000 rw-p 00014000 03:41 3433982    /lib/ld-2.3.3.so
 4218c000-422aa000 r-xp 00000000 03:41 3434006    /lib/tls/libc-2.3.3.so
 422aa000-422ac000 r--p 0011d000 03:41 3434006    /lib/tls/libc-2.3.3.so
 422ac000-422ae000 rw-p 0011f000 03:41 3434006    /lib/tls/libc-2.3.3.so
 422ae000-422b0000 rw-p 422ae000 00:00 0
 bfea0000-c0000000 rw-p bfea0000 00:00 0
 ffffe000-fffff000 ---p 00000000 00:00 0

e.g. SuSE defaults to an unlimited stack so flex-mmap is effectively
disabled there.

To set the VM to legacy, for all apps, set /proc/sys/vm/legacy_va_layout
to 1.

	Ingo
