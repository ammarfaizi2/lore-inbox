Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965292AbWCWHbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965292AbWCWHbM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 02:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965293AbWCWHbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 02:31:11 -0500
Received: from mail.parknet.jp ([210.171.160.80]:8456 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S965292AbWCWHbK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 02:31:10 -0500
X-AuthUser: hirofumi@parknet.jp
To: Andrew Morton <akpm@osdl.org>
Cc: kernel@kolivas.org, johnstul@us.ibm.com, andi@rhlx01.fht-esslingen.de,
       bert.hubert@netherlabs.nl, linux-kernel@vger.kernel.org,
       george@mvista.com
Subject: Re: [PATCH] PM-Timer: doesn't use workaround if chipset is not buggy
References: <20060320122449.GA29718@outpost.ds9a.nl>
	<1142968999.4281.4.camel@leatherman>
	<8764m7xzqg.fsf@duaron.myhome.or.jp>
	<200603221121.16168.kernel@kolivas.org>
	<87hd5qmi1d.fsf_-_@duaron.myhome.or.jp>
	<20060322134633.46389249.akpm@osdl.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 23 Mar 2006 16:31:01 +0900
In-Reply-To: <20060322134633.46389249.akpm@osdl.org> (Andrew Morton's message of "Wed, 22 Mar 2006 13:46:33 -0800")
Message-ID: <87irq539e2.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>>
>> +	dev = pci_get_device(PCI_VENDOR_ID_INTEL,
>> +			     PCI_DEVICE_ID_INTEL_82371AB_3, NULL);
>>
>> ...
>>
>> +device_initcall(pmtmr_bug_check);
>
> Can this code use the PCI quirk infrastructure?

Yes. However, since we need to check there is _not_ those chipsets,
it's tricky. Probably it's a following or similar code, um.. IMHO it
seems not simple enough. Idea?


static void __devinit blacklist_check()
{
	has_bug = 1;
}
DECLARE_PCI_FIXUP_EARLY(blacklist);

static void __devinit graylist_check()
{
	has_bug = 2;
}
DECLARE_PCI_FIXUP_EARLY(graylist);

static int __init pmtmr_bug_check()
{
	if (!has_bug)
		pmtmr_need_workaround = 0;
	else
        	...
}
late_initcall(pmtmr_bug_check);
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
