Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbTLaLRG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 06:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263221AbTLaLRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 06:17:05 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:52199 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S262848AbTLaLRE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 06:17:04 -0500
Date: Wed, 31 Dec 2003 06:13:16 -0500
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com
Subject: [2.6.0, pktgen] divide-by-zero
Message-ID: <20031231111316.GA10218@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Lennert Buytenhek <buytenh@gnu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When generating packets with pktgen with count=10, I get a divide-by-zero
oops in inject().

Line 273 in net/core/pktgen.c seems unsafe:
	__u64 pps = (__u32)(info->sofar * 1000) / ((__u32)(total) / 1000);

What if total < 1000 ?


cheers,
Lennert
