Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751823AbWJGSlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbWJGSlo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 14:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751826AbWJGSlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 14:41:44 -0400
Received: from mail.parknet.jp ([210.171.160.80]:28172 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1751823AbWJGSln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 14:41:43 -0400
X-AuthUser: hirofumi@parknet.jp
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: [PATCH 01/10] -mm: clocksource: increase initcall priority
References: <20061006185439.667702000@mvista.com>
	<20061006185456.261581000@mvista.com>
	<87hcygqgl8.fsf@duaron.myhome.or.jp>
	<1160239878.21411.3.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	<87d594qa4o.fsf@duaron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 08 Oct 2006 03:41:36 +0900
In-Reply-To: <87d594qa4o.fsf@duaron.myhome.or.jp> (OGAWA Hirofumi's message of "Sun\, 08 Oct 2006 03\:00\:23 +0900")
Message-ID: <87lknsotnj.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:

> Daniel Walker <dwalker@mvista.com> writes:
>
>> On Sun, 2006-10-08 at 00:40 +0900, OGAWA Hirofumi wrote:
>>> Daniel Walker <dwalker@mvista.com> writes:
>>> 
>>> > Index: linux-2.6.17/drivers/clocksource/acpi_pm.c
>>> > ===================================================================
>>> > --- linux-2.6.17.orig/drivers/clocksource/acpi_pm.c
>>> > +++ linux-2.6.17/drivers/clocksource/acpi_pm.c
>>> > @@ -174,4 +174,4 @@ pm_good:
>>> >  	return clocksource_register(&clocksource_acpi_pm);
>>> >  }
>>> >  
>>> > -module_init(init_acpi_pm_clocksource);
>>> > +postcore_initcall(init_acpi_pm_clocksource);
>>> 
>>> Current code is assumeing DECLARE_PCI_FIXUP_EARLY() is called before
>>> init_acpi_pm_clocksource().
>>> 
>>> We'll need to change it.
>>
>> We can add a call to clocksource_rating_change() inside
>> acpi_pm_need_workaround(), are there deeper dependencies?
>
> There is no deeper dependencies.  If it's meaning
> clocksource_reselect() in current git, it sounds good to me.

Ah, I was forgetting why I didn't before. If it's a buggy pmtmr, we'll
get corrupted time until re-selecting the clocksource.

If anybody doesn't care this will be good with it. If not, we would
need to back to old one. IIRC, John did it.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
