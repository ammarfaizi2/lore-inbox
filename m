Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268702AbUI3EVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268702AbUI3EVK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 00:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268708AbUI3EVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 00:21:10 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:3752 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S268702AbUI3EVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 00:21:04 -0400
Date: Thu, 30 Sep 2004 13:22:46 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [ACPI] [PATCH] Updated patches for PCI IRQ resource deallocation
 support [2/3]
In-reply-to: <Pine.LNX.4.61.0409291809270.3056@musoma.fsmlabs.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>, Andrew Morton <akpm@osdl.org>,
       Greg Kroah-Hartmann <greg@kroah.com>, Len Brown <len.brown@intel.com>,
       tony.luck@intel.com, acpi-devel@lists.sourceforge.net,
       linux-ia64@vger.kernel.org
Message-id: <415B8A16.9070101@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: ja
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4)
 Gecko/20030624 Netscape/7.1 (ax)
References: <Pine.LNX.4.53.0409251356110.2914@musoma.fsmlabs.com>
 <Pine.LNX.4.53.0409251401560.2914@musoma.fsmlabs.com>
 <Pine.LNX.4.53.0409251416570.2908@musoma.fsmlabs.com>
 <4157A9D7.4090605@jp.fujitsu.com>
 <Pine.LNX.4.61.0409281702580.3052@musoma.fsmlabs.com>
 <415A28B9.6080504@jp.fujitsu.com>
 <Pine.LNX.4.61.0409291809270.3056@musoma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> 
> Ok i think i may have not conveyed my meaning properly, my mistake. What i 
> think would be better is if the architectures which have no-op 
> acpi_unregister_gsi to declare them as static inline in header files. For 
> architectures (such as ia64) which have a functional acpi_unregister_gsi, 
> we can declare them in a .c file with the proper exports etc.
> 

Now I (maybe) properly understand what you mean :-). But I still have one
concern about your idea.

For architectures which have a functional acpi_unregister_gsi, we need to
declare "extern void acpi_unregister_gsi(int gsi);" in include/linux/acpi.h
that is common to all architectures. I think include/linux/acpi.h is the
best place to declare it because acpi_register_gsi(), opposite portion of
acpi_unregister_gsi(), is declared in it. On the other hand, for archtectures
that have no-op acpi_unregister_gsi(), acpi_unregister_gsi() is defined as
static inline function in arch specific header files. This looks not natural
to me.

How do you think?

Thanks,
Kenji Kaneshige

