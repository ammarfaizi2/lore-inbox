Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317482AbSIENQs>; Thu, 5 Sep 2002 09:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317488AbSIENQs>; Thu, 5 Sep 2002 09:16:48 -0400
Received: from gra-lx1.iram.es ([150.214.224.41]:21768 "EHLO gra-lx1.iram.es")
	by vger.kernel.org with ESMTP id <S317482AbSIENQr>;
	Thu, 5 Sep 2002 09:16:47 -0400
Date: Thu, 5 Sep 2002 15:21:01 +0200 (CEST)
From: Gabriel Paubert <paubert@iram.es>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Hirokazu Takahashi <taka@valinux.co.jp>, <hpa@zytor.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: TCP Segmentation Offloading (TSO)
In-Reply-To: <20020905121717.A15540@kushida.apsleyroad.org>
Message-ID: <Pine.LNX.4.33.0209051334280.13338-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2002, Jamie Lokier wrote:

> Gabriel Paubert wrote:
> > Now that is grossly inefficient ;-) since you can save one instruction by
> > moving roll after adcl (hand edited partial patch hunk, won't apply):
>
> Yes but is it _faster_? :-)

Hard to tell, with OOO engine and decoder constraints. But once again it
is in the out of mainline code path for odd buffer addresses, not in the
loop, so its performance is not critical. Actually code size may have more
impact it ends up spanning one more cache line (or even a 16 byte block
used as fetch unit by P6 cores).

>
> I've been doing some PPro assembly lately, and I'm reminded that
> sometimes inserting instructions can reduce the timing by up to 8 cycles
> or so.

The one instruction that you can still be moved around easily is the
pointer increment. But I would never try to improve code paths that I
consider non critical.

	Gabriel.








