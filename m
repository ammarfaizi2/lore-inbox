Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbVLMMXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbVLMMXz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 07:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbVLMMXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 07:23:55 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:15012 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750829AbVLMMXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 07:23:55 -0500
Subject: Re: [PATCH] Add mem_nmi_panic enable system to panic on hard error
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20051213064800.GB7401@redhat.com>
References: <439E6C58.6050301@jp.fujitsu.com>
	 <20051213064800.GB7401@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 13 Dec 2005 12:23:37 +0000
Message-Id: <1134476618.11732.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-12-13 at 01:48 -0500, Dave Jones wrote:
> On Tue, Dec 13, 2005 at 03:38:16PM +0900, Hidetoshi Seto wrote:
>  > Some x86 server fires NMI with reason 0x80 up if a parity error
>  > occurs on its PCI-bus system or DIMM module.
> 
> Hmm, are you sure this isn't a bios error misconfiguring
> some northbridge register perhaps ?  Some chipsets offer
> such reporting as a feature. Could be your server has this
> on by default.

This is done deliberately on some systems and is why we have the patches
I submitted to Andrew Morton which are in his tree and allow you to set
"panic_on_unrecovered_nmi" to halt on a memory error.

See the -mm tree. The functionality is there. Also see the various
x86-64 logging tools which can parse out MCE based reports.

> (I believe the EDAC code has also triggered similar cases
>  on certain cards which is why it too disables this checking
>  by default).

EDAC has it enabled by default at the moment, although it needs to clear
left over flags and possibly a small blacklist first.

> The sysctl seems pointless too. If this is needed at all,
> why would you ever want to turn it off ?

Debugging and stressing systems for one.

