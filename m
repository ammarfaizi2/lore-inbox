Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbVL0KZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbVL0KZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 05:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbVL0KZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 05:25:28 -0500
Received: from gate.crashing.org ([63.228.1.57]:56533 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932286AbVL0KZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 05:25:27 -0500
Subject: Re: Problem due to removing ppc64 rtc.c?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sripathi Kodi <sripathik@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0512271505030.3537@sripathi.in.ibm.com>
References: <Pine.LNX.4.63.0512271505030.3537@sripathi.in.ibm.com>
Content-Type: text/plain
Date: Tue, 27 Dec 2005 21:25:16 +1100
Message-Id: <1135679117.4780.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-27 at 15:45 +0530, Sripathi Kodi wrote:

> 
> Before your changes,  rtc_ioctl was implemented in the PPC  specific rtc.c and
> it used  to call ppc_md.get_rtc_time  for RTC_RD_TIME,  which I think  used to
> end  up  in  rtas_get_rtc_time.  After  your changes,  time  is  now  read  in
> rtc_get_rtc_time using CMOS_READ calls, which apparently is resulting in wrong
> values being  read. I changed  rtc_do_ioctl to make it  call rtas_get_rtc_time
> for RTC_RD_TIME call and the problem went away.
> 
> Have I  missed something or  does this  need fixing? Do  we really need  a PPC
> specific rtc_ioctl call that calls into rtas_get_rtc_time?

I think the problem is that you still have CONFIG_RTC in your .config
instead of CONFIG_GEN_RTC

Ben.


