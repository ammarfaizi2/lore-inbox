Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbUCGBFw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 20:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbUCGBFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 20:05:51 -0500
Received: from main.gmane.org ([80.91.224.249]:64698 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261526AbUCGBFt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 20:05:49 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>
Subject: Re: Strange DMA-errors and system hang with Promise 20268
Date: Sun, 7 Mar 2004 02:05:46 +0100
Organization: Technische Universitaet Ilmenau, Germany
Message-ID: <c2dsha$psd$1@sea.gmane.org>
References: <1078602426.16591.8.camel@vega>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p508873bf.dip.t-dialin.net
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henrik Persson <nix@syndicalist.net> wrote:
> boxes. It is up and running without any problems and then suddently i
> get this in the syslog:
> Mar  6 20:29:42 eurisco kernel: hdf: dma_timer_expiry: dma status == 0x61
> And a few seconds later the system has frozen and I have to reset the

Same here:

Mar  4 01:01:06 darkside kernel: hde: dma_timer_expiry: dma status == 0x21
Mar  5 01:02:00 darkside kernel: hde: dma_timer_expiry: dma status == 0x21
Mar  6 01:10:22 darkside kernel: hde: dma_timer_expiry: dma status == 0x21

Can you somehow correlate this to start of S.M.A.R.T selftests?

I suspect it having something to do with 2.4.25 new "One last
read after the timeout" in ide-iops.c and accessing the drive
while selftest running (possibly especially short selftest).
Here, daily at 01:00 smartmontools runs smart short selftests
and a bit later the machine hangs.
Today, I disabled that job and the machine stays stable.

> error another device, but it's allways a device on the promise
> controller, fails.

Dito... PDC20269 U133TX2
CONFIG_BLK_DEV_PDC202XX_NEW=y

And until now it was always hde connected to the promise
controller.

> I've seen this behaviour with 2.4.25, 2.4.24 and 2.4.23 (I think).

My machine did run at least since:
Jan 18 09:41:21 darkside kernel: Linux version 2.4.24
...
Feb 28 01:43:48 darkside kernel: Linux version 2.4.24
Feb 28 04:58:47 darkside kernel: Linux version 2.4.25

First time the problem occured was Mar  4 01:01:06.

smartmontools last update was at Feb 14 03:04


regards,
   Mario
-- 
I heard, if you play a NT-CD backwards, you get satanic messages...
That's nothing. If you play it forwards, it installs NT.

