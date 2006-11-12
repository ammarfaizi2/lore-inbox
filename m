Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753367AbWKLWU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753367AbWKLWU6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 17:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753370AbWKLWU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 17:20:58 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:46472 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1753367AbWKLWU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 17:20:57 -0500
Date: Sun, 12 Nov 2006 22:20:51 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Nathan Lynch <ntl@pobox.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [PATCH] nvidiafb: fix unreachable code in nv10GetConfig
In-Reply-To: <20061108220422.GL17028@localdomain>
Message-ID: <Pine.LNX.4.64.0611122220240.9472@pentafluge.infradead.org>
References: <20061108195511.GK17028@localdomain> <20061108121311.29dd0bda.akpm@osdl.org>
 <20061108220422.GL17028@localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Andrew Morton wrote:
>> On Wed, 8 Nov 2006 13:55:11 -0600
>> Nathan Lynch <ntl@pobox.com> wrote:
>>
>>> Fix binary/logical operator typo which leads to unreachable code.
>>> Noticed while looking at other issues; I don't have the relevant
>>> hardware to test this.
>>>
>>>
>>> Signed-off-by: Nathan Lynch <ntl@pobox.com>
>>>
>>> --- linux-2.6-powerpc.git.orig/drivers/video/nvidia/nv_setup.c
>>> +++ linux-2.6-powerpc.git/drivers/video/nvidia/nv_setup.c
>>> @@ -262,7 +262,7 @@ static void nv10GetConfig(struct nvidia_
>>>  #endif
>>>
>>>  	dev = pci_find_slot(0, 1);
>>> -	if ((par->Chipset && 0xffff) == 0x01a0) {
>>> +	if ((par->Chipset & 0xffff) == 0x01a0) {
>>>  		int amt = 0;
>>>
>>>  		pci_read_config_dword(dev, 0x7c, &amt);
>>
>> That looks like a pretty significant bug.  It'll cause the kernel to
>> potentially map the wrong amount of memory for all cards except the
>> NV_ARCH_04 type.  Has been there for over a year though.  hmm..
>
> Did some searching, and assuming that chipset == PCI device id
> (dubious?), I think the bug would affect only some integrated GeForce2
> cards, which are somewhat old.
>
> It looks to me like the other devices handled by nv10GetConfig would
> still be handled as intended, but I'm not familiar with this code.
>

Your assumption is correct :-)

