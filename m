Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932520AbWJGSAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbWJGSAr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 14:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbWJGSAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 14:00:47 -0400
Received: from mail.parknet.jp ([210.171.160.80]:22284 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S932521AbWJGSAb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 14:00:31 -0400
X-AuthUser: hirofumi@parknet.jp
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: [PATCH 01/10] -mm: clocksource: increase initcall priority
References: <20061006185439.667702000@mvista.com>
	<20061006185456.261581000@mvista.com>
	<87hcygqgl8.fsf@duaron.myhome.or.jp>
	<1160239878.21411.3.camel@c-67-180-230-165.hsd1.ca.comcast.net>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 08 Oct 2006 03:00:23 +0900
In-Reply-To: <1160239878.21411.3.camel@c-67-180-230-165.hsd1.ca.comcast.net> (Daniel Walker's message of "Sat\, 07 Oct 2006 09\:51\:18 -0700")
Message-ID: <87d594qa4o.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker <dwalker@mvista.com> writes:

> On Sun, 2006-10-08 at 00:40 +0900, OGAWA Hirofumi wrote:
>> Daniel Walker <dwalker@mvista.com> writes:
>> 
>> > Index: linux-2.6.17/drivers/clocksource/acpi_pm.c
>> > ===================================================================
>> > --- linux-2.6.17.orig/drivers/clocksource/acpi_pm.c
>> > +++ linux-2.6.17/drivers/clocksource/acpi_pm.c
>> > @@ -174,4 +174,4 @@ pm_good:
>> >  	return clocksource_register(&clocksource_acpi_pm);
>> >  }
>> >  
>> > -module_init(init_acpi_pm_clocksource);
>> > +postcore_initcall(init_acpi_pm_clocksource);
>> 
>> Current code is assumeing DECLARE_PCI_FIXUP_EARLY() is called before
>> init_acpi_pm_clocksource().
>> 
>> We'll need to change it.
>
> We can add a call to clocksource_rating_change() inside
> acpi_pm_need_workaround(), are there deeper dependencies?

There is no deeper dependencies.  If it's meaning
clocksource_reselect() in current git, it sounds good to me.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
