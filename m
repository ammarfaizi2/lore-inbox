Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266434AbTBCPR1>; Mon, 3 Feb 2003 10:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266615AbTBCPR1>; Mon, 3 Feb 2003 10:17:27 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:43991 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266434AbTBCPR0> convert rfc822-to-8bit; Mon, 3 Feb 2003 10:17:26 -0500
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] vmalloc, kmalloc - 2.4.x
Date: Mon, 3 Feb 2003 16:19:16 +0100
User-Agent: KMail/1.4.3
References: <1044285222.2396.14.camel@gregs>
In-Reply-To: <1044285222.2396.14.camel@gregs>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302031619.16139.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 3. Februar 2003 16:13 schrieb Grzegorz Jaskiewicz:
> few days ago i started to port driver for our hardware in company from
> windows to linux. It is simple ISA card, which gives me interrupt each
> 8ms. So i can check it state and latch some sort of watchdog on it -
> saying that i am still running (just for security, if system hangs card
> is blocking all inputs/outputs).
>
> But anyway, i was collecting all data from the card in dynamically
> allocated memory. This gives me at least 300 * 20 bytes allocated. i
> have sigle small allocation running on each interrupt.
>
> Driver is working fine under win2k even if i collect as much as 10000
> allocations, afterwards system uses loads of processor.

It seems that you are using vmalloc in an interrupt handler.
That you must not do. To allocate memory in an interrupt handler
you have to use kmalloc() with GFP_ATOMIC as a second argument.

	HTH
		Oliver

