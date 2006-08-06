Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751490AbWHFCi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbWHFCi1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 22:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWHFCi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 22:38:27 -0400
Received: from colin.muc.de ([193.149.48.1]:44806 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1751493AbWHFCi0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 22:38:26 -0400
Date: 6 Aug 2006 04:38:24 +0200
Date: Sun, 6 Aug 2006 04:38:24 +0200
From: Andi Kleen <ak@muc.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Turn rdmsr, rdtsc into inline functions, clarify names
Message-ID: <20060806023824.GA41762@muc.de>
References: <1154771262.28257.38.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154771262.28257.38.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2006 at 07:47:41PM +1000, Rusty Russell wrote:
> [Andi, sorry, x86_64 part untested, so sending straight to you]
> 
> rdmsr and rdtsc are macros, altering their arguments directly.  An
> inline function would offer decent typechecking, but needs to take
> pointer args.  The comment notes that gcc produces better code with

I think I prefer the macro variant actually. Sorry. It just looks
better without the &s.

We don't care very much about the code quality here because
rdmsr/wrmsr are always very slow in microcode anyways and tend
to synchronize the CPUs.

If you feel a need to clean up I would suggest you convert more
users over to the ll variants which take a single 64bit value
instead of two 32bit ones.

-Andi
