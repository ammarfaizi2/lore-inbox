Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbVHVWf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbVHVWf4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbVHVWeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:34:22 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:46218 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751469AbVHVWeU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:34:20 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       stable@kernel.org
Subject: Re: [patch 8/8] [PATCH] Module per-cpu alignment cannot always be met
Date: Mon, 22 Aug 2005 09:58:17 +0300
User-Agent: KMail/1.5.4
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, rusty@rustcorp.com.au,
       Daniel Drake <dsd@gentoo.org>, Chris Wright <chrisw@osdl.org>
References: <20050811225445.404816000@localhost.localdomain> <20050811225649.386948000@localhost.localdomain>
In-Reply-To: <20050811225649.386948000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508220958.17800.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 August 2005 01:54, Chris Wright wrote:
> -stable review patch.  If anyone has any  objections, please let us know.
> ------------------
> 
> The module code assumes noone will ever ask for a per-cpu area more than
> SMP_CACHE_BYTES aligned.  However, as these cases show, gcc asks sometimes
> asks for 32-byte alignment for the per-cpu section on a module, and if
> CONFIG_X86_L1_CACHE_SHIFT is 4, we hit that BUG_ON().  This is obviously an
> unusual combination, as there have been few reports, but better to warn
> than die.

gcc gets increasingly sadistic about alignment:

"char global_var[] = "larger than 32 bytes"; uses silly amounts of alignment even with -Os"
http://gcc.gnu.org/bugzilla/show_bug.cgi?id=22158

Please, everybody who thinks that _32_ _byte_ alignment
is outright silly, add your comments to this bugzilla entry.
--
vda

