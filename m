Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267325AbUIUFvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267325AbUIUFvm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 01:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267333AbUIUFvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 01:51:42 -0400
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:7328 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267325AbUIUFvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 01:51:38 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: acpi-devel@lists.sourceforge.net,
       Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Subject: Re: [ACPI] PATCH-ACPI based CPU hotplug[2/6]-ACPI Eject interface support
Date: Tue, 21 Sep 2004 00:51:36 -0500
User-Agent: KMail/1.6.2
Cc: "Brown, Len" <len.brown@intel.com>,
       LHNS list <lhns-devel@lists.sourceforge.net>,
       Linux IA64 <linux-ia64@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040920092520.A14208@unix-os.sc.intel.com> <200409201812.45933.dtor_core@ameritech.net> <20040920183845.C17763@unix-os.sc.intel.com>
In-Reply-To: <20040920183845.C17763@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409210051.36251.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 September 2004 08:38 pm, Keshavamurthy Anil S wrote:
> Currently I am handling both the surprise removal and the eject request in the same
> way, i,e send the notification to the userland and the usermode agent scripts
> is responsible for offlining of all the devices and then echoing onto eject file.
> 

I actually think that on the highest level we should treat controlled and
surprise ejects differently. With controlled ejects the system (kernel +
userspace) can abort the sequence if something goes wrong while with surprise
eject the device is physically gone. Even if driver refuses to detach or we
have partition still mounted or something else if physical device is gone we
don't have any choice except for trimming the tree and doing whatever we need
to do.

> My worry is if we implement a generic handler for BUS_CHECK, then what would you 
> do if the device fails to remove, i.e what action to take if the device remove fails?
> 

It could depend on parent's status. If parent is gone (surprise removal) we will
trim. If it is controlled removal and driver does not let device go we could
abort eject. 

Or we could always trim and offload the responsibility of having the system in
ready-to-eject state to the userspace. I.e. it should not write into "eject"
unless everything is unmounted/shut down/disconnected.

I am a bit light on implementation details though ;)

-- 
Dmitry
