Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265492AbUH3XtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265492AbUH3XtE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 19:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265517AbUH3XtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 19:49:04 -0400
Received: from mail6.speakeasy.net ([216.254.0.206]:23963 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP id S265492AbUH3XtB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 19:49:01 -0400
Date: Mon, 30 Aug 2004 16:48:57 -0700
Message-Id: <200408302348.i7UNmvw0006978@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: =?iso-8859-1?q?Albert=20Herranz?= <albert_herranz@yahoo.es>
X-Fcc: ~/Mail/linus
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm1 ppc build broken
In-Reply-To: Albert Herranz's message of  Tuesday, 31 August 2004 01:41:43 +0200 <20040830234143.64800.qmail@web52302.mail.yahoo.com>
X-Antipastobozoticataclysm: When George Bush projectile vomits antipasto on the Japanese.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem seems to be related to the addition of the
> linux/resource.h header file in
> include/asm-generic/siginfo.h for the new _rusage
> field.

This is creating a circularity on ppc that others don't have apparently.

>   CC      arch/ppc/kernel/asm-offsets.s
> In file included from include/linux/mm.h:4,

>                  from include/asm/io.h:7,
>                  from include/linux/timex.h:61,

This #include link here is the issue.  Vanilla linux/timex.h does not have
the #include <asm/io.h>.  On other machines, <asm/io.h> does not include
<linux/mm.h>, so you don't get into the problem with sched.h.
