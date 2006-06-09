Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030405AbWFITNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030405AbWFITNK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 15:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030418AbWFITNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 15:13:10 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:27216 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1030405AbWFITNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 15:13:09 -0400
Message-ID: <4489C83F.40307@tls.msk.ru>
Date: Fri, 09 Jun 2006 23:13:03 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: klibc - another libc?
References: <44869397.4000907@tls.msk.ru> <Pine.LNX.4.64.0606080036250.17704@scrub.home> <e69fu3$5ch$1@terminus.zytor.com> <Pine.LNX.4.64.0606091409220.17704@scrub.home> <e6cgjv$b8t$1@terminus.zytor.com>
In-Reply-To: <e6cgjv$b8t$1@terminus.zytor.com>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
[]
>>  Let's take booting from raid, in this case you need to install
>> mdadm anyway, which could also provide an initramfs version. This
>> way the setup tools can be generated from the same source, which
>> reduces duplication and maintenance overhead.
> 
> You don't need mdadm to boot from RAID.  kinit handles it just fine.

You *do* need mdadm to boot from RAID.  Unless you rely on broken,
obsolete, "don't use" in-kernel raid autodetection code (which, in
this case, will be moved from kernel space into kinit).  There are
many reasons why raid autodetection in its current form is not a good
idea, all goes to simple "unreliable" definition - there where many
discussions about this already.

Well ok, mdadm/Assemble.c can be merged into kinit instead of current
stuff present there, and adopted somehow.  Until when, mdadm IS
necessary.

Ok, the next question may be 'and what about lvm?', or dm, or whatever
else..  Md autodetection code has been in kernel for a long time,
while lvm/dm/etc stuff wasn't.  So there IS a difference... ;)

But I see a reason for kinit *now*, in its current form - it's
compatibility.  Later on, maybe the whole stuff can be removed entirely,
to rely on external tools for booting.  Existing mkinitrd/mkinitramfs/
etc solutions works, they're being improved all the time, and they
don't use kinit.

Did I get it all right?  :)

Thanks.

/mjt
