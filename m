Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292429AbSBZRmv>; Tue, 26 Feb 2002 12:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292447AbSBZRmq>; Tue, 26 Feb 2002 12:42:46 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50949 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292429AbSBZRmK>;
	Tue, 26 Feb 2002 12:42:10 -0500
Message-ID: <3C7BC897.8D607D08@zip.com.au>
Date: Tue, 26 Feb 2002 09:40:39 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: christophe =?iso-8859-1?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 3c59x and cardbus
In-Reply-To: <20020226173038.GD803@ufies.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

christophe barbé wrote:
> 
> When you remove a 3c59x-based cardbus, the fonction vortex_remove_one
> is called and this function end with kfree(dev).
> 
> I was looking why enable_wol loose its value after a remove/insert cycle
> but this value is store in the private part of dev so it's free with
> dev.
> 
> The driver is not unloaded during the remove/insert cycle so it's a
> kernel space problem.

Yes, all driver state is destroyed when the hardware is removed.
Look at it the other way: if this was not done, the driver would
have a memory leak.

I guess it would be possible to retain some state across insertion
cycles, keyed off the MAC address or something.  What's it needed
for?


-
