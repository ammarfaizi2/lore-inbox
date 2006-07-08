Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbWGHG6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWGHG6w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 02:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbWGHG6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 02:58:52 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:4067 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964811AbWGHG6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 02:58:51 -0400
Subject: Re: [patch] spinlocks: remove 'volatile'
From: Arjan van de Ven <arjan@infradead.org>
To: trajce nedev <trajcenedev@hotmail.com>
Cc: chase.venters@clientec.com, torvalds@osdl.org, acahalan@gmail.com,
       linux-kernel@vger.kernel.org, linux-os@analogic.com, khc@pm.waw.pl,
       mingo@elte.hu, akpm@osdl.org
In-Reply-To: <BAY110-F352D1029C60425661175C9B8750@phx.gbl>
References: <BAY110-F352D1029C60425661175C9B8750@phx.gbl>
Content-Type: text/plain
Date: Sat, 08 Jul 2006 08:58:44 +0200
Message-Id: <1152341924.3120.6.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> __forceinline void Lock(volatile LONG *hPtr)
> {
> 	int iValue;
> 
> 	for (;;) {
> 		iValue = _InterlockedExchange((LPLONG)hPtr, 1);
> 		if (iValue == 0)
> 			return;
> 		while (*hPtr);
> 	}
> }
> 
> Please show me how I can write this to spinlock without using volatile.

this code is broken, at the very minimum that while (*hPtr); needs to be
"while (*hPtr) cpu_relax();" for hardware reasons.
At which point you can drop the volatile entirely without any change.



