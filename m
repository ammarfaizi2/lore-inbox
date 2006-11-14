Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755452AbWKNG5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755452AbWKNG5W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 01:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755450AbWKNG5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 01:57:21 -0500
Received: from hera.kernel.org ([140.211.167.34]:54481 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1755449AbWKNG5U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 01:57:20 -0500
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: earny@net4u.de
Subject: Re: 2.6.19-rc[1-4]: boot fail with (lapic && on_battery)
Date: Tue, 14 Nov 2006 01:59:59 -0500
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <200610312227.54617.list-lkml@net4u.de>
In-Reply-To: <200610312227.54617.list-lkml@net4u.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611140159.59926.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 October 2006 16:27, Ernst Herzberg wrote:

> With 2.6.18.x everything works fine.
> 
> But 2.16.19-rc does not boot if the laptop runs on battery _and_ lapic is 
> defined as boot parameter.

> Local APIC disabled by BIOS -- you can enable it with "lapic"

The BIOS is advising you here that it is a bad idea to enable the LAPIC on this system.
So why are you using the "lapic" boot parameter?

If you are running an CONFIG_SMP kernel with LAPIC enabled and deep C-states
(such as are available on Thinkpads when on battery mode), you will
run into the following bug:

http://bugzilla.kernel.org/show_bug.cgi?id=7376

As this is not new, the mystery is really why you see no problems in 2.6.18.
Perhaps you can forward the contents of /proc/interrupts for 2.6.18 with "lapic"
and we can see if the timer and the LOC are in sync or not when on battery?
/proc/acpi/processor/*/power will also tell us about the C-states --
dump it for both AC and battery mode.

thanks,
-Len
