Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbVFHUMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbVFHUMP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 16:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVFHUMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 16:12:15 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:60398 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261593AbVFHUML convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 16:12:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=IXjPeqd6F4s8CoPfhCcgCWSJuaXu+tjyR18LnWdGqogBkJeQNS5rDHr/rhyLRkgR69NqL2eWyHK07SYuF9Y+mFVQdg+QValRlalgo13LEQNC1os0g2mo3FAXfErIzbYgD32znS/8Jc1hxd7pnCkJWZtP5iiBwvIiP0czI0T9d3w=
Message-ID: <9e47339105060813115d01282@mail.gmail.com>
Date: Wed, 8 Jun 2005 16:11:39 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Dell BIOS and HPET timer support
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After several communications with Dell support I have determined that
most Dell BIOSs don't include the ACPI entry for the HPET timer. The
official reason for this is that no version of Windows uses the HPET
and adding the ACPI entry might cause compatibility problems.

So I added this to force the HPET on:
   extern unsigned long hpet_address;
   hpet_address = 0xfed00000ULL;

Now my HPET seems to be working:
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 0ns tick, 3 64-bit timers
Using HPET for base-timer
Using HPET for gettimeofday

What does the 0ns tick mean, is this bad? Is there any way to verify
my HPET is working correctly? My date/time is advancing.

If my HPET is working correctly is it ok to add a probe to find the timer?

-- 
Jon Smirl
jonsmirl@gmail.com
