Return-Path: <linux-kernel-owner+w=401wt.eu-S1423096AbWLUU6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423096AbWLUU6x (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 15:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423101AbWLUU6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 15:58:53 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:37495
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1423096AbWLUU6w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 15:58:52 -0500
Date: Thu, 21 Dec 2006 12:58:50 -0800 (PST)
Message-Id: <20061221.125850.125884789.davem@davemloft.net>
To: akpm@osdl.org
Cc: netdev@vger.kernel.org, bugme-daemon@bugzilla.kernel.org,
       uberlord@gentoo.org, linux-kernel@vger.kernel.org
Subject: Re: [Bugme-new] [Bug 7724] New: asm/types.h should define __u64 if
 isoc99
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061221124954.6bb415e9.akpm@osdl.org>
References: <200612211617.kBLGHAAg028181@fire-2.osdl.org>
	<20061221124954.6bb415e9.akpm@osdl.org>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Thu, 21 Dec 2006 12:49:54 -0800

> >            Summary: asm/types.h should define __u64 if isoc99

Platform specific bug, and has nothing to do with networking.

This problem will occur with any user visible interface definition
that uses __u64, and there are several both in and outside the
networking.

x86 and perhaps others protect the __u64 definition with:

	defined(__GNUC__) && !defined(__STRICT_ANSI__)

for whatever reason, probably to avoid "long long" or something like
that.  But even that theory makes no sense.

I do not make this protection on any of the sparc ports, even 32-bit
sparc, for example, so I find it really strange that x86 does this.
