Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbVL0KtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbVL0KtR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 05:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbVL0KtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 05:49:16 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:17854 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750734AbVL0KtQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 05:49:16 -0500
Date: Tue, 27 Dec 2005 16:19:00 +0530 (IST)
From: Sripathi Kodi <sripathik@in.ibm.com>
X-X-Sender: sripathi@sripathi.in.ibm.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Sripathi Kodi <sripathik@in.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Problem due to removing ppc64 rtc.c?
In-Reply-To: <1135679117.4780.38.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.63.0512271617380.3537@sripathi.in.ibm.com>
References: <Pine.LNX.4.63.0512271505030.3537@sripathi.in.ibm.com>
 <1135679117.4780.38.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Dec 2005, Benjamin Herrenschmidt wrote:

> On Tue, 2005-12-27 at 15:45 +0530, Sripathi Kodi wrote:
>
>>
>> Before your changes,  rtc_ioctl was implemented in the PPC  specific rtc.c and
>> it used  to call ppc_md.get_rtc_time  for RTC_RD_TIME,  which I think  used to
>> end  up  in  rtas_get_rtc_time.  After  your changes,  time  is  now  read  in
>> rtc_get_rtc_time using CMOS_READ calls, which apparently is resulting in wrong
>> values being  read. I changed  rtc_do_ioctl to make it  call rtas_get_rtc_time
>> for RTC_RD_TIME call and the problem went away.
>>
>> Have I  missed something or  does this  need fixing? Do  we really need  a PPC
>> specific rtc_ioctl call that calls into rtas_get_rtc_time?
>
> I think the problem is that you still have CONFIG_RTC in your .config
> instead of CONFIG_GEN_RTC
>
> Ben.

Yes, that was indeed the problem. Thanks a lot.

-Sripathi.
