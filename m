Return-Path: <linux-kernel-owner+w=401wt.eu-S964866AbWLTDqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWLTDqF (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 22:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbWLTDqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 22:46:05 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:34761 "EHLO
	ausmtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964861AbWLTDqC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 22:46:02 -0500
Subject: netif_poll_enable() & barrier
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain
Date: Wed, 20 Dec 2006 14:44:12 +1100
Message-Id: <1166586252.19254.118.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I stumbled accross what might be a bug on out of order architecture:

netif_poll_enable() only does a clear_bit(). However,
netif_poll_disable/enable pairs are often used as simili-spinlocks.

(netif_poll_enable() has pretty much spin_lock semantics except that it
schedules instead of looping).

Thus, shouldn't netif_poll_disable() do an smp_wmb(); before clearing
the bit to make sure that any stores done within the poll-disabled
section are properly visible to the rest of the system before clearing
the bit ?

Cheers,
Ben.


