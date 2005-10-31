Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbVJaWnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbVJaWnK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 17:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbVJaWnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 17:43:10 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8716 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932166AbVJaWnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 17:43:08 -0500
Date: Mon, 31 Oct 2005 22:43:01 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 17/20] inflate: mark some arrays as initdata
Message-ID: <20051031224301.GF20452@flint.arm.linux.org.uk>
Mail-Followup-To: Matt Mackall <mpm@selenic.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
References: <17.196662837@selenic.com> <18.196662837@selenic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18.196662837@selenic.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 02:54:51PM -0600, Matt Mackall wrote:
> inflate: mark some arrays as INITDATA and define it in in-core callers

This breaks ARM.  Our decompressor has some rather odd requirements
due to the way we support PIC - it's PIC text with fixed data.

This means that all fixed initialised data must be "const" or initialised
by code.  This patch breaks that assertion.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
