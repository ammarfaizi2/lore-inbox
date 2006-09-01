Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbWIADyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWIADyc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 23:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbWIADyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 23:54:32 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:31161 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751097AbWIADyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 23:54:31 -0400
Date: Fri, 1 Sep 2006 12:56:48 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: "Bjorn Helgaas" <bjorn.helgaas@hp.com>
Cc: kmannth@us.ibm.com, bjorn.helgaas@hp.com, lenb@kernel.org,
       robert.moore@intel.com, shaohua.li@intel.com, malattia@linux.it,
       akpm@osdl.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: one more ACPI Error (utglobal-0125): Unknown exception code: 
 0xFFFFFFEA [Re: 2.6.18-rc4-mm3]
Message-Id: <20060901125648.11883533.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <49303.24.9.204.52.1157080555.squirrel@mail.cce.hp.com>
References: <B28E9812BAF6E2498B7EC5C427F293A4D850BB@orsmsx415.amr.corp.intel.com>
	<200608310248.29861.len.brown@intel.com>
	<1157042913.7859.31.camel@keithlap>
	<200608311707.00817.bjorn.helgaas@hp.com>
	<1157073592.5649.29.camel@keithlap>
	<49303.24.9.204.52.1157080555.squirrel@mail.cce.hp.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2006 21:15:55 -0600 (MDT)
"Bjorn Helgaas" <bjorn.helgaas@hp.com> wrote:

> Ok, this is starting to make sense.  It sounds like your memory
> device has _HID of PNP0C80 and _CID of PNP0C01 (or PNP0C02).
> 
> The current ACPI driver binding algorithm in acpi_bus_find_driver()
> looks at each driver, checking whether it can match either the _HID
> or the _CID of a device.  Since we try the motherboard driver first,
> it matches the memory device _CID.
> 
> I couldn't find a specific reference in the spec, but this seems
> intuitively sub-optimal.  It seems like it'd be better to look
> first for a driver that can claim the _HID (which is more specific),
> and only fall back to checking the _CIDs if no _HID-specific driver
> is found.
> 
I like it :)

-Kame

