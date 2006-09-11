Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWIKRBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWIKRBb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 13:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWIKRBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 13:01:31 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35234 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751235AbWIKRBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 13:01:30 -0400
Subject: Re: Spinlock debugging
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Bird <ajb@spheresystems.co.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200609111738.21818.ajb@spheresystems.co.uk>
References: <200609111632.27484.ajb@spheresystems.co.uk>
	 <1157992570.23085.169.camel@localhost.localdomain>
	 <200609111738.21818.ajb@spheresystems.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 11 Sep 2006 18:24:52 +0100
Message-Id: <1157995492.23085.191.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-11 am 17:38 +0100, ysgrifennodd Andrew Bird:
> Alan
> 	Yes, I have low_latency set for kernels lower than 2.6.17. I'm currently 
> testing using 2.6.15. When you mention 'write method for flow control' do you 
> mean for software XON/XOFF etc?

Yes

Basically in low_latency the following is valid


	driver receives bytes
		flush_to_ldisc
			ldisc calls driver write methods


That means if you have a shared lock for read/write you want to drop it
after you've bashed the hardware and before you flush_to_ldisc. Remember
the IRQ handler is not re-entrant so another IRQ of the same number
won't cause further I/O and out of order receives.

Alan

