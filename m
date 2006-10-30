Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030549AbWJ3RWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030549AbWJ3RWe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 12:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030559AbWJ3RWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 12:22:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24203 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030549AbWJ3RWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 12:22:32 -0500
Message-ID: <4546345E.3050706@ce.jp.nec.com>
Date: Mon, 30 Oct 2006 12:20:30 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
CC: Martin Lorenz <martin@lorenz.eu.org>, Pavel Machek <pavel@suse.cz>,
       Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       len.brown@intel.com, linux-acpi@vger.kernel.org, linux-pm@osdl.org,
       "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: 2.6.19-rc3: known unfixed regressions (v3)
References: <45462591.7020200@ce.jp.nec.com> <20061030163223.GK1941@mellanox.co.il>
In-Reply-To: <20061030163223.GK1941@mellanox.co.il>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Michael S. Tsirkin wrote:
>> The code is related to bd_claim_by_disk which is called when
>> device-mapper or md tries to mark the underlying devices
>> for exclusive use and creates symlinks from/to the devices
>> in sysfs. The patch added error handlings which weren't in
>> the original code.
>>
>> I have no idea how it affects ACPI event handling.
> 
> It's a mystery. Probably exposes a bug somewhere?
> 
>> Are you using dm and/or md on your machine?
> 
> The .config is attached to bugzilla.

OK, I found you disabled CONFIG_MD, which means neither
dm.ko nor md.ko was built.
Do you have any out-of-tree kernel modules which call either
bd_claim_by_kobject or bd_claim_by_disk?

If you aren't using either of them, I'm afraid reverting
the patch doesn't really solve your problem because the patched
code is called only from them.

>> Have you seen any unusual kernel messages or symptoms regarding
>> dm/md before the ACPI problem occurs?
> 
> I haven't.

Thanks,
-- 
Jun'ichi Nomura, NEC Corporation of America
