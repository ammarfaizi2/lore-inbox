Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbVGYF2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVGYF2k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 01:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbVGYF2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 01:28:31 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:5798
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261692AbVGYF2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 01:28:30 -0400
Date: Sun, 24 Jul 2005 22:28:43 -0700 (PDT)
Message-Id: <20050724.222843.19810915.davem@davemloft.net>
To: vda@ilport.com.ua
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org, jgarzik@pobox.com
Subject: Re: 2.6.11-rc5 and 2.6.12: cannot transmit anything
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200507242125.36082.vda@ilport.com.ua>
References: <200507242125.36082.vda@ilport.com.ua>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Probably your link is never coming up.  We won't send packets
over the wire unless the device is in the link-up state.

However, if ->dequeue() is returning NULL, there really aren't
any packets in the device queue to be sent.

If you want, add more tracing to pfifo_fast_dequeue() since
that's almost certainly which queueing discipline is hooked
up to your VIA Rhine device as it's the default.
