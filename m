Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbVGSKlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbVGSKlm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 06:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbVGSKlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 06:41:42 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7317 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261610AbVGSKlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 06:41:42 -0400
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.12-git8] ACPI shutdown fails to power off machine
References: <20050709203402.GA4621@localhost>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 19 Jul 2005 04:41:26 -0600
In-Reply-To: <20050709203402.GA4621@localhost> (Jose Luis Domingo Lopez's
 message of "Sat, 9 Jul 2005 22:34:03 +0200")
Message-ID: <m1r7dvgjs9.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jose Luis Domingo Lopez <linux-kernel@24x7linux.com> writes:

> Hi:
>
> I realized 2.6.13-rc2 would not power off my box anymore, although it
> worked fine back in 2.6.12. A binary search of intermediate -git patches
> showed that between -git7 and -git8 something broke power down. Every
> kernel used has been compiled from sources downloaded from kernel.org, no
> additional patches, and .config has been exactly the same.
>
> Searching "gitweb" located at www.kernel.org (excelent tool, by the way;
> you rock guys!) starting from "patch-2.6.12-git8.id" tag back in time, I
> located a recent commited patch that, when reversed (against 2.6.12-git8)
> makes power off work again in my box. Patch at:
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=cee5dab4856f51c5cad3aecc630ad0a4d2217a85
>
> The commit text points to a bugme entry, that seems not to be applicable
> to my situation: stock kernel sources from kernel.org. If you need some
> more info (motherboard make and model, BIOS and version, output from
> "lshw" or "dmidecode", etc.), please ask.

Thanks.  Before I forget I want to ack this.  I think you are correct
and I have a hunch on what might be done to fix this but I haven't found
the couple of hours needed to handle that.

In essence I don't believe the semantics of the reboot path are consistent
between the expectations of the various functions and I my patches stirred
the pot so a different set of things work and fail now than before.

Roughly for your part of the problem the acpi shutdown code needs to
get called sooner when interrupts are still enabled. 

Eric

