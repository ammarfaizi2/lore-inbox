Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946096AbWJSOrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946096AbWJSOrt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 10:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946099AbWJSOrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 10:47:48 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:26297 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1946096AbWJSOrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 10:47:48 -0400
Subject: Re: [PATCH 1/7] KVM: userspace interface
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Stoffel <john@stoffel.org>
Cc: Avi Kivity <avi@qumranet.com>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <17719.35854.477605.398170@smtp.charter.net>
References: <4537818D.4060204@qumranet.com> <453781F9.3050703@qumranet.com>
	 <17719.35854.477605.398170@smtp.charter.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Oct 2006 15:50:05 +0100
Message-Id: <1161269405.17335.80.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-19 am 10:30 -0400, ysgrifennodd John Stoffel:
> Avi> This patch defines a bunch of ioctl()s on /dev/kvm.  The ioctl()s
> Avi> allow adding memory to a virtual machine, adding a virtual cpu to
> Avi> a virtual machine (at most one at this time), transferring
> Avi> control to the virtual cpu, and querying about guest pages
> Avi> changed by the virtual machine.
> 
> Yuck.  ioclts are deprecated, you should be using /sysfs instead for
> stuff like this, or configfs.  

Bzzt Wrong answer, please try again 8)

The kernel summit discussions were very much that ioctl has its place,
and that the sysfs extremists were wrong. sysfs has its place (views
ranging from that being /dev/null upwards) but sysfs is useless for many
kinds of interface including those with read/write or other
synchronization properties, those that trigger actions and those that
are tied to the file handle you are working with. An executing VM
interface via sysfs is a ludicrous concept.

Making sure the ioctl sizes are the same in 32/64bit and aligned the
same way is the more important issue.

Alan

