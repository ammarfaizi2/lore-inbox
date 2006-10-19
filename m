Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946134AbWJSSNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946134AbWJSSNh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 14:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946299AbWJSSNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 14:13:37 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:41953 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1946134AbWJSSNg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 14:13:36 -0400
Date: Thu, 19 Oct 2006 19:13:46 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
Message-ID: <20061019181346.GA5421@linux-mips.org>
References: <1161275748231-git-send-email-ralf@linux-mips.org> <4537B9FB.7050303@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4537B9FB.7050303@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 03:46:35AM +1000, Nick Piggin wrote:

> What about if you just flush the caches after write protecting all
> COW pages? Would that work? Simpler? Better performance? (I don't know)

That would require changing the order of cache flush and tlb flush.  To
keep certain architectures that require a valid translation in the TLB
the cacheflush has to be done first.  Not sure if those architectures need
a writeable mapping for dirty cachelines - I think hypersparc was one
of them.

  Ralf
