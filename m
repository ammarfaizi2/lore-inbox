Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVC2Qwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVC2Qwp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 11:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVC2Qwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 11:52:45 -0500
Received: from ns1.coraid.com ([65.14.39.133]:27091 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S261198AbVC2Qwn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 11:52:43 -0500
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, Greg K-H <greg@kroah.com>
Subject: Re: [PATCH 2.6.11] aoe [7/12]: support configuration of
 AOE_PARTITIONS from Kconfig
References: <87mztbi79d.fsf@coraid.com> <20050317234641.GA7091@kroah.com>
	<1111677688.29912@geode.he.net> <20050328170735.GA9567@infradead.org>
	<87hdiuv3lz.fsf@coraid.com> <20050329162506.GA30401@infradead.org>
From: Ed L Cashin <ecashin@coraid.com>
Date: Tue, 29 Mar 2005 11:48:48 -0500
In-Reply-To: <20050329162506.GA30401@infradead.org> (Christoph Hellwig's
 message of "Tue, 29 Mar 2005 17:25:06 +0100")
Message-ID: <87wtrqtn2n.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Tue, Mar 29, 2005 at 11:06:16AM -0500, Ed L Cashin wrote:
>> >
>> > NACK.  this changes devices nodes based on a compile-time option.  
>> 
>> I'm not sure I follow.  This configuration option sets the number of
>> partitions per device in the driver.  It doesn't create device nodes.
>> 
>> If the user has udev, then the device nodes are created correctly (on
>> Fedora Core 3), so that if the driver is configured with 1 partition
>> per device, the minor numbers for the disks are low.  
>> 
>> The folks I've talked to who aren't using udev but want one partition
>> per device already know that they have to re-create their device
>> files.
>
> It changes a kernel ABI, so people that have different config options
> set can't use the same userland.  It's a really big no-go.

I don't know if it matters now that we have udev.  When udev manages
the device nodes it all just works, so there's practically not much of
an issue.  The UUIDs in Software RAID and LVM make this even less of
an issue.  Besides, if they aren't using udev and are using a custom
kernel *and* using this configure option, then they're changing the
ABI on purpose for a practical benefit.

If you're saying that it's bad in principal, then that's another
story.  If that's what you mean, then it's a Linux policy issue, and
to follow convention I'd think that we'd need another major number.
That would be like the partitionable md devices, etc.

To me, the latter seems like the uglier way to go, and it would be
more permanent, while the configure option seems ugly but convenient
for this transitional stage, and could go away when high minor numbers
are well supported on the systems currently in use.

-- 
  Ed L Cashin <ecashin@coraid.com>

