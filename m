Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265101AbSKETh6>; Tue, 5 Nov 2002 14:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265103AbSKETh6>; Tue, 5 Nov 2002 14:37:58 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:50069 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265101AbSKETh4>; Tue, 5 Nov 2002 14:37:56 -0500
Subject: Re: [PATCH] Re: time() glitch on 2.4.18: solved
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: root@chaos.analogic.com
Cc: Jim Paris <jim@jtan.com>, Willy Tarreau <willy@w.ods.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1021105134951.410A-100000@chaos.analogic.com>
References: <Pine.LNX.3.95.1021105134951.410A-100000@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Nov 2002 20:06:19 +0000
Message-Id: <1036526779.6750.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-05 at 18:57, Richard B. Johnson wrote:
> No! You will break many machines. You cannot use out_p() when
> writing the latch it __must__ be out(). the "_p" puts a write
> to another port between the two writes. That will screw up
> the internal state-machine of most PITs including AMD-SC520.

The delay is required for the PIT. Your AMD-SC520 is simply a bit wacko.
The right way to fix this is actually to switch inb_p to use udelay(8)
and to load a conservative bogomip number at boot time (we inb_p before
we compute udelay values in a few spots)

BTW if your SC520 is broken that way I just broke 2.5.4x support for it
fixing some more standards compliant platforms 8)


