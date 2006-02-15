Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750908AbWBOFIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbWBOFIu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 00:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbWBOFIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 00:08:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55532 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750908AbWBOFIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 00:08:50 -0500
Date: Tue, 14 Feb 2006 21:07:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       greg@kroah.com, kaneshige.kenji@jp.fujitsu.com
Subject: Re: [RFC][PATCH 1/4] PCI legacy I/O port free driver - Introduce
 pci_set_bar_mask*()
Message-Id: <20060214210744.3a7a756a.akpm@osdl.org>
In-Reply-To: <43F17379.8010900@jp.fujitsu.com>
References: <43F172BA.1020405@jp.fujitsu.com>
	<43F17379.8010900@jp.fujitsu.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com> wrote:
>
> This patch introduces a new interface pci_select_resource() for PCI
>  device drivers to tell kernel what resources they want to use.

It'd be nice if we didn't need to introduce any new API functions for this.
If we could just do:

struct pci_something pci_something_table[] = {
	...
	{
		...
		.dont_allocate_io_space = 1,
		...
	},
	...
};

within each driver which wants it.

But I can't think of a suitable per-device-id structure with which we can
do that :(

