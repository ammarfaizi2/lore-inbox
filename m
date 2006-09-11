Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWIKQM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWIKQM6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 12:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWIKQM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 12:12:57 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40838 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932246AbWIKQM5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 12:12:57 -0400
Subject: Re: Spinlock debugging
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Andrew Bird (Sphere Systems)" <ajb@spheresystems.co.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200609111632.27484.ajb@spheresystems.co.uk>
References: <200609111632.27484.ajb@spheresystems.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 11 Sep 2006 17:36:10 +0100
Message-Id: <1157992570.23085.169.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-11 am 16:32 +0100, ysgrifennodd Andrew Bird (Sphere
Systems):
> will be lost. But if I comment out the line that tells the tty layer that 
> it's implemented, I end up with a BUG - spinlock recursion. Can anybody tell 
> me how to interpret the output?

Looks like your driver calls flush_to_ldisc with low latency set and
then can't handle the flush_to_ldisc causing n_tty to call back into the
write method for flow control.

Alan

