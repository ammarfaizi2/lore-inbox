Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161268AbWI2CSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161268AbWI2CSQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 22:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161274AbWI2CSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 22:18:15 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:33934 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161268AbWI2CSO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 22:18:14 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: KDB blindly reads keyboard port 
In-reply-to: Your message of "Wed, 27 Sep 2006 16:11:00 CST."
             <200609271611.00701.bjorn.helgaas@hp.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 29 Sep 2006 12:18:04 +1000
Message-ID: <14425.1159496284@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas (on Wed, 27 Sep 2006 16:11:00 -0600) wrote:
>On Tuesday 26 September 2006 20:45, Keith Owens wrote:
>> No support for legacy I/O ports could be a bigger problem than just
>> KDB.
>
>On Itanium (and I suppose on x86), ACPI theoretically tells us enough
>that we don't need to assume any legacy resources.  Of course, Linux
>doesn't listen to everything ACPI is trying to tell it.  But that's
>a Linux deficiency we should remedy.
>
>> To fix just KDB, apply this patch over kdb-v4.4-2.6.18-common-1 and
>> add 'kdb_skip_keyboard' to the boot command line on the offending
>> hardware. 
>
>This doesn't feel like the right solution.  Since firmware tells us
>whether the device is present, I think we should rely on that.  If
>you want to use the device before ACPI is initialized, *then* you
>should pass a "kdb_use_keyboard" sort of flag.

I have never been a big fan of ACPI, having seen too many broken ACPI
tables.  But if that is what you want ...

Bjorn, could you apply my previous patch anyway, boot your problem
system with kdb_skip_keyboard, drop into KDB and
'md4c1 acpi_kbd_controller_present'.  That will quickly confirm if acpi
is detecting the absence of the keyboard on your system.

