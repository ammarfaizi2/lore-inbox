Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268340AbRGXRFM>; Tue, 24 Jul 2001 13:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268362AbRGXRFC>; Tue, 24 Jul 2001 13:05:02 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:43789 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S268340AbRGXREx>;
	Tue, 24 Jul 2001 13:04:53 -0400
Message-Id: <200107232253.CAA07056@mops.inr.ac.ru>
Subject: Re: tcp_write_space
To: deca@netvision.net.il
Date: Tue, 24 Jul 2001 02:53:10 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01072312370200.19071@aviv_linuxddd> from "Aviv Greenberg" at Jul 23, 1 01:45:00 pm
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello!

> Why isn't the sk->callback_lock aquired in the tcp_write_space
> callback ??
> 
> Is this intentional ?

Yes, this lock is not required in this case because tcp_write_space()
is called only from under socket lock, which is stronger than callback_lock.
This is true _only_ for TCP sockets.

Alexey
