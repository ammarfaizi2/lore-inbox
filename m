Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932719AbVLSKVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932719AbVLSKVW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 05:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932722AbVLSKVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 05:21:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41425 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932719AbVLSKVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 05:21:21 -0500
Date: Mon, 19 Dec 2005 02:21:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Marc-Jano Knopp <pub_ml_lkml@marc-jano.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bug] mlockall() not working properly in 2.6.x
Message-Id: <20051219022108.307e68b8.akpm@osdl.org>
In-Reply-To: <20051218212123.GC4029@mjk.myfqdn.de>
References: <20051218212123.GC4029@mjk.myfqdn.de>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc-Jano Knopp <pub_ml_lkml@marc-jano.de> wrote:
>
> Hi!
> 
> A year ago, I wrote a small mlockall()-wrapper ("noswap") to make
> certain programs unswappable. It used to work perfectly, until I
> upgraded to kernel 2.6.x (2.6.13.1 in my case, but that shouldn't
> matter), which made the mlockall() execute without error, but also
> without any effect (the "L" in the STAT column of "ps axf" which
> indicates locked pages is missing).
> 

Question is: what kernel version did you upgrade from?

Prior to 2.4.18 the kernel would allow MCL_FUTURE to propagate into child
processes.  But that was disabled in 2.4.18 and later.  I seem to recall
that we did this because inheriting MCL_FUTURE is standards-incorrect.
