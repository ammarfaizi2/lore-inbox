Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263697AbUESLht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263697AbUESLht (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 07:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264129AbUESLht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 07:37:49 -0400
Received: from chaos.analogic.com ([204.178.40.224]:34944 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263697AbUESLhr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 07:37:47 -0400
Date: Wed, 19 May 2004 07:39:10 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Alex Davis <alex14641@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: signal handling issue.
In-Reply-To: <20040519054507.63816.qmail@web50201.mail.yahoo.com>
Message-ID: <Pine.LNX.4.53.0405190734280.2283@chaos>
References: <20040519054507.63816.qmail@web50201.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 May 2004, Alex Davis wrote:

> There appears to be a change between linux 2.4 and 2.6
> in how signals are handled. As a test, I wrote the program
> below:
>
> #include <stdio.h>
> #include <signal.h>
> #include <setjmp.h>
>
> static jmp_buf env;
>
> static void handler(int s) {
>         printf("caught signal %d\n", s);
>         longjmp(env, 1);
> }

[SNIPPED...]

A a couple years ago they changed the rules. You can't longjmp
from a signal handler anymore. There's some other function
call with 'sig' in it, like siglongjmp or something like
that. Ahh... here it is:

/usr/include/setjmp.h:extern void siglongjmp __P ((sigjmp_buf __env, int __val))


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5557.45 BogoMips).
            Note 96.31% of all statistics are fiction.


