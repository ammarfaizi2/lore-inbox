Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317141AbSGCUYi>; Wed, 3 Jul 2002 16:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317230AbSGCUYh>; Wed, 3 Jul 2002 16:24:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53514 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317141AbSGCUYg>;
	Wed, 3 Jul 2002 16:24:36 -0400
Message-ID: <3D235DA9.2B3D0E4@zip.com.au>
Date: Wed, 03 Jul 2002 13:25:13 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Teodor Iacob <Teodor.Iacob@astral.kappa.ro>
CC: linux-kernel@vger.kernel.org
Subject: Re: eth0: memory shortage
References: <20020703190931.GA13103@linux.kappa.ro>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Teodor Iacob wrote:
> 
> Hello,
> 
> I keep getting these messages (like about twice a day) in the messages:
> eth0: memory shortage
> eth0: memory shortage
> eth1: memory shortage
> eth1: memory shortage
> 
> Any idea what could be the reason behind this?
> 

It means that the ethernet driver's Rx interrupt handler was not
able to allocate a new receive buffer - there wasn't enough memory
available.

The `kswapd' kernel thread is supposed to make memory available
for interrupt context but in this case it is obviously not keeping
up.

The driver recovers from the failed allocation, so things are OK.

-
