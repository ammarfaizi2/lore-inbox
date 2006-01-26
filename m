Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWAZCTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWAZCTq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 21:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWAZCTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 21:19:46 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:11224 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750715AbWAZCTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 21:19:46 -0500
Date: Thu, 26 Jan 2006 11:19:51 +0900
To: Keith Owens <kaos@sgi.com>
Cc: linux-kernel@vger.kernel.org, dev-etrax@axis.com
Subject: Re: [PATCH 3/6] C-language equivalents of include/asm-*/bitops.h
Message-ID: <20060126021951.GA9889@miraclelinux.com>
References: <20060125113206.GD18584@miraclelinux.com> <24086.1138190083@ocs3.ocs.com.au> <20060126021318.GB6648@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126021318.GB6648@miraclelinux.com>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[dropped most of cc lists]

While seeing atomic *_bit() functions in cris,
I found unnessesary local_irq_restore() call.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

--- include/asm-cris/bitops.h.orig	2006-01-26 11:13:40.000000000 +0900
+++ include/asm-cris/bitops.h	2006-01-26 11:14:20.000000000 +0900
@@ -101,7 +101,6 @@ static inline int test_and_set_bit(int n
 	retval = (mask & *adr) != 0;
 	*adr |= mask;
 	cris_atomic_restore(addr, flags);
-	local_irq_restore(flags);
 	return retval;
 }
 
