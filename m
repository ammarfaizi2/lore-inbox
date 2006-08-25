Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbWHYRME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbWHYRME (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 13:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030214AbWHYRME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 13:12:04 -0400
Received: from brick.kernel.dk ([62.242.22.158]:30996 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1030208AbWHYRMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 13:12:02 -0400
Date: Fri, 25 Aug 2006 19:14:30 +0200
From: Jens Axboe <axboe@kernel.dk>
To: Yi Yang <yang.y.yi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vmsplice complains bad address
Message-ID: <20060825171430.GG24258@kernel.dk>
References: <44EF133D.8050102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44EF133D.8050102@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25 2006, Yi Yang wrote:
> Hi, Jens
> 
> When I tested vmsplice syscall, it always complains bad address, I don't
> understand why, does vmsplice have a special reqiurement for address
> alignment?
> 
> The following file is a test program which is extracted from your patch
> and modified in order to adapt to the latest interface. its output is:
> 
> getpagesize = 4096
> page size: 4096 bytes
> vmsplice: Bad address
> here: len = 4096, written = -1

First of all, please send code that is actually readable (eg indent it
and if your mailer writes lines (which it does), then attach it instead
of inlining).

What arch are you testing on? If x86-64, you have an error:

> //#include "splice.h"
> #if defined(__i386__)
> #define __NR_splice 313
> #define __NR_tee 315
> #define __NR_vmsplice 316
> #elif defined(__x86_64__)
> #define __NR_splice 275
> #define __NR_tee 276
> #define __NR_vmsplice 277

vmsplice is 278

-- 
Jens Axboe

