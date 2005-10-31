Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbVJaWpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbVJaWpJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 17:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbVJaWpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 17:45:09 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9740 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932166AbVJaWpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 17:45:07 -0500
Date: Mon, 31 Oct 2005 22:45:01 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 19/20] inflate: (arch) use proper linking
Message-ID: <20051031224501.GG20452@flint.arm.linux.org.uk>
Mail-Followup-To: Matt Mackall <mpm@selenic.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
References: <19.196662837@selenic.com> <20.196662837@selenic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20.196662837@selenic.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 02:54:52PM -0600, Matt Mackall wrote:
> inflate: remove include of lib/inflate.c and use proper linking
> 
> - make free_mem_ptr vars nonstatic
> - make gunzip nonstatic
> - add gunzip prototype to new inflate.h
> - add per-arch Makefile bits
> - change inflate.c includes to inflate.h includes
> - change NO_INFLATE_MALLOC to CORE
> - compile core kernel version of inflate with -DCORE

We need to build inflate.c with -Dstatic= to disable static data, 
and text so that we get the correct binary layout for ARM PIC
decompressors.  This patch breaks that.

(Unfortunately there's no other way to get GCC to produce what we
require.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
