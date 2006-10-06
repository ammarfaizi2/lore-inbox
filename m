Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932601AbWJFFmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932601AbWJFFmr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 01:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbWJFFmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 01:42:47 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:4548 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932606AbWJFFmq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 01:42:46 -0400
Date: Fri, 6 Oct 2006 07:42:22 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Madhu Saravana Sibi Govindan <ssshayagriva@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Using "Asynchronous Notifications" within an interrupt handler
In-Reply-To: <513a5e60610051753o1dd828c4i52b8ba563601694a@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0610060741040.12702@yvahk01.tjqt.qr>
References: <513a5e60610051727t7f7c7b78u62410c4b8f8502a7@mail.gmail.com>
 <513a5e60610051753o1dd828c4i52b8ba563601694a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> My question is: is it safe to use the asynchronous notification
> mechanism within an interrupt handler? I see that this call acquires a
> bunch of locks before sending the signal to the process. Would this
> cause any deadlocking situations? Or should I resort to the top and
> bottom half approach for interrupt handling and handle the
> notification in the bottom half?

It may be possible - I have an old driver for custom hardware lying 
around here, and it does this in the irq handler:

kill_fasync(&global.fasync_ptr, SIGIO, POLL_IN);



	-`J'
-- 
