Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbVE3FMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVE3FMq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 01:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbVE3FMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 01:12:46 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:46859 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261514AbVE3FMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 01:12:44 -0400
Date: Mon, 30 May 2005 07:07:46 +0200
From: Willy Tarreau <willy@w.ods.org>
To: linux-kernel@vger.kernel.org
Cc: julien@cr0.org
Subject: Re: Linux-2.4.30-hf3
Message-ID: <20050530050746.GK18600@alpha.home.local>
References: <20050529223739.GA27341@exosec.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050529223739.GA27341@exosec.fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

Julien corrected me on the points below :

>   - a NULL dereference in serial.c found by Julien Tinnes which could lead
>     to an oops.

Could possibly be exploited by mapping the first page of a program and
watching the kernel eat the data instead of oopsing.

>   - an off-by-one in mtrr.c found by Brad Spengler and reported by J.Tinnes
>     which could lead to a panic.

This is inexact. I've checked several other archs :
 - sparc, sparc64, x86_64, alpha, mips all assume that (n) is unsigned and
   will overflow, possibly executing user-controlled code.
 - ppc and ppc64 explicitly check that (n) is < TASK_SIZE and should be safe.
 - x86 will BUG_ON((long)n < 0) (=> oops/panic).
 - others not checked.

>   - a few unchecked strcpy() in ipvs fixed in PaX which I'm not absolutely
>     sure are exploitable, but are definitely dirty and risky.

They are exploitable by anyone with enough privilege to manipulate IPVS.
Think of a user front-end for example.

Thanks,
Willy

