Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932474AbWAKT5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbWAKT5V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 14:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbWAKT5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 14:57:21 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:13001
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932474AbWAKT5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 14:57:21 -0500
Date: Wed, 11 Jan 2006 11:56:29 -0800 (PST)
Message-Id: <20060111.115629.65083150.davem@davemloft.net>
To: schwidefsky@de.ibm.com
Cc: bunk@stusta.de, linux390@de.ibm.com, linux-390@vm.marist.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] arch/s390/Makefile: remove -finline-limit=10000
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1136971280.6147.20.camel@localhost.localdomain>
References: <20060110205704.GD3911@stusta.de>
	<1136971280.6147.20.camel@localhost.localdomain>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Wed, 11 Jan 2006 10:21:20 +0100

> On Tue, 2006-01-10 at 21:57 +0100, Adrian Bunk wrote:
> > -finline-limit might have been required for older compilers, but 
> > nowadays it does no longer make sense.
> 
> I didn't check the effects of reverting to the default inline-limit, did
> you find any negative impacts? I'm thinking about the critical code
> paths e.g. minor faults. There better should not be an additional
> function call that would have been inlined with the bigger inline limit,
> since function calls are quite expensive on s390.

You need to be careful now that -Os is specified by default
in 2.6.x

The inline-limit GCC option is interpreted differently in
gcc-4.x when -Os is given vs. when it is not.

On Sparc this caused schedule() to be inlined (I'm not kidding)
which caused all kinds of troubles.

I highly recommed you don't specify it and let the compiler
make the decisions, and add inline tags to places where you
think it is hyper-important for inlining to occur.
