Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264007AbUDFUxw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 16:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264009AbUDFUxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 16:53:52 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:24726 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S264007AbUDFUxp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 16:53:45 -0400
Date: Tue, 6 Apr 2004 22:50:45 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Adam Nielsen <a.nielsen@optushome.com.au>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix kernel lockup in RTL-8169 gigabit ethernet driver
Message-ID: <20040406225045.A7916@electric-eye.fr.zoreil.com>
References: <406EA054.2020401@colorfullife.com> <20040404105558.2bffd4f0.malvineous@optushome.com.au> <20040404111513.A3165@electric-eye.fr.zoreil.com> <20040406075142.147a0e4c.a.nielsen@optushome.com.au> <4072E4B8.2070102@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4072E4B8.2070102@colorfullife.com>; from manfred@colorfullife.com on Tue, Apr 06, 2004 at 07:11:20PM +0200
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> :
[...]
> Thanks. The code reloads the tx ring value from memory, thus I don't 
> understand why it deadlocks.

Well...
- rtl8169_interrupt() acks all events before rtl8169_tx_interrupt() is called
- the count of descriptors handled in rtl8169_tx_interrupt() is only limited
  by the number of packets submitted for TX at the time rtl8169_tx_interrupt()
  is called

-> if there is a stream of Tx events, it is possible that Tx descriptors are
   processed before the relevant event is notified to the host by the network
   adapter.

--
Ueimor
