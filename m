Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129641AbRAWJrJ>; Tue, 23 Jan 2001 04:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129703AbRAWJqu>; Tue, 23 Jan 2001 04:46:50 -0500
Received: from zeus.kernel.org ([209.10.41.242]:46556 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129641AbRAWJqj>;
	Tue, 23 Jan 2001 04:46:39 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010123085418.U21704@ookhoi.dds.nl> 
In-Reply-To: <20010123085418.U21704@ookhoi.dds.nl> 
To: ookhoi@dds.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: bootp starts before network device? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 23 Jan 2001 09:42:51 +0000
Message-ID: <21920.980242971@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ookhoi@dds.nl said:
> It says: IP-Config: No network devices available.
> a few lines below that the nic (3com 575) is detected.  Of course it
> fails to do the nfs mount. 

The kernel delays the initialisation of CardBus sockets to prevent it from 
dying in an IRQ storm as soon as it registers the interrupt. The CardBus 
sockets don't actually get initialised until later (from keventd).

Can you try changing the end of yenta_open() to call yenta_open_bh() 
directly instead of queueing via schedule_task().


--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
