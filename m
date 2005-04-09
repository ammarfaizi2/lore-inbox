Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVDIXbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVDIXbz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 19:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVDIXby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 19:31:54 -0400
Received: from gate.crashing.org ([63.228.1.57]:61317 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261408AbVDIXaQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 19:30:16 -0400
Subject: Re: [PATCH] Add Mac mini sound support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Per Christian Henden <perchrh@pvv.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200504091351.27430.perchrh@pvv.org>
References: <200504091351.27430.perchrh@pvv.org>
Content-Type: text/plain
Date: Sun, 10 Apr 2005 09:28:32 +1000
Message-Id: <1113089313.9568.435.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-04-09 at 13:51 +0200, Per Christian Henden wrote:
> The patch below adds sound support on the Mac Mini by making a small change to the PowerMac sound card detection code.
> 
> Details: 
> 
> Original code:
> >From sound/ppc/pmac.c  __init snd_pmac_detect(pmac_t *chip) :
> 
>  chip->model = PMAC_AWACS;
>  ...
>  if (device_is_compatible(sound, "AOAKeylargo")) {
>   ...
>   chip->model = PMAC_SNAPPER;
>   ...
>  }
> 
> The chip model is first set to AWACS, then because the check above returns true, it gets set to SNAPPER.
> Using AWACS gives perfect sound, using SNAPPER gives no sound at all, so it should use AWACS instead.
> Note that the mixer still doesn't work.
> 
> My simple patch makes the mentioned check return false on a Mac Mini.

And is not correct. It might appear to work but it is not the right
thing to do. There is no AWACS chip in there. There is a fixed function
codec controlled by a couple of GPIOs afaik. I'm working on a major
rework of the alsa driver that will include support for the mini and the
G5s.

Ben.


