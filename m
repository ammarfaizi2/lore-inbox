Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262867AbVA2Gdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262867AbVA2Gdu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 01:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262871AbVA2Gdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 01:33:49 -0500
Received: from one.firstfloor.org ([213.235.205.2]:10722 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262867AbVA2Gde
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 01:33:34 -0500
To: Christopher Li <chrisl@vmware.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: compat ioctl for submiting URB
References: <20050128212304.GA11024@64m.dyndns.org>
From: Andi Kleen <ak@muc.de>
Date: Sat, 29 Jan 2005 07:33:31 +0100
In-Reply-To: <20050128212304.GA11024@64m.dyndns.org> (Christopher Li's
 message of "Fri, 28 Jan 2005 16:23:04 -0500")
Message-ID: <m1llaclp6s.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Li <chrisl@vmware.com> writes:

> VMware is a big user of the usbdevfs, we translate guest USB
> IO to usbdevfs, by submitting URB. On the x86_64 system, we
> need those compatible ioctl for submitting URBs. For now we
> make a hack to submit it through the vmmon driver. But that
> is very ugly. 
>
> I do want this problem get fixed in the linux kernel eventually.
> I have been toying with two different ways to solve it. It seems
> that it is unavoidable to get hands dirty in the usbdevfs internals.
> The first one is just educate the usbdevfs to know about the 32 bit
> URB ioctls. So it don't need to keep around a bounce buffer.

Looks reasonable from a first look.

Issues:
- Should use CONFIG_COMPAT, not x86-64 specific symbols
- Why can't you set URB_COMPAT transparently in the emulation
layer?  Then existing applications would hopefully work without
changes, right?

You may also want to preserve the __user casts, otherwise
Al Viro and other sparse users will be unhappy.

Thanks for attacking this long standing problem.

-Andi

