Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbUCEEww (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 23:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262212AbUCEEww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 23:52:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7391 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262210AbUCEEwu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 23:52:50 -0500
Message-ID: <40480795.5000402@pobox.com>
Date: Thu, 04 Mar 2004 23:52:37 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Brown, Len" <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Hyper-threaded pickle
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So,

Just now getting my dual athlon going under 2.6.x.  It _really_ doesn't 
like ACPI.

ACPI specifications dictate some hardware characteristics, as well as 
specifying table structures and such.  One of those characteristics is 
the 4-second poweroff:  if you hold down the power button for 4-5 
seconds, your motherboard is required to poweroff the machine.  This is 
supposed to be a hard poweroff, and on most machines this works even 
when various pieces of hardware are frozen/locked-up.

Turning on ACPI kills my 4-second poweroff, which is pretty darn 
impressive.  So I proceed to disable ACPI...  but CONFIG_ACPI_BOOT 
doesn't want to disable.  I am trying to restore my working, non-ACPI 
configuration under 2.6, but this seems to be preventing me from doing so:

drivers/acpi/Kconfig:
config ACPI_BOOT
         bool
         depends on ACPI || X86_HT
         default y

arch/i386/Kconfig:
config X86_HT
         bool
         depends on SMP && !(X86_VISWS || X86_VOYAGER)
         default y

My dual athlon _definitely_ doesn't have hyperthreading, and I am 
willing to bet that force-enabling the ACPI boot and HT code for all SMP 
machines breaks other older-SMP boxes as well.

	Jeff




