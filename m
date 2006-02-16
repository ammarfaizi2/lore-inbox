Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWBPDaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWBPDaK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 22:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWBPDaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 22:30:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43671 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932154AbWBPDaI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 22:30:08 -0500
Date: Wed, 15 Feb 2006 19:30:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com
Subject: Re: [PATCH] Provide an interface for getting the current tick length
In-Reply-To: <17395.59762.126398.423546@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0602151926590.916@g5.osdl.org>
References: <17395.53939.795908.336324@cargo.ozlabs.ibm.com>
 <20060215173545.43a7412d.akpm@osdl.org> <17395.56186.238204.312647@cargo.ozlabs.ibm.com>
 <20060215180848.4556e501.akpm@osdl.org> <17395.59762.126398.423546@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Feb 2006, Paul Mackerras wrote:
> 
> We could share the code that computes time_adjust_step, i.e. this
> much:
> 
> 	if ((time_adjust_step = time_adjust) != 0) {

And while at it, please make it much more readable by writing it as

	time_adjust_step = time_adjust;
	if (time_adjust_step) {
		..

which is even less to type (no "!= 0", no extra parenthesis, just a 
";<nl><tab>", and you've saved a whopping three bytes of source code while 
making the end result more readable, and the compiler will generate the 
same thing.

Assignments inside tests should probably be relegated entirely to loop 
constructs, where doing them outside the test changes semantics.

			Linus
