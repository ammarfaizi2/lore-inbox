Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbUGLS6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUGLS6m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 14:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUGLS6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 14:58:42 -0400
Received: from chaos.analogic.com ([204.178.40.224]:13955 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261711AbUGLS6i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 14:58:38 -0400
Date: Mon, 12 Jul 2004 14:57:38 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Andi Kleen <ak@suse.de>, "R. J. Wysocki" <rjwysocki@sisk.pl>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [discuss] Re: Opteron bug
In-Reply-To: <40F2CB97.1070806@zytor.com>
Message-ID: <Pine.LNX.4.53.0407121450290.10440@chaos>
References: <200406192229.14296.rjwysocki@sisk.pl> <20040620152256.4a173a95.ak@suse.de>
 <40F2CB97.1070806@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jul 2004, H. Peter Anvin wrote:

> Andi Kleen wrote:
> >
> > The kernel never uses backwards REP prefixes.
> >
>
> Not even for memmove()?
>
> 	-hpa
>

One can't assume that 'cld' is not required because a user can
execute 'std'. Such a user, calling a kernel function in its
context, could really make a mess by executing 'std' before.

You definitely need a 'cld' inside any copy_to/from_user code.
memmove(), can copy overlapping buffers. It does this by
copying backwards when necessary. If it uses ix86 string
primatives, it executes 'std' for the backwards repeat counts.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


