Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbVDJN3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbVDJN3P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 09:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVDJN3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 09:29:15 -0400
Received: from one.firstfloor.org ([213.235.205.2]:35531 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261496AbVDJN3M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 09:29:12 -0400
To: Ross Biro <rossb@google.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC/Patch 2.6.11] Take control of PCI Master Abort Mode
References: <4252E827.4080807@google.com>
From: Andi Kleen <ak@muc.de>
Date: Sun, 10 Apr 2005 15:29:10 +0200
In-Reply-To: <4252E827.4080807@google.com> (Ross Biro's message of "Tue, 05
 Apr 2005 12:33:59 -0700")
Message-ID: <m14qee221l.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Biro <rossb@google.com> writes:
>
> I even have a single motherboard with both a device that cannot handle
> the target abort and an IDE controller that can handle the target
> abort behind the same bridge.  For this motherboard, I have to choose
> the lesser of two evils, network hiccups or potential data corruption.
> For the record, I have seen both occur.  Other people may make wish to
> make a different choice than we did, hence this patch allows the user
> to choose the mode at runtime.

I think it is totally wrong to make this Configs and boot options.
Nobody can do anything with such obscure boot configurations
and it is bad to require kernel recompiles for such things.

The right way to do this would be to have sysfs knobs that allow
to change these bits, and then let a user space tool change
it depending on PCI-ID. If the issue is critical enough
that it happens very often then it should be added to kernel
pci quirks - but again be unconditional.

-Andi
