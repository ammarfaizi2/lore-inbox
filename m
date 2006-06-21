Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWFUBUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWFUBUg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 21:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbWFUBUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 21:20:36 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49353 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750768AbWFUBUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 21:20:34 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Rajesh Shah <rajesh.shah@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       discuss@x86-64.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
       Natalie Protasevich <Natalie.Protasevich@UNISYS.com>,
       Len Brown <len.brown@intel.com>,
       Kimball Murray <kimball.murray@gmail.com>,
       Brice Goglin <brice@myri.com>, Greg Lindahl <greg.lindahl@qlogic.com>,
       Dave Olson <olson@unixfolk.com>, Jeff Garzik <jeff@garzik.org>,
       Greg KH <gregkh@suse.de>, Grant Grundler <iod00d@hp.com>,
       "bibo,mao" <bibo.mao@intel.com>, Mark Maule <maule@sgi.com>,
       Jesper Juhl <jesper.juhl@gmail.com>, Shaohua Li <shaohua.li@intel.com>,
       Matthew Wilcox <matthew@wil.cx>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Ashok Raj <ashok.raj@intel.com>, Randy Dunlap <rdunlap@xenotime.net>,
       Roland Dreier <rdreier@cisco.com>, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 4/25] msi: Simplify msi enable and disable.
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com>
	<11508425183073-git-send-email-ebiederm@xmission.com>
	<11508425191381-git-send-email-ebiederm@xmission.com>
	<11508425192220-git-send-email-ebiederm@xmission.com>
	<11508425191063-git-send-email-ebiederm@xmission.com>
	<20060620174424.B10402@unix-os.sc.intel.com>
Date: Tue, 20 Jun 2006 19:19:36 -0600
In-Reply-To: <20060620174424.B10402@unix-os.sc.intel.com> (Rajesh Shah's
	message of "Tue, 20 Jun 2006 17:44:24 -0700")
Message-ID: <m1irmvb907.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rajesh Shah <rajesh.shah@intel.com> writes:

> On Tue, Jun 20, 2006 at 04:28:17PM -0600, Eric W. Biederman wrote:
>> 
>> @@ -937,27 +936,8 @@ int pci_enable_msi(struct pci_dev* dev)
>>  	if (!pos)
>>  		return -EINVAL;
>>  
>> -	if (!msi_lookup_vector(dev, PCI_CAP_ID_MSI)) {
>> -		/* Lookup Sucess */
>> -		unsigned long flags;
>> +	BUG_ON(!msi_lookup_vector(dev, PCI_CAP_ID_MSI));
>>  
> A driver that calls pci_enable_msi() while MSI is already enabled
> will hit this BUG_ON. This is different from the behavior of
> some other pci functions like pci_enable_device(), which
> silently return success if the requested operation is a nop.
> It's pretty easy to do the same here too (ditto for MSI-X).

With MSI-X we can't be a NOOP so it is clearly a bug.

With MSI it might happen, and I don't have a problem if it becomes
a noop.  At the same time I'm not convinced it isn't a bug.

All I really care about is that we don't try and do the impossible and
enable the msi from a half initialized software state like we were doing
before.

That was really ugly and impossible to get right.

Eric
