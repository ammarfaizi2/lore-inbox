Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWFSH33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWFSH33 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 03:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWFSH33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 03:29:29 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:33193 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932221AbWFSH32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 03:29:28 -0400
Date: Mon, 19 Jun 2006 16:30:53 +0900
From: "Akiyama, Nobuyuki" <akiyama.nobuyuk@jp.fujitsu.com>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [PATCH] kdump: add a missing notifier before
 crashing
Message-Id: <20060619163053.f0f10a5e.akiyama.nobuyuk@jp.fujitsu.com>
In-Reply-To: <m1odwtnjke.fsf@ebiederm.dsl.xmission.com>
References: <20060615201621.6e67d149.akiyama.nobuyuk@jp.fujitsu.com>
	<m1d5d9pqbr.fsf@ebiederm.dsl.xmission.com>
	<20060616211555.1e5c4af0.akiyama.nobuyuk@jp.fujitsu.com>
	<m1odwtnjke.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2006 10:37:05 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> > The processing of the notifier is to make a SCSI adaptor power off to
> > stop writing in the shared disk completely and then notify to standby-node.
> 
> The kernel has called panic no new SCSI operations were execute.
> I'm not saying don't notify your standby-node

As you say, the kernel does not do anything about SCSI operations.
But many SCSI adaptors flush their cache after a few seconds pass
after a SCSI write command is invoked, especially RAID cards.
To completely stop writing immediately, we should make the adaptor
power off.

> Please walk me through a real world kernel failure, and show me how
> your millisecond requirement is met.
> 
> In the example please answer:
> - What causes the kernel to call panic?
> - From the real failure to the kernel calling panic how long
>   does it take?

For instance, if a file system inconsistency is detected,
it takes few time until invoking panic.
I have seen various kernel failure so far and these will
unfortunately occur.

> - What actions does the notifier take to tell the other kernel
>   it is dead.

The operation is only writing to BMC a few times to use IPMI
interface. That operation using outb is very simple.

> - Why do we think the kernel taking that action will be reliable?

I agree the notifier may spoil reliability as compared with doing
nothing. It depends on quality of the notifier processing.
But I think the one is needed because it is more effective.

> - From the point where we call panic() how long does it take until
>   the kdump kernel is active?

On my box it takes about one second or so, but on a actual enterprise
system which have many disks(hundreds or more) it becomes more.

Thanks,

--
Akiyama, Nobuyuki

